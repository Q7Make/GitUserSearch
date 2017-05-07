//
//  UserInfoViewController.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PYSearchConst.h"
#import "UserInfoModel.h"
#import "UserInfoTableViewCell.h"
#import "SDAutoLayout.h"
#import "HeaderModel.h"

NSString *const CELL_REUSE_ID1 = @"CELL_REUSE_ID";

@interface UserInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_headerView;
    NSMutableArray *_userListArr;
    UserInfoModel *_userInfoModel;
    UITableView *_tableView;
    HeaderModel *_headerModel;
    
    UIImageView *_avatarImageV;
    UILabel *_loginLab;
    UILabel *_locationLab;
    UILabel *_bioLab;
    UILabel *_followerLab1;
    UILabel *_followerLab2;
    UILabel *_followingLab1;
    UILabel *_followingLab2;
    UILabel *_reposLab1;
    UILabel *_reposLab2;
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _userName;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //去掉弹性
    _tableView.bounces = NO;
    _tableView.rowHeight = 70;
    //去掉分割线
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //设置tableview背景图
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        _tableView.backgroundView = imageV;
    [self.view addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"bg_header_back"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = buttonItem;
    [btn addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice) name:@"reposList" object:nil];
    [center addObserver:self selector:@selector(notice1) name:@"header" object:nil];
    
    [self creatHeadView];
}

- (void)BackButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _userInfoModel = [[UserInfoModel alloc] init];
    [_userInfoModel requestDataWithUrl:_reposUrl];
    
    _headerModel = [[HeaderModel alloc] init];
    [_headerModel requestDataWithUrl:_userUrl];
    
}

- (void)notice {
    [_userListArr removeAllObjects];
    _userListArr = [NSMutableArray arrayWithArray:_userInfoModel.dataArr];
    NSLog(@"------%lu", (unsigned long)_userListArr.count);
    [_tableView reloadData];
}

- (void)notice1 {
    
    //_headerModel = _headerModel.headerM;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_avatarUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _avatarImageV.image = image;
        });
    });
    
    _loginLab.text = [NSString stringWithFormat:@"%@(%@)",_userName, _headerModel.name];
    _locationLab.text = [_headerModel.location stringByRemovingPercentEncoding];
    _bioLab.text = _headerModel.bio;
    _followerLab1.text = [NSString stringWithFormat:@"%@", _headerModel.followers];
    _followingLab1.text = [NSString stringWithFormat:@"%@", _headerModel.following];
    _reposLab1.text = [NSString stringWithFormat:@"%@", _headerModel.public_repos];
}

- (void)creatHeadView
{
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:_headView];不用添加
    
    _headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(180);
    
    _avatarImageV = [[UIImageView alloc] init];
    _avatarImageV.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageV.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_avatarImageV];
    _avatarImageV.sd_layout
    .leftSpaceToView(_headerView, 10)
    .topSpaceToView(_headerView, 10)
    .widthIs(75)
    .heightIs(75);
    
    _loginLab = [[UILabel alloc] init];
    _loginLab.font = [UIFont systemFontOfSize:13];
    _loginLab.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_loginLab];
    _loginLab.sd_layout
    .leftSpaceToView(_avatarImageV, 0)
    .topSpaceToView(_headerView, 17.5)
    .rightSpaceToView(_headerView, 10)
    .heightIs(30);
    
    _locationLab = [[UILabel alloc] init];
    _locationLab.font = [UIFont systemFontOfSize:13];
    _locationLab.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_locationLab];
    _locationLab.sd_layout
    .leftEqualToView(_loginLab)
    .rightEqualToView(_loginLab)
    .topSpaceToView(_loginLab, 0)
    .heightIs(30);
    
    _bioLab = [[UILabel alloc] init];
    _bioLab.font = [UIFont systemFontOfSize:13];
    _bioLab.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_bioLab];
    _bioLab.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_avatarImageV, 0)
    .rightSpaceToView(_headerView, 10)
    .heightIs(30);
    
    float w = ([[UIScreen mainScreen] bounds].size.width - 20)/3;
    
    _followerLab1 = [[UILabel alloc] init];
    _followerLab1.font = [UIFont systemFontOfSize:13];
    _followerLab1.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_followerLab1];
    _followerLab1.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_bioLab, 0)
    .heightIs(30)
    .widthIs(w);
    
    _followerLab2 = [[UILabel alloc] init];
    _followerLab2.font = [UIFont systemFontOfSize:13];
    _followerLab2.backgroundColor = PYSEARCH_RANDOM_COLOR;
    _followerLab2.text = @"FOLLOWER";
    [_headerView addSubview:_followerLab2];
    _followerLab2.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_followerLab1, 0)
    .heightIs(30)
    .widthIs(w);
    
    _followingLab1 = [[UILabel alloc] init];
    _followingLab1.font = [UIFont systemFontOfSize:13];
    _followingLab1.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_followingLab1];
    _followingLab1.sd_layout
    .leftSpaceToView(_followerLab1, 0)
    .topSpaceToView(_bioLab, 0)
    .heightIs(30)
    .widthIs(w);
    
    _followingLab2 = [[UILabel alloc] init];
    _followingLab2.font = [UIFont systemFontOfSize:13];
    _followingLab2.backgroundColor = PYSEARCH_RANDOM_COLOR;
    _followingLab2.text = @"FOLLOWING";
    [_headerView addSubview:_followingLab2];
    _followingLab2.sd_layout
    .leftEqualToView(_followingLab1)
    .topSpaceToView(_followerLab1, 0)
    .heightIs(30)
    .widthIs(w);
    
    _reposLab1 = [[UILabel alloc] init];
    _reposLab1.font = [UIFont systemFontOfSize:13];
    _reposLab1.backgroundColor = PYSEARCH_RANDOM_COLOR;
    [_headerView addSubview:_reposLab1];
    _reposLab1.sd_layout
    .leftSpaceToView(_followingLab1, 0)
    .topSpaceToView(_bioLab, 0)
    .heightIs(30)
    .widthIs(w);
    
    _reposLab2 = [[UILabel alloc] init];
    _reposLab2.font = [UIFont systemFontOfSize:13];
    _reposLab2.backgroundColor = PYSEARCH_RANDOM_COLOR;
    _reposLab2.text = @"REPOS";
    [_headerView addSubview:_reposLab2];
    _reposLab2.sd_layout
    .leftEqualToView(_reposLab1)
    .topSpaceToView(_reposLab1, 0)
    .heightIs(30)
    .widthIs(w);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}


//分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_REUSE_ID1];
    }
    
    UserInfoModel *model = [_userListArr objectAtIndex:indexPath.row];
    [cell setName:model.name descriptin:model.descriptionStr language:model.language stars:model.stars];
    NSLog(@"==%@",model.name);
    
    //cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
