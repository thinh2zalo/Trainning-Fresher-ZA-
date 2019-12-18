//
//  DictContainer.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "DictionaryJM.h"
#import "../Define.h"
#import "KeyValuePair.h"
#import "ArrayJM.h"
#import "JsonModelFactory.h"

@implementation DictionaryJM

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {

    self = [super initWithObject:object andKey:key];
    if (self) {
        self.value = NSMutableArray.new;

        NSDictionary * dict = (NSDictionary *)object;
        
        for (NSString * key in dict) {
            id value = [dict objectForKey:key];
            JsonModel * jsonModel = [JsonModelFactory getJsonModel:value andKey:key];
            [self.value addObject:jsonModel];

        }
    }
    return self;
}

- (TypeValue)getTypeValue {
    return typeValueDictionary;
}

- (NSDictionary *)toDictionary{
    NSMutableDictionary * tempDictionary = NSMutableDictionary.new;

    for (JsonModel * jsonModel in self.value) {
        NSDictionary * dict = NSDictionary.new;

        switch (jsonModel.getTypeValue) {
            case  typeValueDictionary:

                dict = [jsonModel toDictionary];
                [tempDictionary setValue:dict forKey:jsonModel.key];
                break;
                
            case typeValueArray:
                
                [tempDictionary setValue:[jsonModel toArray] forKey:jsonModel.key];
                break;
            default:
                [tempDictionary setValue:jsonModel.value forKey:jsonModel.key];

        }
    }
    
    return [tempDictionary copy];
}

@end
