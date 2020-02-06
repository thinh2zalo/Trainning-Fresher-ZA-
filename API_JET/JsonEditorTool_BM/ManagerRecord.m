//
//  ManagerRecord.m
//  JsonEditorTool_BM
//
//  Created by vincent on 1/15/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ManagerRecord.h"
#import "NetworkManager.h"
#import "JsonSerializationCustom.h"
#define ERROR_MSG @"Request incorrect tableName"

@interface ManagerRecord()
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) JsonModel * allJsonModel;
@property (nonatomic, strong) JsonModel * currentJsonModel;
@property (nonatomic, strong) EndPoint * currentEndPoint;

@end
@implementation ManagerRecord

+ (ManagerRecord *)shareInstance {
    static ManagerRecord * shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = ManagerRecord.new;
    });
    return shareInstance;
}



- (void)start:(completionBlock)completion {
    if (!completion) {
        return;
    }
    if (self.allJsonModel) {
        completion(self.allJsonModel, nil);
    } else {
        [self loadData:^(id results, NSString *errorMess) {
            if ([results isKindOfClass:NSData.class]) {
                [self parseJson:results];
                completion(self.allJsonModel, nil);
            }
        }];
    }
}

- (void)insertJsonModel:(JsonModel *)JM inTableName:(NSString *)tableName atIndex:(NSUInteger)index completion:(isSuccessBlock) completion {
    if (!completion) {
        return;
    }
    JsonModel * results = [self fetchJsonModel:tableName];
    if ([results.value isKindOfClass:NSMutableArray.class]) {
        [results.value insertObject:JM atIndex:index];
        completion(true);
    } else {
        completion(false);
    }
}


- (void)removeModelFormTableName:(NSString *)tableName andKey:(NSString *)key andCompletion:(isSuccessBlock)completion {
    if (!completion) {
        return;
    }
    JsonModel * results = [self fetchJsonModel:tableName];
    if ([results.value isKindOfClass:NSMutableArray.class]) {
        NSUInteger index = [self indexOfKey:key  inArray:results.value];
        if (index != -1) {
            [results.value removeObjectAtIndex:index];
            completion(true);
        }
    } else {
        completion(false);
    }
    
}

- (void)insertJsonModel:(JsonModel *)JM  atIndex:(NSUInteger)index completion:(isSuccessBlock) completion {
    if (!completion && !self.currentJsonModel) {
        return;
    }
    [self.currentJsonModel.value insertObject:JM atIndex:index];
    completion(true);
}



- (void)removeJsonModelWithKey:(NSString *)key completionBlock:(isSuccessBlock)completion {
    if (!completion && !self.currentJsonModel) {
        completion(false);
        
    }
    NSUInteger index = [self indexOfKey:key  inArray:self.currentJsonModel.value];
    if (index != -1) {
        [self.currentJsonModel.value removeObjectAtIndex:index];
        completion(true);
    } else {
        completion(false);
    }
}


- (void)setCurrentJsonModelWithKey:(NSString *)levelKey {
    if (!levelKey) {
        return;
    } else {
        self.currentJsonModel = [self getJsonModelToEditAtLevelKey:levelKey];
    }
}


// search  JsonModel
- (JsonModel *)fetchJsonModel:(NSString *)levelKey {
    if ([levelKey isEqualToString:@"all"]) {
        return self.allJsonModel;
    }
    NSArray * arr = [levelKey componentsSeparatedByString:@"."];
    JsonModel *tempJsonModel = self.allJsonModel;
    BOOL isStringCorrect;
    
    for (NSUInteger i = 0 ; i < arr.count; i++) {
        isStringCorrect = false;
        for (JsonModel *jm in tempJsonModel.value) {
            if ([jm.key isEqualToString:arr[i]]) {
                isStringCorrect = true;
                tempJsonModel = jm;
                break;
            }
        }
        if (!isStringCorrect) {
            return nil;
        }
    }
    return [tempJsonModel copy] ;
}

- (void)parseJson:(NSData *)data {
    if ([data isKindOfClass:NSData.class]) {
        OrderedDictionary * resultDict = [JsonSerializationCustom JSONObjectWithData:data options:0 error:nil];
        resultDict = [resultDict objectForKey:@"result"];
        if ([resultDict isKindOfClass:OrderedDictionary.class]) {
            self.allJsonModel = [[DictionaryJM alloc] initWithObject:resultDict andKey:@"results"];
        }
    }
}

- (void)loadData:(CompletionBlock)completion {
    if (!completion) {
        return;
    }
    NSURL * url = [NSURL URLWithString:self.currentEndPoint.urlRequest];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NetworkManager.shareInstance request:request completion:^(id results, NSString *erroMess) {
        if (erroMess) {
            NSLog(@"%@", erroMess);
        } else {
            if ([results isKindOfClass:NSData.class]) {
                completion(results, @"success");
            }
        }
    }];
}

- (JsonModel *)getJsonModelToEditAtLevelKey:(NSString *)levelKey {
    if ([levelKey isEqualToString:@"all"]) {
        return self.allJsonModel;
    }
    NSArray * arr = [levelKey componentsSeparatedByString:@"."];
    JsonModel *tempJsonModel = self.allJsonModel;
    BOOL isStringCorrect;
    
    for (NSUInteger i = 0 ; i < arr.count; i++) {
        isStringCorrect = false;
        for (JsonModel *jm in tempJsonModel.value) {
            if ([jm.key isEqualToString:arr[i]]) {
                isStringCorrect = true;
                tempJsonModel = jm;
                break;
            }
        }
        if (!isStringCorrect) {
            return nil;
        }
    }
    return tempJsonModel ;
}

- (NSUInteger)indexOfKey:(NSString *)key inArray:(NSArray <JsonModel *> *)table {
    NSUInteger i = 0;
    for (JsonModel *jm in table) {
        if ([jm.key isEqualToString:key]) {
            return i;
        }
        i++;
    }
    return -1;
}


- (void)setEndpoint:(EndPoint *)endPoint {
    if (!endPoint) {
        return;
    }
    self.currentEndPoint = endPoint;
}


- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("operation", 0);
    }
    return _queue;
}

@end
