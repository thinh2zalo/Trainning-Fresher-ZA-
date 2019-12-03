//
//  KeyValuePair.h
//  JsonEditorTool
//
//  Created by Steve on 12/2/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KeyValuePair : NSObject <JsonModel>
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) id value;


@end

NS_ASSUME_NONNULL_END
