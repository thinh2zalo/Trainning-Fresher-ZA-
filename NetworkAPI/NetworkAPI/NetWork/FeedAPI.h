//
//  FeedAPi.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#define URLAPI @"https://api.baomoi.com/v1/contents/get/by-zone?zone=c_0&start=0&size=10&img_size=a500x&client_time=1572516830&apikey=b03078c4e74a833ac911fe07eac78bb5&sig=8679ba324d5fc0f83ab9be36b9ae042d"

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
