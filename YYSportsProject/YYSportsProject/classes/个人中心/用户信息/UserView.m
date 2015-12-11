//
//  UserView.m
//  YYSports
//
//  Created by Tomi on 15/11/12.
//  Copyright © 2015年 k. All rights reserved.
//

#import "UserView.h"
#import "UIImageView+WebCache.h"
@implementation UserView
{
    UIImageView* _icon;
    UIImageView* _vipImageView;
    UILabel* _userNameLabel;
    UILabel* _activeCreditLabel;
    UILabel* _levelLabel;
    UILabel* _activeCreditNameLabel;
    UIProgressView* _progressView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        _icon = [[UIImageView alloc]init];
        _icon.frame = CGRectMake(20, 20, 65, 65);
        _icon.layer.cornerRadius = 65/2.0;
        _icon.layer.masksToBounds = YES;
        _icon.backgroundColor = kWhite(0.5);
        [self addSubview:_icon];
        
        _levelLabel = [[UILabel alloc]init];
        _levelLabel.text = @"会员等级";
        _levelLabel.font = [UIFont systemFontOfSize:12];
        _levelLabel.textColor = kRGB(102, 102, 102);
        [self addSubview:_levelLabel];
        [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_icon.mas_bottom).offset(10);
            make.height.mas_equalTo(9);
            make.centerX.equalTo(_icon);
        }];
        
        
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.text = @"姓名";
        _userNameLabel.textColor = kRGB(34, 34, 34);
        _userNameLabel.font = [UIFont systemFontOfSize:17];
         [self addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_icon.mas_right).offset(20);
            make.top.equalTo(_icon.mas_top).offset(10);
            make.height.mas_equalTo(13);
        }];
       
        
        _activeCreditNameLabel = [[UILabel alloc]init];
        _activeCreditNameLabel.text = @"积分";
        _activeCreditNameLabel.font = [UIFont systemFontOfSize:17];
        _activeCreditNameLabel.textColor = kRGB(153, 153, 153);
        [self addSubview:_activeCreditNameLabel];
        [_activeCreditNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel);
            make.top.equalTo(_userNameLabel.mas_bottom).offset(6);
        }];
        
        _activeCreditLabel = [[UILabel alloc]init];
        _activeCreditLabel.text = @"";
        _activeCreditLabel.font = [UIFont systemFontOfSize:17];
        _activeCreditLabel.textColor = kRGB(153, 153, 153);
        [self addSubview:_activeCreditLabel];
        [_activeCreditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_activeCreditNameLabel.mas_right).offset(5);
            make.top.equalTo(_activeCreditNameLabel);
        }];
        

        _vipImageView  = [[UIImageView alloc]init];
        _vipImageView.image = [UIImage imageNamed:@"vip34x28"];
        [self addSubview:_vipImageView];
        [_vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_activeCreditNameLabel.mas_bottom).offset(8);
            make.left.equalTo(_activeCreditNameLabel);
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
        }];
        
        UILabel* vipLabel = [[UILabel alloc]init];
        vipLabel.text = @"会员卡";
        vipLabel.textColor = kRGB(153, 153, 153);
        vipLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:vipLabel];
        [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_vipImageView);
            make.left.equalTo(_vipImageView.mas_right).offset(5);
            
        }];
    }
    return self;
}

-(void)setModel:(UserModel *)model{
    if (model != _model) {
        _model = nil;
        _model = model;

        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.iconUrl]] placeholderImage:nil options:0];
        
        NSString* str;
        if([model.level isEqualToString:@"1"]){
             str = @"普通会员";
        }
        else if([model.level isEqualToString:@"2"])
            str = @"VIP会员";
        
        _levelLabel.text = str;
        
        _userNameLabel.text = [NSString stringWithFormat:@"%@",model.userName] ;
        
        _activeCreditLabel.text = [NSString stringWithFormat:@"%ld",model.activeCredit];
        
   
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
