//
//  ArrContainer.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ArrContainer.h"
#import "../Define.h"
#import "DictContainer.h"
#import "KeyValuePair.h"

@implementation ArrContainer

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {

    self = [super initWithObject:object andKey:key];
    if (self) {
        self.key = key;
        self.value = NSMutableArray.new;
        NSArray * arr = (NSArray *)object;
        for (int i = 0 ; i < arr.count; i++) {
            NSString * key = [NSString stringWithFormat:@"index %tu", i + 1];
            if (SAFE_TYPE(arr[i], NSDictionary)) {
                DictContainer * dictContainer = [[DictContainer alloc] initWithObject:arr[i] andKey:key];
                [self.value addObject:dictContainer];
            } else if (SAFE_TYPE(arr[i], NSArray)) {
                ArrContainer * arrContainer = [[ArrContainer alloc] initWithObject:arr[i] andKey:key];
                [self.value addObject:arrContainer];
            } else {
                JsonModel * arrWithoutKey = [[KeyValuePair alloc] initWithObject:arr[i] andKey:key];
                [self.value addObject:arrWithoutKey];

            }
        }
    }
    return self;
}



@end
