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
// check null & type
    self = [super initWithObject:object andKey:key];
    if (self) {
        self.value = NSMutableArray.new;

        NSDictionary * dict = (NSDictionary *)object;
        
        for (NSString * key in dict) {
            id value = [dict objectForKey:key];
            JsonModel * jsonModel = [JsonModelFactory getJsonModel:value andKey:key];
            jsonModel.parrent = self;
            [self.value addObject:jsonModel];

        }
    }
    return self;
}


- (TypeValue)getTypeValue {
    return typeValueDictionary;
}

- (MutableOrderedDictionary *)toOrderDictionary{
    MutableOrderedDictionary * tempDictionary = MutableOrderedDictionary.new;

    for (JsonModel * jsonModel in self.value) {
        NSDictionary * dict = NSDictionary.new;

        switch (jsonModel.getTypeValue) {
            case  typeValueDictionary:

                dict = [jsonModel toOrderDictionary];
                [tempDictionary setObject:dict forKey:jsonModel.key];
                break;
                
            case typeValueArray:
                
                [tempDictionary setObject:[jsonModel toArray] forKey:jsonModel.key];
                break;
            default:
                [tempDictionary setObject:jsonModel.value forKey:jsonModel.key];

        }
    }
    
    return [tempDictionary copy];
}

@end
