//
//  HomeCell3.m
//  YYSportsProject
//
//  Created by k on 15/11/20.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "HomeCell3.h"
#define kTopWH 305/750.0
#define kSubImgWH 0.982
#define kMargin 1.0


@implementation HomeCell3
{
    UIButton * _topBtn;
    UILabel * _subjectLabel;
    UIView * _boardView;
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
        self.contentView.backgroundColor = kRGB(232, 232, 232);
        _topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentView addSubview:_topBtn];
        _topBtn.adjustsImageWhenDisabled = NO;
        _topBtn.tag = 300;
        [_topBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _subjectLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subjectLabel];
        _subjectLabel.backgroundColor = [UIColor whiteColor];
        _subjectLabel.textAlignment = NSTextAlignmentCenter;
        _subjectLabel.font = [UIFont systemFontOfSize:20];
        
        
        _boardView = [[UIView alloc] init];
        [self.contentView addSubview:_boardView];
        _subjectLabel.frame = CGRectMake(0, 0, kScreenW, kScreenW*42/375);
        _topBtn.frame = CGRectMake(0, CGRectGetMaxY(_subjectLabel.frame), kScreenW, kScreenW*kTopWH);
        _boardView.frame = CGRectMake(0, CGRectGetMaxY(_topBtn.frame), kScreenW, kMargin * 3 + (kScreenW - kMargin *4)/3*kSubImgWH * 2);
        
        CGFloat subW = (750.0-2-304)/2*kScreenW/750;
        CGFloat subH = subW * kSubImgWH;
        
        
        for (int i=0; i<2; i++) {
            for (int j=0; j<3; j++) {
                UIButton * subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                subBtn.tag = 300 + i*3+j +1;
                [subBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
                [_boardView addSubview:subBtn];
   
                if (!i&&!j) {
                    subBtn.frame = CGRectMake(0, 0, 304.0/750*kScreenW, 437.0/750*kScreenW);
                }
                else if (i*3 + j < 5) {
                    subBtn.frame = CGRectMake(304.0/750*kScreenW+kMargin +(subW + kMargin)*(j-1+i), (subH +kMargin)*i, subW, subH);
                }
                else {                    
                }
            }
        }
    }
    return self;
}
- (void)setModel:(HomeCellModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    
    [_topBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.rootAdData.icon] forState:(UIControlStateNormal)];
    [_topBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.rootAdData.icon] forState:(UIControlStateHighlighted)];
    _subjectLabel.text = model.rootTitle;
    for (int i=0; i<model.subAdList.count; i++) {
        UIButton * btn = (UIButton *)[_boardView viewWithTag:300+i+1];
        
        [btn sd_setImageWithURL:[NSURL URLWithString:[model.subAdList[i] icon]] forState:(UIControlStateNormal)];
        
    }
}
- (void)click:(UIButton *)btn {
    if (_click) {
        _click(btn.tag);
    }
}
@end
