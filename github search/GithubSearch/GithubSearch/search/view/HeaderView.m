//
//  HeaderView.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/8.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "HeaderView.h"
#import "SDAutoLayout.h"
#import "Utilities.h"


NSString *const FOLLOWER = @"FOLLOWER";
NSString *const FOLLOWING = @"FOLLOWING";
NSString *const REPOS = @"REPOS";

@implementation HeaderView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    _headerView = [[UIView alloc] init];
    [self addSubview:_headerView];
    
    _headerView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .heightIs(140);
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"userbg"];
    [_headerView addSubview:imageV];
    
    imageV.sd_layout
    .leftEqualToView(_headerView)
    .rightEqualToView(_headerView)
    .heightRatioToView(_headerView, 1)
    .widthRatioToView(_headerView, 1);
    
    //做半透明处理太耗内存，又不想用GUPImage
    //    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^{
    //        imageV.image = [self changeImage:[UIImage imageNamed:@"userbg"]];
    //    });
    
    _avatarImageV = [[UIImageView alloc] init];
    _avatarImageV.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageV.image = [UIImage imageNamed:@"placeholder@2x"];
    [_headerView addSubview:_avatarImageV];
    _avatarImageV.sd_layout
    .leftSpaceToView(_headerView, 10)
    .topSpaceToView(_headerView, 10)
    .widthIs(60)
    .heightIs(60);
    
    _loginLab = [[UILabel alloc] init];
    _loginLab.font = [UIFont boldSystemFontOfSize:13];
    [_headerView addSubview:_loginLab];
    _loginLab.sd_layout
    .leftSpaceToView(_avatarImageV, 10)
    .topSpaceToView(_headerView, 10)
    .rightSpaceToView(_headerView, 10)
    .heightIs(30);
    
    _locationLab = [[UILabel alloc] init];
    _locationLab.font = [UIFont systemFontOfSize:11];
    [_headerView addSubview:_locationLab];
    _locationLab.sd_layout
    .leftEqualToView(_loginLab)
    .rightEqualToView(_loginLab)
    .topSpaceToView(_loginLab, 5)
    .heightIs(20);
    
    _bioLab = [[UILabel alloc] init];
    _bioLab.font = [UIFont systemFontOfSize:13];
    [_headerView addSubview:_bioLab];
    _bioLab.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_avatarImageV, 0)
    .rightSpaceToView(_headerView, 10)
    .heightIs(30);
    
    float w = ([[UIScreen mainScreen] bounds].size.width - 20)/3;
    
    _followerLab1 = [[UILabel alloc] init];
    _followerLab1.font = [UIFont systemFontOfSize:13];
    [_headerView addSubview:_followerLab1];
    _followerLab1.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_bioLab, 0)
    .heightIs(20)
    .widthIs(w);
    
    _followerLab2 = [[UILabel alloc] init];
    _followerLab2.font = [UIFont systemFontOfSize:13];
    _followerLab2.text = FOLLOWER;
    [_headerView addSubview:_followerLab2];
    _followerLab2.sd_layout
    .leftEqualToView(_avatarImageV)
    .topSpaceToView(_followerLab1, 0)
    .heightIs(20)
    .widthIs(w);
    
    _followingLab1 = [[UILabel alloc] init];
    _followingLab1.font = [UIFont systemFontOfSize:13];
    [_headerView addSubview:_followingLab1];
    _followingLab1.sd_layout
    .leftSpaceToView(_followerLab1, 0)
    .topSpaceToView(_bioLab, 0)
    .heightIs(20)
    .widthIs(w);
    
    _followingLab2 = [[UILabel alloc] init];
    _followingLab2.font = [UIFont systemFontOfSize:13];
    _followingLab2.text = FOLLOWING;
    [_headerView addSubview:_followingLab2];
    _followingLab2.sd_layout
    .leftEqualToView(_followingLab1)
    .topSpaceToView(_followerLab1, 0)
    .heightIs(20)
    .widthIs(w);
    
    _reposLab1 = [[UILabel alloc] init];
    _reposLab1.font = [UIFont systemFontOfSize:13];
    [_headerView addSubview:_reposLab1];
    _reposLab1.sd_layout
    .leftSpaceToView(_followingLab1, 0)
    .topSpaceToView(_bioLab, 0)
    .heightIs(20)
    .widthIs(w);
    
    _reposLab2 = [[UILabel alloc] init];
    _reposLab2.font = [UIFont systemFontOfSize:13];
    _reposLab2.text = REPOS;
    [_headerView addSubview:_reposLab2];
    _reposLab2.sd_layout
    .leftEqualToView(_reposLab1)
    .topSpaceToView(_reposLab1, 0)
    .heightIs(20)
    .widthIs(w);
}


@end
