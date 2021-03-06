//
//  NSFileManager+InteractWithFile.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#import <objc/runtime.h>
#import "NSFileManager+InteractWithFile.h"
static void *keyTemp;
@implementation NSFileManager (InteractWithFile)
- (void)setTestProperty:(NSNumber *)testProperty {
    objc_setAssociatedObject(self, &keyTemp , testProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)testProperty{
    return objc_getAssociatedObject(self, &keyTemp);
}
+(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andN:(NSUInteger)N andBlock:(BlockName)blockName{
    NSMutableArray<NSURL*>* fileUrls = NSMutableArray.new;
    NSString *directoryPath = urlInput.path;
    NSLog(@"%@",directoryPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath] || N == 0){
        NSLog(@"Link is error or N = 0");
    } else {
        NSLog(@"Link is not error");
        unsigned long long sizeOfFile = [self getSizeOfFileAtPath:directoryPath];
        unsigned long long sizeEachFileSplited = sizeOfFile/N;
        InputStream *input = [[InputStream alloc] initWithPath:urlInput.path];
        [input use:^(InputStream* input){
            for (NSInteger i = 1 ; i <= N ; i++){
                NSString *nameFile = [[[directoryPath lastPathComponent] stringByDeletingPathExtension]
                                      stringByAppendingString:[NSString stringWithFormat:@"(%tu)",i]];
                NSString* aPathWithStringAddedIndex =[NSTemporaryDirectory() stringByAppendingString:nameFile];
                OutputStream *output = [[OutputStream alloc]  initWithPath:aPathWithStringAddedIndex];
                
                NSData *inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeEachFileSplited];
                
                
                [output writeData:inputDataBuffer];
                float percent = ((float)i/(float)N) * 100;
                blockName(percent);
                [fileUrls addObject:[NSURL URLWithString:aPathWithStringAddedIndex]];
            }
        }];
        
    }
    return fileUrls;
}

+(void)mergeFileAtURL:(NSArray<NSURL*>*) listURL {
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
                    NSData *inputDataBuffer = [input ReadDataOfChunks:CHUNKS totalSize:sizeOfFile];
                    [output writeData:inputDataBuffer];
                }];
            }
        }];
    }
}

+(NSArray<NSURL*>*)splitAFileIntoNFileWithURL:(NSURL *)urlInput andNumberOfByte:(NSUInteger)NByte andBlock:(BlockName)blockName {
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
                        float percent = ((float)i/(float)countFileHasTheSameByte) * 100;
                        blockName(percent);
                        [fileUrls addObject:[NSURL URLWithString:aPathWithStringAddedIndex]];
                    }];
                    
                }
            }];
        }
    }
    return fileUrls;
}

+(unsigned long long)getSizeOfFileAtPath:(NSString *)path{
    NSError *attributesError = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path  error:&attributesError];
    unsigned long long sizeOfFile = [attributes fileSize];
    return sizeOfFile;
    
}
@end
