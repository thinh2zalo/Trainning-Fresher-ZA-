//
//  FeedAPi.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#define URLAPI @"https://api.baomoi.com/v1/contents/get/by-zone?api_key=ee7b8c7c7019f1b5c0674d41b125faf7&client_time=%20%20%201574241701&client_version=99.99.99&deviceName=iPhone%20XS&gy=403267000&img_size=a400x&os=ios&sig=c539bfdfa4ed73ec40e1f4c4c4b265a4&size=80&start=0&zone=c_0"

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FeedAPI.h"
#import "NetworkManager.h"
#import "../Model/ContentModel.h"
#import "../Model/DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedAPI : NSObject
@property (nonatomic, strong) AFURLSessionManager * sessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration * sessionConfiguration;
- (void)getContentsWithCompletion:(void(^)(NSArray<Content*>* arrContents, NSString * title ,NSString* errorMsg) ) completion ;
@end

NS_ASSUME_NONNULL_END
