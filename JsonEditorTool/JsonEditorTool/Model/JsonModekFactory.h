//
//  JsonModekFactory.h
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JsonModelFactory : NSObject
+ (JsonModel *) getJsonModel:(id) object andKey:(NSString *) key;
@end

NS_ASSUME_NONNULL_END
