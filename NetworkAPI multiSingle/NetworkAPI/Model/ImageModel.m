//
//  image.m
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ImageModel.h"

@implementation Image
-(Image *)initWithDict:(NSDictionary *)dict{
    if (![dict isKindOfClass:NSDictionary.class]) {
        NSLog(@"dictionary is error ");
        return nil;
    }
    self = [super init];
    if(self){
        self.width = [dict getNSNumber:@"width"].floatValue;
        self.height = [dict getNSNumber:@"height"].floatValue;
        self.url = [dict getURL];
    }
    return self;
}@end
