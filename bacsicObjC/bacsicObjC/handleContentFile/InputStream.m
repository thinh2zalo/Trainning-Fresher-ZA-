//
//  InputStream.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/9/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
//
#import "InputStream.h"

@interface InputStream()


@end

@implementation InputStream
- (InputStream *)initWithPath:(NSString*)urlInput {
    self = [super init];
    if(self){

        self.fileHandle = [NSFileHandle fileHandleForReadingAtPath:urlInput];
    }
    return self;
}

- (void)use :(Block1 )block{
    if(self && block){
        block(self);
    }
    [self.fileHandle closeFile];
}


-(NSData *)ReadDataOfChunks:(NSInteger )sizeChunks totalSize:(unsigned long long )size {
    NSMutableData * mutableData = NSMutableData.new;
    unsigned long long currentSize = 0;
    while (currentSize < size){
        if (currentSize + sizeChunks < size){
            [mutableData appendData:[self.fileHandle readDataOfLength:sizeChunks]];
        }
        else {
            [mutableData appendData:[self.fileHandle readDataOfLength:(size-currentSize)]];
            break;
        }
        currentSize = currentSize + sizeChunks;
    }
    return mutableData;
}
@end

