//
//  NSFileManager+HandleContentFile.m
//  ProjectFresherZAMD
//
//  Created by CPU11606 on 8/8/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "HandleContentFile.h"
@implementation HandleContentFile
-(void)splitAFileIntoNFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N {
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    NSLog(@"%@",directoryPath);
    if (![fm fileExistsAtPath:directoryPath] || N == 0){
        NSLog(@"Link is error or N = 0");
    } else {
        NSFileHandle *inputFileHandle;
        NSFileHandle *outputFileHandle;
        NSLog(@"Link is not error");
        unsigned long long sizeOfFile = [self getSizeOfFileAtPath:directoryPath];
        unsigned long long sizeEachFileSplited = sizeOfFile/N;
        inputFileHandle = [NSFileHandle fileHandleForReadingAtPath: directoryPath];
        [inputFileHandle seekToFileOffset: 0];
        for (NSInteger i = 1 ; i <= N ; i++){
            // create a file with size = sizeEachFileSplited
            NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension] stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
            NSString* aPathWithStringAddedIndex =[NSTemporaryDirectory() stringByAppendingString:nameFile];
            NSLog(@"%@", aPathWithStringAddedIndex);
            [fm createFileAtPath:aPathWithStringAddedIndex contents: nil attributes: nil];
            outputFileHandle = [NSFileHandle fileHandleForWritingAtPath:aPathWithStringAddedIndex];
            [outputFileHandle seekToFileOffset: 0];
            NSData *inputDataBuffer;
            inputDataBuffer = [inputFileHandle readDataOfLength:sizeEachFileSplited];
            [outputFileHandle writeData: inputDataBuffer];
            NSLog(@"%@",inputDataBuffer);
            [outputFileHandle closeFile];
        }
        [inputFileHandle closeFile];
    }
}

-(void)mergeFileAtURL:(NSArray<NSURL*>*) listURL {
    if (![listURL isKindOfClass:NSArray.class]){
        NSLog(@"listURL ERROR");
    } else {
       NSString* newPath = [NSTemporaryDirectory() stringByAppendingString:@"fileSynthetic"] ;
        OutputStream * outputStream = [[OutputStream alloc] initWithPath:newPath];
        [outputStream use:^(NSFileHandle* output){
            for (NSURL *each in listURL) {
                InputStream *input = [[InputStream alloc] initWithURL:each];
                unsigned long long sizeOfFile = [self getSizeOfFileAtPath:each.path];
                [input use:^(NSFileHandle* input){
                    NSData *inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeOfFile];
                    [output writeData:inputDataBuffer];
                }];
            }
        }];
    }
}

-(void)splitAFileIntoNFileWithURL:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte {
    InputStream *inputStream = [[InputStream alloc] initWithURL:urlInput];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    if (![fm fileExistsAtPath:directoryPath] || NByte == 0){
        NSLog(@"Link is error");
    } else {
        @autoreleasepool {
            NSLog(@"Link is not error");
            unsigned long long sizeOfFile = [self getSizeOfFileAtPath:directoryPath];
            unsigned long long sizeOfRestOfFileSize = sizeOfFile % NByte;
            NSUInteger countFileHasTheSameByte = (sizeOfFile - sizeOfRestOfFileSize)/NByte;
            [inputStream use:^(NSFileHandle *input){
                unsigned long long __block readCurrent = 0;
                [input seekToFileOffset:0];
                for (NSInteger i = 1 ; i <= countFileHasTheSameByte + 1 ; i++){
                    NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension]
                                          stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
                    NSString* aPathWithStringAddedIndex = [NSTemporaryDirectory() stringByAppendingString:nameFile];
                    OutputStream *outputStream = [[OutputStream alloc] initWithPath:aPathWithStringAddedIndex];
                    [outputStream use:^(NSFileHandle* output){
                        [output seekToFileOffset:0];
                        NSData *inputDataBuffer;
                        if (readCurrent + NByte > sizeOfFile ){
                            inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeOfRestOfFileSize];
                        } else {
                            inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:NByte];
                        }
                        [output writeData: inputDataBuffer];
                        readCurrent = readCurrent + NByte;
                    }];
                }
            }];
        }
        
    }
}
-(unsigned long long)getSizeOfFileAtPath:(NSString *)path{
    NSError *attributesError = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path  error:&attributesError];
    unsigned long long sizeOfFile = [attributes fileSize];
    return sizeOfFile;

}
@end
