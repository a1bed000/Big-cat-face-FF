//
//  LRBtn.m
//  YYSports
//
//  Created by k on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "LRBtn.h"

@implementation LRBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = self.titleLabel.center;
    center.x = self.imageView.frame.origin.x + self.titleLabel.frame.size.width/2;
    self.titleLabel.center = center;
    
    center = self.imageView.center;
    center.x = CGRectGetMaxX(self.imageView.frame) - self.imageView.frame.size.width/2;
    self.imageView.center = center;
}

@end
