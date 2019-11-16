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

@interface Image : NSObject
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) NSURL  *url;
- (Image *) initWithDict:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
