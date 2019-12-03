//
//  KeyValuePair2.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "KeyValuePair2.h"

@implementation KeyValuePair2
- (instancetype)initWithObject:(id)object andKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = object;
    }
    return self;
}
@end
