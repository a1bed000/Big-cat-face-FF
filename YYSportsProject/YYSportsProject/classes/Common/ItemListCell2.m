//
//  ItemListCell2.m
//  YYSports
//
//  Created by k on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemListCell2.h"

@implementation ItemListCell2
{
    UIImageView * _thumbImageView;
    UIImageView * _ruleImageView;
    UILabel * _nameLabel;
    UILabel * _preferentialPriceLabel;
    UILabel * _yyPriceLabel;
    UILabel * _numLable;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kWhite(0.95);
        
        _thumbImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_thumbImageView];
        
        _ruleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_ruleImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        //        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = kRGB(34, 34, 34);
//        _nameLabel.frame = CGRectMake(200, 10, kScreenW-110, 20);
        
        _preferentialPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_preferentialPriceLabel];
        _preferentialPriceLabel.textColor = kRGB(203, 0, 0);
        
        _yyPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_yyPriceLabel];
        _yyPriceLabel.font = [UIFont systemFontOfSize:12];
        _yyPriceLabel.textColor = kRGB(153, 153, 153);
        
        _numLable = [[UILabel alloc] init];
        [self.contentView addSubview:_numLable];
        _numLable.font = [UIFont systemFontOfSize:12];
        _numLable.textColor = kRGB(153, 153, 153);
        
        __weak typeof(self) weakSelf = self;
        
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(5);
            make.left.equalTo(weakSelf.contentView).offset(5);
            make.height.mas_equalTo(90);
            make.width.equalTo(_thumbImageView.mas_height).multipliedBy(1.0);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_thumbImageView).offset(-30);
//            make.bottom.equalTo(_thumbImageView.mas_top).offset(30);
            make.left.equalTo(_thumbImageView.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
//            make.top.equalTo(_thumbImageView.mas_top).offset(10);
            
        }];
        [_preferentialPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.bottom.equalTo(_thumbImageView.mas_bottom).offset(0);
        }];
        [_yyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_preferentialPriceLabel.mas_right).offset(10);
            make.bottom.equalTo(_preferentialPriceLabel);
        }];
        [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_thumbImageView);
            make.left.equalTo(_nameLabel);
        }];
    }
    return self;
}
- (void)setModel:(ItemListModel *)model {
    _model = model;
    
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbImg] placeholderImage:nil];
    [_nameLabel setText:model.itemName];
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo([model.itemName boundingRectWithSize:(CGSizeMake(kScreenW - 130, MAXFLOAT)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height);
    }];
    [_preferentialPriceLabel setText:[NSString stringWithFormat:@"￥%.2f",model.yyPrice]];
    
    NSAttributedString * attStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f ",model.yyPrice] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    [_yyPriceLabel setAttributedText:attStr];
    
    [_numLable setText:[NSString stringWithFormat:@"已售:%ld",model.num]];
    
    
}
@end
