//
//  ArrContainer.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ArrayJM.h"
#import "../Define.h"
#import "DictionaryJM.h"
#import "KeyValuePair.h"
#import "JsonModelFactory.h"

@implementation ArrayJM

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {

    self = [super initWithObject:object andKey:key];
    if (self) {
        self.value = NSMutableArray.new;
        NSArray * arr = (NSArray *)object;
        for (int i = 0 ; i < arr.count; i++) {
            NSString * key = [NSString stringWithFormat:@"INDEX_ %tu", i + 1];
                JsonModel * jsonModel = [JsonModelFactory getJsonModel:arr[i] andKey:key];
            jsonModel.parrent = self;
                [self.value addObject:jsonModel];
            }
        }
    
    return self;
}

- (TypeValue)getTypeValue {
    return typeValueArray;
}

- (NSArray *)toArray {
    NSMutableArray * tempArr  = NSMutableArray.new;
//    NSMutableDictionary * dict = NSMutableDictionary.new;
    for (JsonModel * jsonModel in self.value) {
        switch (jsonModel.getTypeValue) {
            case typeValueDictionary:
                [tempArr addObject:[jsonModel toOrderDictionary]];
                break;
            case typeValueArray:
                [tempArr addObject:[jsonModel toArray]];
                break;
                
            default:
                [tempArr addObject:jsonModel.value];;
        }
    }
    return [tempArr copy];
}

@end
