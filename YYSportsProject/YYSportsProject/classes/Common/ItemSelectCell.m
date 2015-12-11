//
//  ItemSelectCell.m
//  YYSportsProject
//
//  Created by k on 15/11/24.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemSelectCell.h"

@implementation ItemSelectCell
{
    UILabel * _subjectLabel;
    UIView * _lineView;
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
        _subjectLabel = [[UILabel alloc] initWithFrame:(CGRectMake(20, 10, kScreenW - 40, 20))];
        _subjectLabel.font = kFont(15);
        _subjectLabel.tag = -1;
        [self.contentView addSubview:_subjectLabel];
        _lineView = [[UIView alloc] initWithFrame:(CGRectMake(10, 40, kScreenW-20, 0.5))];
        _lineView.backgroundColor = kRGB(153, 153, 153);
        _lineView.tag = -2;
        [self.contentView addSubview:_lineView];
    }
    return self;
}
- (void)setModel:(ItemSelectModel *)model {
    
    for (UIView * view in self.contentView.subviews) {
        if (view.tag >0) {
            [view removeFromSuperview];
        }
    }
    
    _model = model;
    _subjectLabel.text = [NSString stringWithFormat:@"选择%@",model.propName];
    CGFloat btnMarginX = 20.0;
    CGFloat btnW = (kScreenW - 100)/4.0;
    CGFloat btnH = 30.0;
    CGFloat btnMarginY = 15.0;
    
    for (int i=0; i<ceil(model.propList.count/4.0); i++) {
        for (int j=0; j<4; j++) {
            if (i*4+j <model.propList.count) {
                UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                [btn setBackgroundColor:kRGB(202, 202, 202)];
                btn.frame = CGRectMake(btnMarginX + j*(btnW + btnMarginX), 50 + (btnH + btnMarginY)*i, btnW, btnH);
                btn.tag = _cellIndex.row * 100 + i*4 + j;
                [btn setTitle:[model.propList[i*4+j] propValue] forState:(UIControlStateNormal)];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                [btn setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:(UIControlStateSelected)];
                [btn setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:(UIControlStateNormal)];
                [btn setBackgroundImage:[UIImage imageNamed:@"button_disabled"] forState:(UIControlStateDisabled)];
                [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
                [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateDisabled)];
                [self.contentView addSubview:btn];
                if ([model.propList[i*4+j] status] == 0) {
                    [btn setEnabled:NO];
                }
                else if ([model.propList[i*4+j] status] == 1) {
                    btn.selected = YES;
                }
                else if ([model.propList[i*4+j] status] == 2) {
                    btn.selected = NO;
                }
                else {
                    
                }
                [btn addTarget:self action:@selector(btnTouch:) forControlEvents:(UIControlEventTouchUpInside)];
            }
        }
    }
    _cellHeight = CGRectGetMaxY([[self.contentView.subviews lastObject] frame])+10;
    
}
- (void)btnTouch:(UIButton *)btn {
    if (_btnTouch) {
        _btnTouch(btn.tag);
    }
}
@end
