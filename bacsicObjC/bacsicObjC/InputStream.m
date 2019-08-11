//
//  InputStream.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/9/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "InputStream.h"

@interface InputStream()


@end

@implementation InputStream
- (InputStream *)initWithURL:(NSURL*)urlInput {
    self = [super init];
    if(self){
        NSError *error = nil;
        _input = [NSFileHandle fileHandleForReadingFromURL:urlInput error:&error];
    }
    return self;
}
- (void)use :(Block )block{
    if(_input && block ){
    block(_input);
    [_input closeFile];
    }
}

@end
