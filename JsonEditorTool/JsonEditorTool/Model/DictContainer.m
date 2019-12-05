//
//  DictContainer.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "DictContainer.h"
#import "../Define.h"
#import "KeyValuePair.h"
#import "ArrContainer.h"

@implementation DictContainer

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {

    self = [super initWithObject:object andKey:key];
    if (self) {
        self.value = NSMutableArray.new;
        self.key = key;
        self.typeValue = typeValueDictionary;
        NSDictionary * dict = (NSDictionary *)object;
        
        for (NSString * key in dict) {
            id value = [dict objectForKey:key];
            if (SAFE_TYPE(value, NSDictionary)) {
                DictContainer * dictContainer = [[DictContainer alloc] initWithObject:value andKey:key];
                [self.value addObject:dictContainer];
            }
            else if (SAFE_TYPE(value, NSArray)) {
                ArrContainer * arr = [[ArrContainer alloc] initWithObject:value andKey:key];
                [self.value addObject:arr];
                
            } else {
                KeyValuePair * keyValue = KeyValuePair.new;
                keyValue.key = key;
                keyValue.value = value;
                [self.value addObject:keyValue];
            }
        }
    }
    return self;
}


@end
