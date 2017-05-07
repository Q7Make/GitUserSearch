//
//  UserListViewController.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserListViewController.h"
#import "PYSearchConst.h"
#import "searchModel.h"
#import "UserInfoViewController.h"
#import "UserListTableViewCell.h"

NSString *const CELL_REUSE_ID = @"CELL_REUSE_ID";

@interface UserListViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *_userListArr;
    searchModel *_userListModel;
    UITableView *_tableView;
}

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _userStr;
    //self.view.backgroundColor = PYSEARCH_RANDOM_COLOR;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice) name:@"userList" object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //去掉弹性
    _tableView.bounces = NO;
    _tableView.rowHeight = 45;
    //去掉分割线
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //设置tableview背景图
//    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
//    _tableView.backgroundView = imageV;
    [self.view addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"bg_header_back"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = buttonItem;
    [btn addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _userListModel = [[searchModel alloc] init];
    [_userListModel requestDataWithUrl:_userStr];
    NSLog(@"STR= %@",_userStr);
}

- (void)BackButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    _userListModel = [[searchModel alloc] init];
//    [_userListModel requestDataWithUrl:_userStr];
//    NSLog(@"STR= %@",_userStr);
}

- (void)notice{
    [_userListArr removeAllObjects];
    _userListArr = [NSMutableArray arrayWithArray:_userListModel.dataArr];
    [_tableView reloadData];
}

//分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UserListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_REUSE_ID];
    }
    
    searchModel *model = [_userListArr objectAtIndex:indexPath.row];
    [cell setAvatarIV:model.avatar_url userName:model.login userType:model.type];
    //NSLog(@"==%@",model.avatar_url);
    
    //cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    searchModel *model = [_userListArr objectAtIndex:indexPath.row];
    userInfoVC.userUrl = model.url;
    userInfoVC.reposUrl = model.repos_url;
    userInfoVC.userName = model.login;
    userInfoVC.avatarUrl = model.avatar_url;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
