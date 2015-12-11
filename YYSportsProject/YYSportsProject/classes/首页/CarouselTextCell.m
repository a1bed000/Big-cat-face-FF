//
//  CarouselTextCell.m
//  YYSportsProject
//
//  Created by k on 15/11/23.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "CarouselTextCell.h"

@implementation CarouselTextCell
{
    UIView * _boardView;
    NSInteger _page;
    NSInteger _totalPage;
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
        _page = 1;
        
        UIView * view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, 0.5))];
        view.backgroundColor = kRGB(153, 153, 153);
        [self.contentView addSubview:view];
        
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)setModel:(CarouselTextCellModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    UIImageView * yyImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0,kScreenW * 92.0/375, 35))];
    yyImageView.image = [[UIImage imageNamed:@"home_yy"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [self.contentView addSubview:yyImageView];
    self.clipsToBounds = YES;
    _boardView = [[UIView alloc] init];
    [self.contentView addSubview:_boardView];
    
    _totalPage = model.carouselTextList.count;
    for (int i=0; i<model.carouselTextList.count; i++) {
        UIButton * btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn1 setTitle:[model.carouselTextList[i] txt] forState:(UIControlStateNormal)];
        [btn1 sd_setImageWithURL:[NSURL URLWithString:[model.carouselTextList[i] icon]] forState:(UIControlStateNormal)];
        [btn1 setFrame:(CGRectMake(0, 35*i, kScreenW - CGRectGetMaxX(yyImageView.frame), 35))];
        [btn1 setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn1.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        [_boardView addSubview:btn1];
    }
    //再添加一个
    UIButton * btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn2 setTitle:[model.carouselTextList[0] txt] forState:(UIControlStateNormal)];
    [btn2 sd_setImageWithURL:[NSURL URLWithString:[model.carouselTextList[0] icon]] forState:(UIControlStateNormal)];
    [btn2 setFrame:(CGRectMake(0, 35*model.carouselTextList.count, kScreenW - CGRectGetMaxX(yyImageView.frame), 35))];
    [btn2 setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_boardView addSubview:btn2];
    
    _boardView.frame =  CGRectMake(CGRectGetMaxX(yyImageView.frame), 0, kScreenW - CGRectGetMaxX(yyImageView.frame), 35*(_totalPage+1));
}
- (void)scroll {
    if (_page >= _totalPage+1) {
        _page = 1;
        _boardView.transform = CGAffineTransformIdentity;
    }
    _page ++;
    [UIView animateWithDuration:0.8 animations:^{
        _boardView.transform = CGAffineTransformTranslate(_boardView.transform, 0, -35);
    }];
}

@end
