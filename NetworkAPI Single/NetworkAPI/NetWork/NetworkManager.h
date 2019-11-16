//
//  NetworkManager.h
//  NetworkAPI
//
//  Created by Steve on 10/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CompletionBlock)(id _Nullable response , NSString * _Nullable  errorMsg);
@interface NetworkManager : NSObject
+ (NetworkManager *) shareInstance;

- (void) request:(NSURLRequest *) request  completion:(CompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
