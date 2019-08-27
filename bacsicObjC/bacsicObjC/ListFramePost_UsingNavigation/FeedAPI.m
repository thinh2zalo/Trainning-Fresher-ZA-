//
//  FeedAPI.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/27/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "FeedAPI.h"

@implementation FeedAPI
- (void)callAPI{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *result = [ConnectData getNumberContent:10];
        if ([result isKindOfClass:NSArray.class] && self->_delegate) {
            if (self->_delegate) {
                [self->_delegate updateArrContents:result];
            }
        }
    });
 
}
@end
