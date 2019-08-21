//
//  NSFileManager+HandleContentFile.m
//  ProjectFresherZAMD
//
//  Created by CPU11606 on 8/8/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "HandleContentFile.h"
@implementation HandleContentFile
-(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N  {
    NSMutableArray<NSURL*>* fileUrls = NSMutableArray.new;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *directoryPath = urlInput.path;
    NSLog(@"%@",directoryPath);
    if (![fm fileExistsAtPath:directoryPath] || N == 0){
        NSLog(@"Link is error or N = 0");
    } else {
        unsigned long long sizeOfFile = [self getSizeOfFileAtPath:directoryPath];
        unsigned long long sizeEachFileSplited = sizeOfFile/N;
        InputStream *input = [[InputStream alloc] initWithPath:urlInput.path];
        [input use:^(InputStream* input){
            for (NSInteger i = 1 ; i <= N ; i++){
                
                NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension]
                                      stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
                NSString* aPathWithStringAddedIndex =[NSTemporaryDirectory() stringByAppendingString:nameFile];
                OutputStream *output = [[OutputStream alloc]  initWithPath:aPathWithStringAddedIndex];
                
                if (SAFE_TYPE(input, InputStream)) {
                    NSData *inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeEachFileSplited];
                    [output writeData:inputDataBuffer];
                    [fileUrls addObject:[NSURL URLWithString:aPathWithStringAddedIndex]];
                } else { NSLog(@"input error"); }
            }
        }];
    }
    return fileUrls;
}

-(void)mergeFileAtURL:(NSArray<NSURL*>*) listURL {
    if (![listURL isKindOfClass:NSArray.class]){
        NSLog(@"listURL ERROR");
    } else {
        NSString* newPath = [NSTemporaryDirectory() stringByAppendingString:@"fileSynthetic.jpg"] ;
        OutputStream * outputStream = [[OutputStream alloc] initWithPath:newPath];
        [outputStream use:^(OutputStream* output){
            for (NSURL *each in listURL) {
                InputStream *input = [[InputStream alloc] initWithPath:each.path];
                unsigned long long sizeOfFile = [self getSizeOfFileAtPath:each.path];
                    [input use:^(InputStream* input){
                        if (SAFE_TYPE(input, InputStream)) {
                            NSData *inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeOfFile];
                            [output writeData:inputDataBuffer];
                        }
                        else {
                            NSLog(@"input is error");
                        }
                }];
            }
        }];
    }
}

-(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte andBlock:(BlockName)blockName {
    
    NSMutableArray<NSURL*>* fileUrls = NSMutableArray.new;
    InputStream *inputStream = [[InputStream alloc] initWithPath:urlInput.path];
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
            NSLog(@"%tu", countFileHasTheSameByte);
            [inputStream use:^(InputStream * input){
                if (SAFE_TYPE(input, InputStream)) {
                    unsigned long long __block readCurrent = 0;
                    for (NSInteger i = 1 ; i <= countFileHasTheSameByte + 1 ; i++){
                        NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension]
                                              stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
                        NSString* aPathWithStringAddedIndex = [NSTemporaryDirectory() stringByAppendingString:nameFile];
                        OutputStream *outputStream = [[OutputStream alloc] initWithPath:aPathWithStringAddedIndex];
                        [outputStream use:^(OutputStream* output){
                            NSData *inputDataBuffer;
                            if (readCurrent + NByte > sizeOfFile ){
                                inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeOfRestOfFileSize];
                            } else {
                                inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:NByte];
                            }
                            [output writeData: inputDataBuffer];
                            readCurrent = readCurrent + NByte;
                            float percent = ((float)i/(float)(countFileHasTheSameByte + 1 )) * 100;
                            
                            blockName(percent);
                        }];
                        [fileUrls addObject:[NSURL URLWithString:aPathWithStringAddedIndex]];
                    }
                } else {
                    NSLog(@"input is not error");
                }
            
                
         
            }];
        }
    }
    
    return fileUrls;
}

-(unsigned long long)getSizeOfFileAtPath:(NSString *)path{
    NSError *attributesError = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path  error:&attributesError];
    unsigned long long sizeOfFile = [attributes fileSize];
    return sizeOfFile;
    
}
@end
