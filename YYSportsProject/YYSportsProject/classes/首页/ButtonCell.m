//
//  ButtonCell.m
//  YYSportsProject
//
//  Created by k on 15/11/23.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell
{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}
- (void)setModel:(ButtonCellModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    CGFloat btnW = 60.0;
    CGFloat btnH = 75.0;
    CGFloat btnMarginY = 10;
    CGFloat btnMarginX = (kScreenW - btnW*4)/(3+4/3.0);
    
    for (int i=0; i<ceil(model.buttonList.count/4.0)+1; i++) {
        for (int j=0; j<4; j++) {
            if (i*4+j < model.buttonList.count) {
                UIButton * btn = [UDBtn buttonWithType:(UIButtonTypeCustom)];
                [btn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.equalTo(btn.mas_width).multipliedBy(0.9);
                }];
                btn.frame = CGRectMake(2/3.0*btnMarginX +(btnW + btnMarginX)*j, btnMarginY +(btnMarginY +btnH)*i, btnW, btnH);
                [btn setTitle:[model.buttonList[i*4+j] txt] forState:(UIControlStateNormal)];
                [btn sd_setImageWithURL:[NSURL URLWithString:[model.buttonList[i*4+j] icon]] forState:(UIControlStateNormal)];
                [btn setTitleColor:kRGB(102, 102, 102) forState:(UIControlStateNormal)];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                [btn addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
                btn.tag = 500 + i*4+j;
                [self.contentView addSubview:btn];
            }
        }
    }
    _cellHeight = CGRectGetMaxY([[self.contentView.subviews lastObject] frame]) + 10;
}
- (void)touch:(UIButton *)btn {
    if (_click) {
        _click(btn.tag);
    }
}
@end
