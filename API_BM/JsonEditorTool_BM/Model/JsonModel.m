//
//  JsonModel2.m
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "JsonModel.h"
#import "../Define.h"

@implementation JsonModel

- (instancetype)initWithObject:(id)object andKey:(NSString *)key {
    NSAssert(object != nil, @"object is null");

    self = [super init];
    if (self) {
        self.key = key;
        self.value = object;
    }
    return self;
}

// MARK: ListDiffable


//- (id<NSObject>)diffIdentifier {
//    return self;
//}
//
//
//
//- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
//    if (self == object) {
//        return true;
//    }
//    JsonModel * jsonModel = (JsonModel *) object;
//    return  self.value == jsonModel.value && self.key == jsonModel.key ;
//}


@end
