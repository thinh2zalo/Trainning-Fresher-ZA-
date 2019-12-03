//
//  Container.h
//  JsonEditorTool
//
//  Created by Steve on 12/2/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Define.h"
#import "JsonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Container : NSObject <JsonModel>
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSMutableArray <id<JsonModel>> * arrJsonModel;
- (instancetype)initWithDict:(NSDictionary *)dict andKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
