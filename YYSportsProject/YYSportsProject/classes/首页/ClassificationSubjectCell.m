//
//  ClassificationSubjectCell.m
//  YYSportsProject
//
//  Created by k on 15/11/26.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ClassificationSubjectCell.h"

@implementation ClassificationSubjectCell
{
    UIButton * _subBtn;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_subBtn setTitleColor:kRGB(102, 102, 102) forState:(UIControlStateNormal)];
        [_subBtn setTitleColor:kRGB(202, 0, 0) forState:(UIControlStateSelected)];
        _subBtn.userInteractionEnabled = NO;
        self.contentView.backgroundColor = kRGB(202, 202, 202);
        [self.contentView addSubview:_subBtn];
        __weak typeof(self) weakSelf = self;
        [_subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.contentView);
        }];
    }
    return self;
}
- (void)setModel:(ClassificationSubjectModel *)model {
    _model = model;
    _subBtn.selected = model.selected;
    _subBtn.titleLabel.font = model.selected?kFont(17):kFont(16);
    [_subBtn setTitle:model.rootClassifyName forState:(UIControlStateNormal)];
    

    self.contentView.backgroundColor = model.selected?[UIColor whiteColor]:kRGB(202, 202, 202);
}
@end
