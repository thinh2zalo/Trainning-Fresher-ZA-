//
//  JsonModel2.h
//  JsonEditorTool
//
//  Created by Steve on 12/2/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JsonModel
@property(nonatomic, strong) NSString * key;

- (NSDictionary *)serialize;
@end

NS_ASSUME_NONNULL_END
