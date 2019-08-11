//
//  OutputStream.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "OutputStream.h"

@interface OutputStream()


@end

@implementation OutputStream
- (OutputStream *)initWithPath:(NSString *)outputFile {
    self = [super init];
    if(self){
        [[NSFileManager defaultManager] createFileAtPath:outputFile contents: nil attributes: nil];
        NSError *error = nil;
         _output = [NSFileHandle fileHandleForWritingAtPath: outputFile];     
    }
    return self;
}
- (void)use :(Block )block{
    if(_output && block){
        block(_output);
        [_output closeFile];
    }
}

@end

