//
//  ManagerRecord.h
//  JsonEditorTool_BM
//
//  Created by vincent on 1/15/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import  "Model.h"
#import "EndPoint.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ManageCompletionBlock)(NSMutableArray <JsonModel *>*  results);
typedef void(^ReturnJonModel)(JsonModel *  results);

@interface ManagerRecord : NSObject
@property (nonatomic, strong) NSData * rawData;


+ (ManagerRecord *)shareInstance;

- (void)setEndpoint:(EndPoint *)endPoint;

- (void)start:(ManageCompletionBlock)completion;

- (void)removeModelFormTableName:(NSString *)tableName andKey:(NSString *)key andCompletion:(ManageCompletionBlock) completion;
- (void)insertJsonModel:(JsonModel *)JM inTableName:(NSString *)tableName completion:(ManageCompletionBlock) completion;
- (void)jsonModelAt:(NSString *)tableName withKey:(NSString *) completion:(ReturnJonModel) completion;


@end

NS_ASSUME_NONNULL_END
