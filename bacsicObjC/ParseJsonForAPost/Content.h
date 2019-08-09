//
//  contents.h
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Image.h"
#import "NSDictionary+DictCategory.h"
NS_ASSUME_NONNULL_BEGIN

@interface Content : NSObject
@property (nonatomic) NSInteger contentId;
@property (nonatomic) NSString  *title;
@property (nonatomic) NSString* descriptionOfProject;
@property (nonatomic) NSInteger date;
@property (nonatomic) NSInteger attributes;
@property (nonatomic) NSURL  *url;
@property (nonatomic) NSURL* originalUrl;
@property (nonatomic) NSInteger publisherId;
@property (nonatomic) NSInteger  clusterId;
@property (nonatomic) NSString* publisherZone;
@property (nonatomic) NSInteger  categoryId;
@property (nonatomic) NSString* categoryZone;
@property (nonatomic) NSString* categoryName;
@property (nonatomic) NSURL* avatarURL;
@property (nonatomic) NSInteger  avatarWidth;
@property (nonatomic) NSInteger  avatarHeight;
@property (nonatomic) NSURL* publisherIcon;
@property (nonatomic) NSString* publicsherName;
@property (nonatomic) NSMutableArray  *images;
@property (nonatomic) NSInteger  commentCount;
@property (nonatomic) NSInteger  serverIndex;
-(Content *)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
