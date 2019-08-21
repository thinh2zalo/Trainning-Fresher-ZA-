//
//  boxes.h
//  step4
//
//  Created by CPU11606 on 8/5/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#import <Foundation/Foundation.h>
#import "QuestionModel.h"
#import "NSDictionary+ParseJson.h"
NS_ASSUME_NONNULL_BEGIN
@interface Box : NSObject
@property (nonatomic) NSInteger position;
@property (nonatomic) NSInteger sectionBoxId;
@property (nonatomic) NSInteger displayType;
@property (nonatomic) NSInteger objectType;
@property (nonatomic) NSInteger maxShow;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *zone;
@property (nonatomic) NSArray  *positions;
@property (nonatomic) NSMutableArray  *questions;
-(Box *)initWithDict:(NSDictionary *) dict;
@end

NS_ASSUME_NONNULL_END


