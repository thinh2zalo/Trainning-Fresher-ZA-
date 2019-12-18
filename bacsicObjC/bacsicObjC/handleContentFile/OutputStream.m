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
    if (![outputFile isKindOfClass:NSString.class]) {
        NSLog(@"path is error");
        return nil;
    }
    
    self = [super init];
    if(self){
        if(![[NSFileManager defaultManager] fileExistsAtPath:outputFile ]){
            [[NSFileManager defaultManager] createFileAtPath:outputFile contents: nil attributes: nil];
        }
        self.fileHandle = [NSFileHandle fileHandleForWritingAtPath: outputFile];
    }
    return self;
}
-(void)writeData:(NSData *)data{
    [self.fileHandle writeData:data];
    
}
- (void)use :(Block )block{
    if(self && block){
        block(self);
    }
     [self.fileHandle closeFile];
}

@end

