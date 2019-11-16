//
//  FeedAPi.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "FeedAPI.h"



@implementation FeedAPI

- (void)getContentsWithCompletion:(void(^)(NSArray<Content*>* arrContents, NSString * title ,NSString* errorMsg) ) completion {
    
    NSURL * URL = [NSURL URLWithString:URLAPI];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL: URL];
    [NetworkManager.shareInstance request:request completion:^(id  _Nullable response, NSString * _Nullable errorMsg) {
        
        if ([response isKindOfClass:NSDictionary.class]) {
            NSDictionary* dataDict = (NSDictionary*) response;
            Data * data = [[Data alloc] initWithDict:dataDict];
            
            NSArray* arrayContents = data.contents;
            NSString * title = data.tittle;
            if ([arrayContents isKindOfClass:NSArray.class] && [title isKindOfClass:NSString.class]){
                completion(arrayContents, title ,nil);
            } else {
                completion(nil, @"" ,@"can not connect content");
            }
        } else {
            completion(nil,nil,errorMsg);
        }
    }];
    
}


- (NSURLSessionConfiguration *)sessionConfiguration {
    if (!_sessionConfiguration) {
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return _sessionConfiguration;
}
- (AFURLSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:self.sessionConfiguration];
        
    }
    return _sessionManager;
}


@end
