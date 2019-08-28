//
//  FeedAPI.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/27/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "FeedAPI.h"

@implementation FeedAPI
- (void)callAPI:(NSUInteger)numberContent{
    if (numberContent > 10 ) {
        NSLog(@"out of size content");
    }


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"call API FeedAPI");

        NSArray *result = [ConnectData getNumberContent:numberContent];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([result isKindOfClass:NSArray.class] && self.delegate) {
                if (self.delegate && [self->_delegate respondsToSelector:@selector(updateArrContents:)]) {
                    [self.delegate updateArrContents:result];
                }
            }
        });
    });
 
}
@end
