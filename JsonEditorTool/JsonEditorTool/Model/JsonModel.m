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

- (id<NSObject>)diffIdentifier {
    return self.key;
}

- (TypeValue)typeValue {
    if (!_typeValue) {
        if (SAFE_TYPE(self.value, NSMutableDictionary)) {
            _typeValue = typeValueDictionary;
        } else if (SAFE_TYPE(self.value, NSMutableArray)) {
            _typeValue = typeValueArray;
        } else if (SAFE_TYPE(self.value, NSString)) {
            _typeValue = typeValueString;
        } else if (SAFE_TYPE(self.value, NSNumber)){
            NSString * nameClass = [NSString stringWithFormat:@"%@", [self.value class]];
            if ([nameClass isEqual:@"__NSCFBoolean"]) {
                _typeValue = typeValueBool;
            } else {
                _typeValue = typeValueNumber;
            }
        } else  {
            _typeValue = typeValueNull;
        }
       
    }
    return _typeValue;
}

// MARK: ListDiffable
- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    if (self == object) {
        return true;
    }
    JsonModel * jsonModel = (JsonModel *) object;
    return  [self.value isEqual:jsonModel.value ];
}

@end
