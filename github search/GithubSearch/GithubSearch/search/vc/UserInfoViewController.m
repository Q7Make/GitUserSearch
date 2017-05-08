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
#import "MBProgressHUD.h"
#import "Utilities.h"
#import "HeaderView.h"
#import "UIImageView+WebCache.h"

NSString *const CELL_REUSE_ID1 = @"CELL_REUSE_ID";
NSString *const LOADING = @"Loading...";
NSString *const BIOTEXT = @"This guy is too lazy to leave anything here!";

@interface UserInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_userListArr;
    UserInfoModel *_userInfoModel;
    UITableView *_tableView;
    HeaderModel *_headerModel;
    MBProgressHUD *_hud;
    HeaderView *_headerV;
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _userName;
    
    [self creatUI];
    [self changeBackBtn];
    [self creatHeadView];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice) name:@"reposList" object:nil];
    [center addObserver:self selector:@selector(notice1) name:@"header" object:nil];
}

- (void)creatUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.rowHeight = 60;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _tableView.backgroundView = imageV;
    [self.view addSubview:_tableView];
    //添加HUD
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeDeterminate;
    _hud.labelText = LOADING;
}
//去掉HUD
- (void)removeHUD {
    _hud.hidden =YES;
    if( _hud ) {
        [_hud hide:YES];
        _hud = nil;
    }
}

- (void)changeBackBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"bg_header_back"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = buttonItem;
    [btn addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)BackButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _userInfoModel = [[UserInfoModel alloc] init];
    [_userInfoModel requestDataWithUrl:_reposUrl];
    _headerModel = [[HeaderModel alloc] init];
    [_headerModel requestDataWithUrl:_userUrl];
    
}

- (void)notice {
    [self removeHUD];
    [_userListArr removeAllObjects];
    _userListArr = [NSMutableArray arrayWithArray:_userInfoModel.dataArr];
    //NSLog(@"------%lu", (unsigned long)_userListArr.count);
    [_tableView reloadData];
}

- (void)notice1 {
    
    [self removeHUD];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_avatarUrl]];
//        UIImage *image = [UIImage imageWithData:imageData];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            _headerV.avatarImageV.image = image;
//        });
//    });
    [_headerV.avatarImageV sd_setImageWithURL:[NSURL URLWithString:_avatarUrl]
                 placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    
    _headerV.loginLab.text = [NSString stringWithFormat:@"%@(%@)",_userName, _headerModel.name];
    _headerV.locationLab.text = [_headerModel.location stringByRemovingPercentEncoding];
    if ([Utilities isBlankString:_headerModel.bio]) {
        _headerV.bioLab.text = BIOTEXT;
    } else {
       _headerV.bioLab.text = _headerModel.bio;
    }
    _headerV.followerLab1.text = [NSString stringWithFormat:@"%@", _headerModel.followers];
    _headerV.followingLab1.text = [NSString stringWithFormat:@"%@", _headerModel.following];
    _headerV.reposLab1.text = [NSString stringWithFormat:@"%@", _headerModel.public_repos];
}

- (void)creatHeadView {
    _headerV = [[HeaderView alloc] init];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _headerV;
}

//分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _userListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_REUSE_ID1];
    }
    UserInfoModel *model = [_userListArr objectAtIndex:indexPath.row];
    [cell setName:model.name descriptin:model.descriptionStr language:model.language stars:model.stars];
    //NSLog(@"==%@",model.name);
    //cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
