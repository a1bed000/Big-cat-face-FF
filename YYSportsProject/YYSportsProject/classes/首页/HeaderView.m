//
//  HeaderView.m
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
{
    SDCycleScrollView * _cycleScrollView;
    UIView * _buttonView;
    UIView * _carouselTextView;
    
    NSMutableArray * _topImgList;
    
    UIView * _boardView;
    NSInteger _page;
    NSInteger _totalPage;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGB(232, 232, 232);
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW *347/750.0)];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        [self addSubview:_cycleScrollView];  //占用tag400+
        
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_buttonView];      //占用tag500+
        
        _carouselTextView = [[UIView alloc] init];
        _carouselTextView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_carouselTextView]; //占用tag600+
        
    }
    return self;
}
- (void)setModel:(HeaderModel *)model {
    _model = model;
    _topImgList = [NSMutableArray array];
    for (int i=0; i<model.topAdList.count; i++) {
        [_topImgList addObject:[model.topAdList[i] icon]];
    }
    _cycleScrollView.imageURLStringsGroup = _topImgList;
    
    
    
    
//    CGFloat btnW = 60.0;
//    CGFloat btnH = 75.0;
//    CGFloat btnMarginY = 10;
//    CGFloat btnMarginX = (kScreenW - btnW*4)/(3+4/3.0);
//    
//    for (int i=0; i<ceil(model.buttonList.count/4.0)+1; i++) {
//        for (int j=0; j<4; j++) {
//            if (i*4+j < model.buttonList.count) {
//                UDBtn * btn = [UDBtn buttonWithType:(UIButtonTypeCustom)];
//                btn.frame = CGRectMake(2/3.0*btnMarginX +(btnW + btnMarginX)*j, btnMarginY +(btnMarginY +btnH)*i, btnW, btnH);
//                [btn setTitle:[model.buttonList[i*4+j] txt] forState:(UIControlStateNormal)];
//                [btn sd_setImageWithURL:[NSURL URLWithString:[model.buttonList[i*4+j] icon]] forState:(UIControlStateNormal)];
//                [btn setTitleColor:kRGB(102, 102, 102) forState:(UIControlStateNormal)];
//                [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//                
//                btn.tag = 500 + i*4+j;
//                [_buttonView addSubview:btn];
//            }
//        }
//    }
//    _buttonView.frame = CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame), kScreenW, CGRectGetMaxY([[_buttonView.subviews lastObject] frame])+btnMarginY);
//    _carouselTextView.frame = CGRectMake(0, CGRectGetMaxY(_buttonView.frame)+1, kScreenW, 35);
//    
//    _headerHeight = CGRectGetMaxY(_carouselTextView.frame);
//    
//    
//    UIImageView * yyImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0,kScreenW * 92.0/375, 35))];
//    yyImageView.image = [[UIImage imageNamed:@"home_yy"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    [_carouselTextView addSubview:yyImageView];
//    _carouselTextView.clipsToBounds = YES;
//    UIView * boardView = [[UIView alloc] init];
//    _boardView = boardView;
//    [_carouselTextView addSubview:boardView];
//    _page = 1;
//    _totalPage = model.carouselTextList.count;
//    for (int i=0; i<model.carouselTextList.count; i++) {
//        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [btn setTitle:[model.carouselTextList[i] txt] forState:(UIControlStateNormal)];
//        [btn sd_setImageWithURL:[NSURL URLWithString:[model.carouselTextList[i] icon]] forState:(UIControlStateNormal)];
//        [btn setFrame:(CGRectMake(0, 35*i, kScreenW - CGRectGetMaxX(yyImageView.frame), 35))];
//        [btn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        btn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [boardView addSubview:btn];
//    }
//    //再添加一个
//    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [btn setTitle:[model.carouselTextList[0] txt] forState:(UIControlStateNormal)];
//    [btn sd_setImageWithURL:[NSURL URLWithString:[model.carouselTextList[0] icon]] forState:(UIControlStateNormal)];
//    [btn setFrame:(CGRectMake(0, 35*model.carouselTextList.count, kScreenW - CGRectGetMaxX(yyImageView.frame), 35))];
//    [btn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [boardView addSubview:btn];
//    
//    boardView.frame =  CGRectMake(CGRectGetMaxX(yyImageView.frame), 0, kScreenW - CGRectGetMaxX(yyImageView.frame), 35*(_totalPage+1));
//    
//    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
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
