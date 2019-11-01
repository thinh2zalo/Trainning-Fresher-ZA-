//
//  data.h
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"
#import "BoxModel.h"

#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject
@property (nonatomic) NSString * tittle;
@property (nonatomic) NSMutableArray * contents ;
@property (nonatomic) NSMutableArray * boxes ;
-(Data*)initWithDict:(NSDictionary *) dict;
@end
NS_ASSUME_NONNULL_END
