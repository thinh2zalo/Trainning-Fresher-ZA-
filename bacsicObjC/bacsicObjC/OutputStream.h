//
//  OutputStream.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Block)(NSFileHandle * fileHandle);
@interface OutputStream : NSFileHandle
@property (nonatomic) NSFileHandle * output;
-(OutputStream *)initWithPath:(NSString *)urlInput;
- (void)use :(Block )block;
@end

NS_ASSUME_NONNULL_END
