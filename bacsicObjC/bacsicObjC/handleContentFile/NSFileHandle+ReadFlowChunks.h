//
//  NSFileHandle+ReadFlowChunks.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileHandle (ReadFlowChunks)
-(NSData *)ReadDataOfChunks:(NSInteger )sizeChunks totalSize:(unsigned long long )size;
@end

NS_ASSUME_NONNULL_END
