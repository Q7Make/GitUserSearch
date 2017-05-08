//
//  UserInfoTableViewCell.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserInfoTableViewCell.h"
#import "SDAutoLayout.h"
#import "PYSearchConst.h"
#import "Utilities.h"

@implementation UserInfoTableViewCell

{
    UILabel *_reposNameLab;
    UILabel *_desLab;
    UIImageView *_lanImageV;
    UILabel *_lanLab;
    UIImageView *_starsImageV;
    UILabel *_starsLab;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _reposNameLab = [[UILabel alloc] init];
    _reposNameLab.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:_reposNameLab];
    _reposNameLab.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .heightIs(15)
    .rightSpaceToView(self.contentView, 10);
    
    _desLab = [[UILabel alloc] init];
    _desLab.textColor = [UIColor blackColor];
    _desLab.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_desLab];
    _desLab.sd_layout
    .leftEqualToView(_reposNameLab)
    .topSpaceToView(_reposNameLab, 3)
    .heightIs(12)
    .rightEqualToView(_reposNameLab);
    
    float w = ([[UIScreen mainScreen] bounds].size.width - 50)/2;
    
    _lanImageV = [[UIImageView alloc] init];
    _lanImageV.contentMode = UIViewContentModeScaleAspectFit;
    _lanImageV.image = [UIImage imageNamed:@"language@2x"];
    [self.contentView addSubview:_lanImageV];
    _lanImageV.sd_layout
    .leftEqualToView(_desLab)
    .topSpaceToView(_desLab, 5)
    .widthIs (15)
    .heightIs(15);
    
    _lanLab = [[UILabel alloc] init];
    _lanLab.textColor = [UIColor blackColor];
    _lanLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_lanLab];
    _lanLab.sd_layout
    .leftSpaceToView(_lanImageV, 0)
    .topEqualToView(_lanImageV)
    .heightIs(15)
    .widthIs(w);

    _starsImageV = [[UIImageView alloc] init];
    _starsImageV.contentMode = UIViewContentModeScaleAspectFit;
    _starsImageV.image = [UIImage imageNamed:@"stars@2x"];
    [self.contentView addSubview:_starsImageV];
    _starsImageV.sd_layout
    .leftSpaceToView(_lanLab,0)
    .topEqualToView(_lanLab)
    .widthIs (15)
    .heightIs(15);
    
    _starsLab = [[UILabel alloc] init];
    _starsLab.textColor = [UIColor blackColor];
    _starsLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_starsLab];
    _starsLab.sd_layout
    .leftSpaceToView(_starsImageV, 0)
    .topEqualToView(_starsImageV)
    .heightIs(15)
    .widthIs(w);
}

// 自绘分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(184)/255.0 green:(186)/255.0 blue:(186)/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setName:(NSString *)name descriptin:(NSString *)description language:(NSString *)language stars:(NSString *)starsCount {
    
    if (![Utilities isBlankString:name]) {
        _reposNameLab.text = name;
    }
    if (![Utilities isBlankString:description]) {
        _desLab.text = description;
    }
    if (![Utilities isBlankString:language]) {
        _lanLab.text = language;
    }
    if (![Utilities isBlankString:starsCount]) {
        _starsLab.text = starsCount;
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
