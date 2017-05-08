//
//  UserListTableViewCell.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserListTableViewCell.h"
#import "SDAutoLayout.h"
#import "Utilities.h"
#import "UIImageView+WebCache.h"

NSString *const User = @"User";

@implementation UserListTableViewCell
{
    UIImageView *_avatarIV;
    UILabel *_loginLa;
    UIImageView *_typeIV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    //创建图标
    _avatarIV                     = [[UIImageView alloc] init];
    _avatarIV.contentMode         = UIViewContentModeScaleAspectFit;
    //_avatarIV.image = [UIImage imageNamed:@"placeholder@2x"];
    _avatarIV.layer.cornerRadius = 25;
    _avatarIV.clipsToBounds = YES;
    [self.contentView addSubview:_avatarIV];
    
    _avatarIV.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .widthIs(50);
    
    _loginLa                  = [[UILabel alloc] init];
    _loginLa.textColor        = [UIColor blackColor];
    _loginLa.font             = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_loginLa];
    
    _loginLa.sd_layout
    .leftSpaceToView(_avatarIV, 10)
    .topEqualToView(_avatarIV)
    .heightIs(20)
    .widthIs(100);

    _typeIV                  = [[UIImageView alloc] init];
    _typeIV.contentMode      = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_typeIV];
    
    _typeIV.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topEqualToView(_avatarIV)
    .widthIs(15)
    .heightIs(15);
}

// 自绘分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 70, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(184)/255.0 green:(186)/255.0 blue:(186)/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setAvatarIV:(NSString *)imageUrl userName:(NSString*)loginStr userType:(NSString *)typeStr {
    
    if ([Utilities isBlankString:_loginLa.text]) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//            UIImage *image = [UIImage imageWithData:imageData];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                _avatarIV.image = image;
//            });
//        });
        
        [_avatarIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                     placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
        
        _loginLa.text = loginStr;
        
        if ([typeStr isEqualToString:User]) {
            _typeIV.image = [UIImage imageNamed:@"btn_individual_nor@2x"];
        } else {
            _typeIV.image = [UIImage imageNamed:@"btn_ home_nor@2x"];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
