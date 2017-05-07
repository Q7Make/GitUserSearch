//
//  UserListTableViewCell.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListTableViewCell : UITableViewCell
- (void)setAvatarIV:(NSString *)imageUrl userName:(NSString*)loginStr userType:(NSString *)typeStr;
@end
