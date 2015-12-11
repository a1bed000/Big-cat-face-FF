//
//  ClassificationSubjectModel.h
//  YYSportsProject
//
//  Created by k on 15/11/26.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubClassifyModel.h"
@interface ClassificationSubjectModel : NSObject
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString * rootClassifyName;
@property (nonatomic, copy) NSString * rootIcon;
@property (nonatomic, assign) NSInteger layer;
@property (nonatomic, assign) NSInteger rootClassifyId;
@property (nonatomic, strong) NSMutableArray * subClassifyList;
@end
