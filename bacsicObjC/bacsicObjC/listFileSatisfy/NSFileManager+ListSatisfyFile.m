//
//  NSArray+ListSatisfyFile.m
//  ManagerFile
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSFileManager+ListSatisfyFile.h"

@implementation NSFileManager (ListSatisfyFile)
+(NSArray *)allFileOfPath:(NSURL *) urlInput {
    if([urlInput isKindOfClass:NSURL.class]){
        return @[];
    }
    NSString *directoryPath = urlInput.path;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSMutableArray *arrResultsAllFile = [[NSMutableArray alloc] init];
    NSArray* dirs = [fm contentsOfDirectoryAtURL:urlInput includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    if (dirs == nil  && ![fm fileExistsAtPath:directoryPath]) {
        [arrResultsAllFile addObject:[urlInput lastPathComponent]];
    }
    else {
        if([dirs isKindOfClass:NSArray.class]){
        for(NSString * str in dirs){
            [arrResultsAllFile addObject:[str lastPathComponent]];
            }
        }
    }
    return arrResultsAllFile;
}
+(NSArray *)allFileWithFormatType:(CFStringRef )typeInput andURL:(NSURL *) urlInput{
    if([urlInput isKindOfClass:NSURL.class]){
        return @[];
    }
    NSFileManager * fm = [NSFileManager defaultManager];
    NSMutableArray *arrResultsAllFile = [[NSMutableArray alloc] init];
    NSArray* dirs = [fm contentsOfDirectoryAtURL:urlInput includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    for (NSString * str in dirs){
        CFStringRef fileExtension = (__bridge CFStringRef) [str pathExtension];
        CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
        if (UTTypeConformsTo(fileUTI, typeInput)) {
            [arrResultsAllFile addObject:[str lastPathComponent]];
        }
         CFRelease(fileUTI);
    }
    return arrResultsAllFile;
}
+(NSInteger )deleteAllFileGreaterThanNByte:(unsigned long long) byteInput atURL:(NSURL *) urlInput{
    if([urlInput isKindOfClass:NSURL.class]){
        return -1;
    }
    NSInteger countDeletedFile=0;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    NSArray *arrPath = [fm contentsOfDirectoryAtPath: directoryPath error:NULL];
    for (NSString * aStrPath in arrPath){
        NSString *docPath = [directoryPath stringByAppendingPathComponent:aStrPath];
        NSError *attributesError = nil;
        NSDictionary *attributes = [fm attributesOfItemAtPath:[directoryPath stringByAppendingPathComponent:aStrPath] error:&attributesError];
        unsigned long long sizeOfFile = [attributes fileSize];
        if(sizeOfFile > byteInput){
            if([fm removeItemAtPath:docPath error:&attributesError]){
                countDeletedFile++;
            }
        }
    }
    return countDeletedFile;
}

@end
