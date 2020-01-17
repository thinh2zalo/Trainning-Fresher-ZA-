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
@interface ManagerRecord()
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSMutableArray <JsonModel *> *arrJsonModel;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
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

- (void)setEndpoint:(EndPoint *)endPoint {
    if (!endPoint) {
        return;
    }
    self.currentEndPoint = endPoint;
}


- (void)start:(ManageCompletionBlock)completion {
    if (!completion) {
        return;
    }
    if (self.arrJsonModel) {
        completion(self.arrJsonModel);
    } else {
        [self loadData:^(id results, NSString *errorMess) {
            [self parseJson:results];
            completion(self.arrJsonModel);
        }];
    }
}




- (void)insertJsonModel:(JsonModel *)JM inTableName:(NSString *)tableName completion:(ManageCompletionBlock) completion {
    [self fetchTable:tableName andCompletion:^(NSMutableArray <JsonModel *>*  results) {
        [results addObject:JM];
        completion(self.arrJsonModel);
        
    }];
}



- (void)removeModelFormTableName:(NSString *)tableName andKey:(NSString *)key andCompletion:(ManageCompletionBlock)completion {
    if (!completion) {
        return;
    }
    [self fetchTable:tableName andCompletion:^(NSMutableArray <JsonModel *>*  results) {
        if ([results isKindOfClass:NSMutableArray.class]) {
            NSUInteger index =[self indexOfKey:key  inArray:results];
            if (index != -1) {
                [results removeObjectAtIndex:index];
                completion(results);
                
            }
        }
        
    }];
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

- (void)fetchTable:(NSString *)tableName
     andCompletion:(ManageCompletionBlock) completion {
    if (!completion) {
        return;
    }
    
    NSArray * arr = [tableName componentsSeparatedByString:@"."];
    NSMutableArray <JsonModel *> *tempArr = [NSMutableArray arrayWithArray:self.arrJsonModel];
    
    // considering ???
    for (NSUInteger i = 0 ; i < arr.count; i++) {
        for (JsonModel *jm in tempArr) {
            if ([jm.key isEqualToString:arr[i]]) {
                tempArr = jm.value;
                break;
            }
        }
    }
    completion(tempArr);
    
}


- (void)parseJson:(NSData *)data {
    if ([data isKindOfClass:NSData.class]) {
        OrderedDictionary * resultDict = [JsonSerializationCustom JSONObjectWithData:data options:0 error:nil];
        resultDict = [resultDict objectForKey:@"result"];
        self.arrJsonModel = [[[DictionaryJM alloc] initWithObject:resultDict andKey:@"results"] value];
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
                
                completion(results,@"success");
                
            }
        }
    }];
}


- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("operation", 0);
    }
    return _queue;
}

- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return _semaphore;
}


@end
