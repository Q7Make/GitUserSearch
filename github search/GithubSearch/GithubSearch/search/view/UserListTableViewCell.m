//
//  UserListTableViewCell.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserListTableViewCell.h"
#import "SDAutoLayout.h"

@implementation UserListTableViewCell
{
    UIImageView *_avatarIV;
    UILabel *_loginLa;
    UIImageView *_typeIV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    //创建图标
    _avatarIV                     = [[UIImageView alloc] init];
    _avatarIV.contentMode         = UIViewContentModeScaleAspectFit;
    _avatarIV.backgroundColor  = [UIColor yellowColor];
    [self.contentView addSubview:_avatarIV];
    
    _avatarIV.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .widthIs(30);
    
    float w  = ([[UIScreen mainScreen] bounds].size.width - 40)/3;
    
    _loginLa                  = [[UILabel alloc] init];
    _loginLa.textColor        = [UIColor blackColor];
    //_loginLa.textAlignment    = NSTextAlignmentCenter;
    _loginLa.backgroundColor  = [UIColor yellowColor];
    _loginLa.font             = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_loginLa];
    
    _loginLa.sd_layout
    .leftSpaceToView(_avatarIV, 0)
    .topSpaceToView(self.contentView, 0)
    .heightIs(20)
    .widthIs(w);
    

    _typeIV                  = [[UIImageView alloc] init];
    _typeIV.contentMode      = UIViewContentModeScaleAspectFit;
    _typeIV.backgroundColor  = [UIColor yellowColor];
    [self.contentView addSubview:_typeIV];
    
    _typeIV.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topEqualToView(_avatarIV)
    .widthIs(15)
    .heightIs(15);
}

// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(184)/255.0 green:(186)/255.0 blue:(186)/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setAvatarIV:(NSString *)imageUrl userName:(NSString*)loginStr userType:(NSString *)typeStr {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _avatarIV.image = image;
        });
    });
    
    _loginLa.text = loginStr;
    
    if ([typeStr isEqualToString:@"User"]) {
        _typeIV.image = [UIImage imageNamed:@"btn_individual_nor@2x"];
    } else {
        _typeIV.image = [UIImage imageNamed:@"btn_ home_nor@2x"];
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