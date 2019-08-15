//
//  NSArray+ListSatisfyFile.h
//  ManagerFile
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreServices/CoreServices.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ListSatisfyFile)
+(NSArray *)allFileOfPath:(NSURL *) urlInput ;
/**
 <#Description#>

 @param typeInput kUTTypeImage, kUTTypeMovie kUTTypeText
 @param URLInput URL
 @return Array name file satisfy typeInput
 */
+(NSArray *)allFileWithFormatType:(CFStringRef )typeInput andURL:(NSURL *) urlInput;
/**
 <#Description#>

 @param byteInput number of byte
 @param URLInput URL
 @return number of deleted file
 */
+(NSInteger )deleteAllFileGreaterThanNByte:(unsigned long long) byteInput atURL:(NSURL *) urlInput;
@end

NS_ASSUME_NONNULL_END
