//
//  UserIconView.m
//  YYSports
//
//  Created by Tomi on 15/11/13.
//  Copyright © 2015年 k. All rights reserved.
//

#import "UserIconView.h"

@implementation UserIconView
{
    UIImageView* _imageView;
    UILabel* _label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = kRGB(153, 153, 153);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

-(void)setModel:(UserIconModel *)model{
    if (model != _model) {
//        _model = nil;
        _model = model;
        
        _imageView.frame = CGRectMake(0, 0, 40, 40);
//        _imageView.backgroundColor = kWhite(1);
        _imageView.image = [UIImage imageNamed:model.image];
       
        _label.frame = CGRectMake(CGRectGetMinX(_imageView.frame)-5, CGRectGetMaxY(_imageView.frame)+5, 50, 20);
        _label.text = model.name;
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touch) {
        _touch();
    }
}
@end
