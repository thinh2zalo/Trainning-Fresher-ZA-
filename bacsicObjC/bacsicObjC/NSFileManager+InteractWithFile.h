//
//  NSFileManager+InteractWithFile.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stream.h"
#import "OutputStream.h"
#import "InputStream.h"
#import "NSFileHandle+ReadFlowChunks.h"
#define CHUNKS 100
typedef void(^BlockName)(float  process);
NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (InteractWithFile)
+(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N;
+(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte andBlock:(BlockName)blockName ;
+(void)mergeFileAtURL:(NSArray<NSURL*>*) listURL;
+(unsigned long long)getSizeOfFileAtPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
