//
//  NSFileHandle+ReadFlowChunks.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSFileHandle+ReadFlowChunks.h"

@implementation NSFileHandle (ReadFlowChunks)
-(NSData *)ReadDataOfChunks:(NSInteger )sizeChunks totalSize:(unsigned long long )size {
    NSMutableData * mutableData = NSMutableData.new;
    unsigned long long currentSize = 0;
    while (currentSize < size){
        if (currentSize + sizeChunks < size){
             [mutableData appendData:[self readDataOfLength:sizeChunks]];
        }
        else {
            [mutableData appendData:[self readDataOfLength:(size-currentSize)]];
            break;
        }
        currentSize = currentSize + sizeChunks;
    }
    return mutableData;
}
@end
