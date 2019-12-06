//
//  JsonModekFactory.m
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "JsonModelFactory.h"
#import "JsonModel.h"
#import "ArrContainer.h"
#import "DictContainer.h"
#import "StringJM.h"
#import "NumberJM.h"
#import "BoolJM.h"
#import "NullJM.h"
#import "../Define.h"

@implementation JsonModelFactory
+ (JsonModel *) getJsonModel:(id) object andKey:(NSString *) key {
    JsonModel * jsonModel;
//    Class classType;
    if (SAFE_TYPE(object, NSDictionary)) {
        jsonModel = [[DictContainer alloc] initWithObject:object andKey:key];
    }
    else if (SAFE_TYPE(object, NSArray)) {
        jsonModel = [[ArrContainer alloc] initWithObject:object andKey:key];
    } else if (SAFE_TYPE(object, NSString)) {
        jsonModel = [[ArrContainer alloc] initWithObject:object andKey:key];
    } else if (SAFE_TYPE(object, NSNumber)){
        NSString * nameClass  = [NSString stringWithFormat:@"%@",[object class]];
        if ([nameClass isEqual:@"__NSCFBoolean"]) {
            jsonModel = [[BoolJM alloc] initWithObject:object andKey:key];
        } else {
            jsonModel = [[NumberJM alloc] initWithObject:object andKey:key];
        }
    } else  {
        jsonModel = [[NullJM alloc] initWithObject:object andKey:key];
    }

    return jsonModel;
    
}

@end
