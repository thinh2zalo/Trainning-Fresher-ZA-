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

@implementation ArrContainer

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = NSMutableArray.new;
        NSArray * arr = (NSArray *)object;
        for (int i = 0 ; i < arr.count; i++) {
            if (SAFE_TYPE(arr[i], NSDictionary)) {
                DictContainer * dictContainer = [[DictContainer alloc] initWithObject:arr[i] andKey:[NSString stringWithFormat:@"%tu", i]];
                [self.value addObject:dictContainer];
            } else if (SAFE_TYPE(arr[i], NSArray)) {
                ArrContainer * arrContainer = [[ArrContainer alloc] initWithObject:arr[i] andKey:[NSString stringWithFormat:@"%tu", i]];
                [self.value addObject:arrContainer];
            } else {
                [self.value addObject:arr[i]];
            }
        }
    }
    return self;
}





@end
