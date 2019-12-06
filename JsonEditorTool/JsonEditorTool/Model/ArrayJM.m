//
//  ArrContainer.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ArrayJM.h"
#import "../Define.h"
#import "DictContainer.h"
#import "KeyValuePair.h"
#import "JsonModelFactory.h"

@implementation ArrayJM

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {

    self = [super initWithObject:object andKey:key];
    if (self) {
        self.value = NSMutableArray.new;
        NSArray * arr = (NSArray *)object;
        for (int i = 0 ; i < arr.count; i++) {

            if (SAFE_TYPE(arr[i], NSDictionary) || SAFE_TYPE(arr[i], NSArray)) {
                JsonModel * jsonModel = [JsonModelFactory getJsonModel:arr[i] andKey:key];
                [self.value addObject:jsonModel];
            
            } else {
                NSString * key = [NSString stringWithFormat:@"index %tu", i + 1];
                JsonModel * arrWithoutKey = [[JsonModel alloc] initWithObject:arr[i] andKey:key];
                [self.value addObject:arrWithoutKey];

            }
        }
    }
    return self;
}
- (TypeValue)getTypeValue {
    return typeValueArray;
}


@end
