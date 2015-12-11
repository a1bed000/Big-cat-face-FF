//
//  AddrItemTVCell.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/25.
//  Copyright © 2015年 k. All rights reserved.
//

#import "AddrItemTVCell.h"

@implementation AddrItemTVCell
{
    UILabel* _text;
    UITextField* _textField;
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _text = [UILabel new];
        [self.contentView addSubview:_text];
        
        _textField = [UITextField new];
        [self.contentView addSubview:_textField];
        
           }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AddrInfoModel *)model {
    if(model != _model)
        _model = nil;
        _model = model;
    
    
    _text.frame = CGRectMake(17, 17, 100, 14);
    _text.font = [UIFont systemFontOfSize:14];
    _text.textColor = kRGB(102, 102, 102);
    _text.text = _model.subject;
    
    
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = kRGB(34, 34, 34);
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.frame = CGRectMake(CGRectGetWidth(_text.frame)+10, CGRectGetMinY(_text.frame) , kScreenW-117, 15);
    _textField.placeholder = _model.placeholder;
    _textField.text = _model.content;
    
}

@end
