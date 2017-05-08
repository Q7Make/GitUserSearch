//
//  HeaderView.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/8.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatarImageV;
@property (nonatomic, strong) UILabel *loginLab;
@property (nonatomic, strong) UILabel *locationLab;
@property (nonatomic, strong) UILabel *bioLab;
@property (nonatomic, strong) UILabel *followerLab1;
@property (nonatomic, strong) UILabel *followerLab2;
@property (nonatomic, strong) UILabel *followingLab1;
@property (nonatomic, strong) UILabel *followingLab2;
@property (nonatomic, strong) UILabel *reposLab1;
@property (nonatomic, strong) UILabel *reposLab2;

@end

