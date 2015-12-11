//
//  DefaultAddrTVCell.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/25.
//  Copyright © 2015年 k. All rights reserved.
//

#import "DefaultAddrTVCell.h"

@implementation DefaultAddrTVCell
{
    UILabel* _label;
    UISwitch* _switch;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _label = [UILabel new];
        [self.contentView addSubview:_label];
        _label.text = @"是否设为默认收货地址";
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.frame = CGRectMake(17, 17, 150, 14);
        
        _switch = [UISwitch new];
        [self.contentView addSubview:_switch];
        [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_label);
            make.right.equalTo(self.contentView).offset(-17);
        }];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(AddrModel *)model{
    if (model != _model) {
        _model = nil;
        _model = model;
        
        _label.text = @"是否设为默认收货地址";
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.frame = CGRectMake(17, 17, 100, 14);
        
        [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_label);
            make.right.equalTo(self.contentView).offset(-17);
        }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
