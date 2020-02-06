//
//  FeedAPi.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#define URLAPI @"https://data.baomoi.com/app.aspx?method=settings&os=ios&ver=99.99.99"

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FeedAPI.h"
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedAPI : NSObject
@property (nonatomic, strong) AFURLSessionManager * sessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration * sessionConfiguration;
//- (void)getContentsWithCompletion:(void(^)(NSArray<Content*>* arrContents, NSString * title ,NSString* errorMsg) ) completion ;
@end

NS_ASSUME_NONNULL_END
