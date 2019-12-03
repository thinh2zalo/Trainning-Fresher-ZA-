//
//  Container.m
//  JsonEditorTool
//
//  Created by Steve on 12/2/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "Container.h"
#import "KeyValuePair.h"

@implementation Container

- (instancetype)initWithDict:(NSDictionary *)dict andKey:(NSString * )key{
    self = [super init];
        if (self) {
            for (NSString *key in [dict allKeys]) {
                id value = [dict objectForKey:key];
                NSString * str = [NSString stringWithFormat:@"%@", [value class]];
                if ([str isEqualToString:@"__NSDictionaryI"]) {
                    Container * container = [[Container alloc] initWithDict:value andKey:key];
                    [self.arrJsonModel addObject:container];
                } else {
                    const Class class = [value class];
                    KeyValuePair * keyValue = KeyValuePair.new;
                    keyValue.key = key;
                    keyValue.value = value;
                    [self.arrJsonModel addObject:keyValue];
                }
                
            }
        }
    return self;
    
}
- (NSMutableArray *)arrJsonModel {
    if (!_arrJsonModel) {
        _arrJsonModel = NSMutableArray.new;
    }
    return _arrJsonModel;
}

@end
