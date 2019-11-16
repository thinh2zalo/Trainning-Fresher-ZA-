//
//  body.h
//  step4
//
//  Created by CPU11606 on 8/5/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+ParseJson.h"

NS_ASSUME_NONNULL_BEGIN

@interface Body : NSObject
@property (nonatomic) NSString *type;
@property (assign) NSString *descriptionOfProject;
@property (nonatomic) NSString *content;
-(Body *)initWithDict:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
