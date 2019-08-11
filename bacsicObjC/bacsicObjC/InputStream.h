//
//  InputStream.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/9/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Block)(NSFileHandle * fileHandle);
@interface InputStream : NSFileHandle
@property (nonatomic) NSFileHandle * input;
-(InputStream *)initWithURL:(NSURL*)urlInput;
- (void)use :(Block )block;
@end

NS_ASSUME_NONNULL_END
