//
//  JsonModel2.h
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//
#import "OrderedDictionary.h"
#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "EnumTypeValueJson.h"

NS_ASSUME_NONNULL_BEGIN

@interface JsonModel : NSObject <IGListDiffable>

@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) JsonModel * parrent;

@property (nonatomic,readonly,getter=getTypeValue) TypeValue typeValue;

- (instancetype)initWithObject:(id) object andKey:(NSString *)key;

- (MutableOrderedDictionary *)toOrderDictionary;
- (NSArray *)toArray;

@end

NS_ASSUME_NONNULL_END
