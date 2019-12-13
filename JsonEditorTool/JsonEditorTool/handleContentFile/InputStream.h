//
//  InputStream.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/9/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stream.h"
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
NS_ASSUME_NONNULL_BEGIN

@interface InputStream : Stream
typedef void(^Block1)(InputStream * inputStream);
- (void)use :(Block1 )block;
-(InputStream *)initWithPath:(NSString *)urlInput;
-(NSData *)ReadDataOfChunks:(NSInteger )sizeChunks totalSize:(unsigned long long )size ;
@end

NS_ASSUME_NONNULL_END

// tao lop parents cho input_output stream.
// block la 1 stream luon chu khong phai NSFileHandle nua
// su dung block de load qua trinh load trong viec cat file , mergegile.

