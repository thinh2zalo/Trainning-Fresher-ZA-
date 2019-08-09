//
//  NSFileManager+HandleContentFile.m
//  ProjectFresherZAMD
//
//  Created by CPU11606 on 8/8/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "HandleContentFile.h"
@implementation HandleContentFile

-(void)splitFileWithURLAndNumberSizeInput:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte {
    NSFileHandle *inputFileHandle;
    NSFileHandle *outputFileHandle;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    NSLog(@"%@",directoryPath);
    if (![fm fileExistsAtPath:directoryPath]){
        NSLog(@"Link is error");
    } else {
        @autoreleasepool {
            NSLog(@"Link is not error");
            NSError *attributesError = nil;
            NSDictionary *attributes = [fm attributesOfItemAtPath:  directoryPath  error:&attributesError];
            unsigned long long sizeOfFile = [attributes fileSize];
            unsigned long long sizeOfRestOfFileSize = sizeOfFile % NByte;
            NSUInteger countFileHasTheSameByte = (sizeOfFile - sizeOfRestOfFileSize)/NByte;
            inputFileHandle = [NSFileHandle fileHandleForReadingAtPath: directoryPath];
            [inputFileHandle seekToFileOffset: 0];
            unsigned long long readCurrent = 0;
            for (NSInteger i = 1 ; i <= countFileHasTheSameByte + 1 ; i++){
                NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension] stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
                NSString* aPathWithStringAddedIndex =[NSTemporaryDirectory() stringByAppendingString:nameFile];
                NSLog(@"%@", aPathWithStringAddedIndex);
                [fm createFileAtPath:aPathWithStringAddedIndex contents: nil attributes: nil];
                outputFileHandle = [NSFileHandle fileHandleForWritingAtPath:aPathWithStringAddedIndex];
                [outputFileHandle seekToFileOffset: 0];
                NSData *inputDataBuffer;
                if (readCurrent + NByte >  sizeOfFile ){
                    inputDataBuffer = [inputFileHandle readDataToEndOfFile];
                } else {
                    inputDataBuffer = [inputFileHandle readDataOfLength:NByte];
                }
                [outputFileHandle writeData: inputDataBuffer];
                NSLog(@"%@",inputDataBuffer);
                readCurrent = readCurrent + NByte;
                [outputFileHandle closeFile];
            }
            [inputFileHandle closeFile];
        }
        
    }
    
}
-(void)splitFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N {
    NSFileHandle *inputFileHandle;
    NSFileHandle *outputFileHandle;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    NSLog(@"%@",directoryPath);
    
    if (![fm fileExistsAtPath:directoryPath]){
        NSLog(@"Link is error");
    } else {
        NSLog(@"Link is not error");
        NSError *attributesError = nil;
        NSDictionary *attributes = [fm attributesOfItemAtPath:  directoryPath  error:&attributesError];
        unsigned long long sizeOfFile = [attributes fileSize];
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


@end
