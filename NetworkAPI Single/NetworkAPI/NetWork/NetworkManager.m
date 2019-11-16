//
//  NetworkManager.m
//  NetworkAPI
//
//  Created by Steve on 10/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#define ERROR_MSG_NO_DATA @"Request get no data"
@interface NetworkManager()
@property  (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;
@property  (nonatomic, strong) AFURLSessionManager* sessionManager;

@end

@implementation NetworkManager

+ (NetworkManager *)shareInstance {
    static NetworkManager * networkManager = nil;
    if (!networkManager) {
        networkManager = NetworkManager.new;
    }
    return networkManager;
}

- (void)request:(NSURLRequest *)request  completion:(CompletionBlock) completion {
    
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            NSString* errorMsg = [self getErrorMsg:error];
            completion(nil,errorMsg);
        } else {
            NSDictionary * data = [(NSDictionary *) responseObject objectForKey:@"data"];
            
            if (data) {
                completion(data,nil);
            }else{
                completion(data,ERROR_MSG_NO_DATA);
            }
        }
    }];
    
    [dataTask resume];
    
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

-(NSString*) getErrorMsg:(NSError*) error {
    return error.debugDescription;
}

@end
