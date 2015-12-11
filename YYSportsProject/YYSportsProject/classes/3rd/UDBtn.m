//
//  UDBtn.m
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "UDBtn.h"

@implementation UDBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;

    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    newFrame.size.height = 20;
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
