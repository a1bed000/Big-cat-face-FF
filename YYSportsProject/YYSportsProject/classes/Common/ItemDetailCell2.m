//
//  ItemDetailCell2.m
//  YYSportsProject
//
//  Created by k on 15/11/19.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemDetailCell2.h"

@implementation ItemDetailCell2
{
    UILabel * _subjectLabel;
    UILabel * _numLabel;
    UIImageView * _imgView;
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
        _subjectLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subjectLabel];
        _numLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numLabel];
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        
        __weak typeof(self) weakSelf = self;
        
        [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
        }];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(_subjectLabel.mas_right).offset(2);
        }];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.width.height.mas_equalTo(17);
        }];
    }
    return self;
}


- (void)setModel:(ItemDetailModel2 *)model {
    _model = model;
    
    _subjectLabel.text = model.subject;
//    _numLabel.text = model.num?nil:[NSString stringWithFormat:@"(%@)",model.num];
    if (model.num) {
        _numLabel.text = [NSString stringWithFormat:@"(%ld)",model.num];
    }
    
    _imgView.image = [UIImage imageNamed:model.imgName];
}
@end
