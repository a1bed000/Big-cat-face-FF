
//
//  HomeCell1.m
//  YYSportsProject
//
//  Created by k on 15/11/20.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "HomeCell1.h"
#define kTopWH 0.325
#define kSubImgWH 1.284
#define kMargin 5


@implementation HomeCell1
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
        _topBtn.tag = 100;
        [_topBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _subjectLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subjectLabel];
        _subjectLabel.backgroundColor = [UIColor whiteColor];
        _subjectLabel.textAlignment = NSTextAlignmentCenter;
        _subjectLabel.font = [UIFont systemFontOfSize:20];
        
        
        _boardView = [[UIView alloc] init];
        [self.contentView addSubview:_boardView];
        
        _topBtn.frame = CGRectMake(0, 13, kScreenW, kScreenW*kTopWH);
        
        _subjectLabel.frame = CGRectMake(0, CGRectGetMaxY(_topBtn.frame), kScreenW, kScreenW*42/375);
        _boardView.frame = CGRectMake(0, CGRectGetMaxY(_subjectLabel.frame), kScreenW, kMargin * 3 + (kScreenW - kMargin *2)/3*kSubImgWH * 2);
        
        for (int i=0; i<2; i++) {
            for (int j=0; j<3; j++) {
                UIButton * subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                subBtn.frame = CGRectMake(((kScreenW - kMargin *2)/3 + kMargin)*j, kMargin+((kScreenW - kMargin *2)/3 +kMargin)*i*kSubImgWH, (kScreenW - kMargin *2)/3, (kScreenW - kMargin *2)/3*kSubImgWH);
                subBtn.tag = 100 + i*3+j +1;
                [subBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
                [_boardView addSubview:subBtn];
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
        UIButton * btn = (UIButton *)[_boardView viewWithTag:100+i+1];
        
        [btn sd_setImageWithURL:[NSURL URLWithString:[model.subAdList[i] icon]]forState:(UIControlStateNormal)];
        
    }
}
- (void)click:(UIButton *)btn {
    if (_click) {
        _click(btn.tag);
    }
}
@end
