//
//  NSFileManager+HandleContentFile.h
//  ProjectFresherZAMD
//
//  Created by CPU11606 on 8/8/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputStream.h"
#import "InputStream.h"
#import "NSFileHandle+ReadFlowChunks.h"
#define CHUNKS 100
@class OutputStream;
NS_ASSUME_NONNULL_BEGIN

@interface HandleContentFile :NSObject

-(void)splitFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N;
-(void)splitFileWithURLAndNumberSizeInput:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte ;
@end

NS_ASSUME_NONNULL_END
