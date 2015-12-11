//
//  ItemIntroCell.m
//  YYSportsProject
//
//  Created by k on 15/11/19.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemIntroCell.h"

@implementation ItemIntroCell
{
    UILabel * _nameLabel;
    UILabel * _preferentialPriceLabel;
    UILabel * _yyPriceLabel;
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
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        _preferentialPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_preferentialPriceLabel];
        _preferentialPriceLabel.textColor = kRGB(203, 0, 0);
        
        _yyPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_yyPriceLabel];
        _yyPriceLabel.font = [UIFont systemFontOfSize:12];
        
        __weak typeof(self) weakSelf = self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
        }];
        [_preferentialPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(5);
            
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        [_yyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_preferentialPriceLabel.mas_right).offset(5);
            make.bottom.equalTo(_preferentialPriceLabel).offset(-1);
        }];
        
        
    }
    return self;
}
- (void)setModel:(ItemIntroModel *)model {
    _model = model;
    _nameLabel.text = model.itemName;
    _preferentialPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.preferentialPrice];
    NSAttributedString * attStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %.2f  ",model.yyPrice] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    _yyPriceLabel.attributedText = attStr;
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    
}
@end
