//
//  AddrTableViewCell.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/24.
//  Copyright © 2015年 k. All rights reserved.
//

#import "AddrTableViewCell.h"
#import "EditAddrVC.h"
@implementation AddrTableViewCell
{
    UILabel* _contactLabel;
    UILabel* _mobileLabel;
    UILabel* _detailAddrLabel;
    UIButton* _defaultBtn;
    UIButton* _editBtn;
    UIButton* _deleteBtn;
}
- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _contactLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_contactLabel];
        
        _mobileLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_mobileLabel];
        
        _detailAddrLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_detailAddrLabel];
        
        _defaultBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_defaultBtn];
        
        _editBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_editBtn];
        
        _deleteBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}
-(void)setModel:(AddrModel *)model{
    if(model != _model){
        _model = nil;
        _model = model;
        
        _contactLabel.frame = CGRectMake(17, 17, 80, 16);
        _contactLabel.textColor = kRGB(34, 34, 34);
        _contactLabel.font = [UIFont systemFontOfSize:16];
        _contactLabel.text = @"联系人";
        _contactLabel.text = _model.contact;
        
        _mobileLabel.textColor = kRGB(34, 34, 34);
        _mobileLabel.font = [UIFont systemFontOfSize:15];
        _mobileLabel.text = @"电话";
        [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_contactLabel);
            make.right.equalTo(self.contentView).offset(-17);
            make.height.mas_equalTo(15);
//            make.width.mas_equalTo(150);
        }];
        _mobileLabel.text = _model.mobile;
        
        _detailAddrLabel.frame = CGRectMake(17, CGRectGetMaxY(_contactLabel.frame), kScreenW-30, 40);
        _detailAddrLabel.textColor = kRGB(102, 102, 102);
        _detailAddrLabel.font = [UIFont systemFontOfSize:12];
        _detailAddrLabel.text = @"详细地址";
        _detailAddrLabel.numberOfLines = 0;
        _detailAddrLabel.text = _model.detailAddr;
      
        
        UIView* lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 80, kScreenW, 1);
        lineView.backgroundColor = kWhite(.9);
        [self.contentView addSubview:lineView];
        
//        _defaultBtn.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, 24, 24);
        [_defaultBtn setTitle:@"默认" forState:(UIControlStateNormal)];
        [_defaultBtn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:24];
        _defaultBtn.tag = 10;
        [_defaultBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(_detailAddrLabel);
            make.height.mas_equalTo(24);
        }];
        
//          _cancelBtn.frame = CGRectMake(CGRectGetMaxX(_editBtn.frame)+10, CGRectGetMaxY(lineView.frame)-30, 14, 30);
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteBtn.tag = 100;
        [_deleteBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-17);
            make.centerY.equalTo(_defaultBtn);
        }];
        
//        _editBtn.frame = CGRectMake(kScreenW-100, CGRectGetMaxY(lineView.frame)-30, 14, 30);
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _editBtn.tag = 101;
        [_editBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_defaultBtn);
            make.right.equalTo(_deleteBtn.mas_left).offset(-17);
        }];
       
      
        
        
    }
}

-(void)click:(UIButton*)btn{
    if (_click) {
        _click(btn.tag,_indexPath.section);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
