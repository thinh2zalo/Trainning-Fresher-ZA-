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
-(void)splitAFileIntoNFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N;
-(void)splitAFileIntoNFileWithURL:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte ;
-(void)mergeFileAtURL:(NSArray<NSURL*>*) listURL;
-(unsigned long long)getSizeOfFileAtPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
