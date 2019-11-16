//
//  Question.h
//  categoryExample
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//


#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import "NSDictionary+ParseJson.h"
NS_ASSUME_NONNULL_BEGIN

@interface Question : NSObject
@property (nonatomic) NSInteger questionId;
@property (nonatomic) NSInteger date;
@property (nonatomic) NSInteger attributes;
@property (nonatomic) NSInteger publisherId;
@property (nonatomic) NSInteger categoryId;
@property (nonatomic) NSInteger answerCount;
@property (nonatomic) NSInteger serverIndex;
@property (nonatomic) NSString* title;
@property (nonatomic) NSURL* url;
@property (nonatomic) NSString* categoryZone;
@property (nonatomic) NSString* categoryName;
@property (nonatomic) NSString* publisherZone;
@property (nonatomic) NSString* publisherName;
@property (nonatomic) NSString* publisherIcon;
@property (nonatomic) NSMutableArray* images;
@property (nonatomic) NSArray* bodies;
-(Question *)initWithDict:(NSDictionary *) dict;
@end
NS_ASSUME_NONNULL_END


