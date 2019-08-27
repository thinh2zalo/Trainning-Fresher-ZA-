//
//  connectData.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/18/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../ParseJsonForAPost/DataModel.h"
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
NS_ASSUME_NONNULL_BEGIN

@interface ConnectData : NSObject
+ (NSArray <Content *> *)getNumberContent:(NSUInteger) number;
@end

NS_ASSUME_NONNULL_END
