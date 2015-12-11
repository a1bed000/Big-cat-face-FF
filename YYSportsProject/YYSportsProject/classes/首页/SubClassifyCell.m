//
//  SubClassifyCell.m
//  YYSportsProject
//
//  Created by k on 15/11/26.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "SubClassifyCell.h"

@implementation SubClassifyCell
{
    UDBtn * _classifyBtn;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _classifyBtn = [UDBtn buttonWithType:(UIButtonTypeCustom)];
        [_classifyBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(_classifyBtn.mas_width).multipliedBy(0.9);
        }];
        CGFloat marginX = 10.0;
        CGFloat btnW = (kScreenW - 80 - marginX *1.2*2 - marginX*2)/3.0;
        _classifyBtn.frame = CGRectMake(0, 0, btnW, btnW * 1.3);
        _classifyBtn.center = self.contentView.center;
        [_classifyBtn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        _classifyBtn.titleLabel.font = kFont(12);
        [self.contentView addSubview:_classifyBtn];
        _classifyBtn.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setModel:(SubClassifyModel *)model {
    _model = model;
    

    [_classifyBtn setTitle:model.subClassifyName forState:(UIControlStateNormal)];
    [_classifyBtn sd_setImageWithURL:[NSURL URLWithString:model.subIcon] forState:(UIControlStateNormal)];
    [_classifyBtn setTag:1000+model.subClassifyId];
    
    
    
}
@end
