//
//  FeedAPIContact.h
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../ModelMessage/User.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedAPIContact : NSObject
+ (NSArray <User *> *) queryContact;
@end

NS_ASSUME_NONNULL_END
