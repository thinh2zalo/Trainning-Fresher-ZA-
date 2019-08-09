//
//  image.h
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+ParseJson.h"
NS_ASSUME_NONNULL_BEGIN

@interface image : NSObject
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSURL  *url;
- (image *) initWithDict:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
