//
//  NetworkManager.m
//  NetworkAPI
//
//  Created by Steve on 10/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "NetworkManager.h"
#import "../../Pods/AFNetworking/AFNetworking/AFNetworking.h"
#import "M13OrderedDictionary.h"
#import "HandleContentFile.h"
#import "OrderedDictionary.h"
#import "XMLReader.h"
#import "JSONKit.h"
#define ERROR_MSG_NO_DATA @"Request get no data"

@interface NetworkManager() <NSXMLParserDelegate>
@property  (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;
@property  (nonatomic, strong) AFURLSessionManager* sessionManager;
@property  (nonatomic, strong) NSDictionary* dict;

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
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
            options:kNilOptions
              error:&error];
            
            if (![[json objectForKey:@"errorMsg"]  isEqual: @"Not Exists"]) {
                NSLog(@"VAO DAY HA ???");
                completion(responseObject,nil);
            } else {
                completion(nil,ERROR_MSG_NO_DATA);
            }
        }
    }];
    [dataTask resume];
    
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = NSDictionary.new;
    }
    return _dict;
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
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

-(NSString*) getErrorMsg:(NSError*) error {
    return error.debugDescription;
}

@end
