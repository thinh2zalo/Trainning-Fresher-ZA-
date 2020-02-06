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

typedef void(^isSuccessBlock)(BOOL isSuccess);
typedef void(^completionBlock)(JsonModel  * _Nullable results , NSString * _Nullable errorMSG);

@interface ManagerRecord : NSObject


+ (ManagerRecord *)shareInstance;

- (void)setEndpoint:(EndPoint *)endPoint;

- (void)start:(completionBlock)completion;
// remove JsonModel with keyName in table with TableName
- (void)removeModelFormTableName:(NSString *)tableName andKey:(NSString *)key andCompletion:(isSuccessBlock) completion;
// insert JsonModel in tableName at index
- (void)insertJsonModel:(JsonModel *)JM inTableName:(NSString *)tableName atIndex:(NSUInteger)index completion:(isSuccessBlock) completion;
// search JsonModel with tableName ex:settings.applicationId
- (JsonModel *)fetchJsonModel:(NSString *)tableName;
// insert + remove at current jsonModel which showed UI
- (void)insertJsonModel:(JsonModel *)JM  atIndex:(NSUInteger)index completion:(isSuccessBlock) completion;
- (void)removeJsonModelWithKey:(NSString *)key completionBlock:(isSuccessBlock)completion;
// set currentJsonmodel which showed on UI
- (void)setCurrentJsonModelWithKey:(NSString *)levelKey;

@end

NS_ASSUME_NONNULL_END
