//
//  ItemParamsCell.m
//  YYSportsProject
//
//  Created by k on 15/11/24.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemParamsCell.h"

@implementation ItemParamsCell
{
    UILabel * _propNameLabel;
    UILabel * _propValueLabel;
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
        _propNameLabel = [[UILabel alloc] init];
        _propNameLabel.font = [UIFont systemFontOfSize:14];
        _propNameLabel.textColor = kRGB(153, 153, 153);
        _propValueLabel = [[UILabel alloc] init];
        _propValueLabel.font = [UIFont systemFontOfSize:14];
        _propValueLabel.textColor = kRGB(153, 153, 153);
        [self.contentView addSubview:_propValueLabel];
        [self.contentView addSubview:_propNameLabel];
        
        __weak typeof(self) weakSelf =self;
        
        [_propNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
            
        }];
        [_propValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(130);
        }];
        
    }
    return self;
}
- (void)setModel:(ItemParamsModel *)model {
    _model = model;
    _propNameLabel.text = model.propName;
    _propValueLabel.text = model.propValue;
}
@end
