//
//  JsonModel2.h
//  JsonEditorTool
//
//  Created by Steve on 12/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonModel2 : NSObject

@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) id value;
- (instancetype)initWithObject:(id) object andKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
