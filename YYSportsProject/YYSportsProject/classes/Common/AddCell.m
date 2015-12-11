//
//  AddCell.m
//  YYSportsProject
//
//  Created by k on 15/11/25.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "AddCell.h"

@implementation AddCell
{
    UIButton * _addBtn;
    UIButton * _reduceBtn;
    UILabel * _itemNumLabel;
    UILabel * _stockLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:(CGRectMake(20, 10, 100, 20))];
        label.font = kFont(15);
        label.text = @"选择数量";
        [self.contentView addSubview:label];
        
        UIView * lineView = [[UIView alloc] initWithFrame:(CGRectMake(10, 40, kScreenW - 20, 0.5))];
        lineView.backgroundColor = kRGB(153, 153, 153);
        [self.contentView addSubview:lineView];
        
        _reduceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"itemDetail_reduce"] forState:(UIControlStateNormal)];
        _reduceBtn.frame = CGRectMake(20, 45, 30, 28);
        _reduceBtn.tag = 100;
        [self.contentView addSubview:_reduceBtn];
        
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"itemDetail_add"] forState:(UIControlStateNormal)];
        _addBtn.frame = CGRectMake(90, 45, 30, 28);
        _addBtn.tag = 101;
        [self.contentView addSubview:_addBtn];
        [_addBtn addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
        [_reduceBtn addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _itemNumLabel = [[UILabel alloc] initWithFrame:(CGRectMake(50, 45, 40, 28))];
        _itemNumLabel.font = kFont(16);
        _itemNumLabel.textAlignment = NSTextAlignmentCenter;
        _itemNumLabel.layer.borderColor = kRGB(153, 153, 153).CGColor;
        _itemNumLabel.layer.borderWidth = 0.5;
        [self.contentView addSubview:_itemNumLabel];
        
        _stockLabel = [[UILabel alloc] initWithFrame:(CGRectMake(140, 55, 150, 18))];
        _stockLabel.font = kFont(13);
        [self.contentView addSubview:_stockLabel];
        
    }
    return self;
}
- (void)setModel:(AddCellModel *)model {
    _model = model;
    _addBtn.enabled = model.canAdd;
    _reduceBtn.enabled = model.canReduce;
    _itemNumLabel.text = [NSString stringWithFormat:@"%ld",model.itemNum];
    _stockLabel.text = [NSString stringWithFormat:@"库存%ld件",model.itemStock];
}
- (void)touch:(UIButton *)btn {
    if (_addNum) {
        _addNum(btn.tag);
    }
}
@end
