//
//  image.m
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Image.h"

@implementation image
-(image *)initWithDict:(NSDictionary *)dict{
self = [super init];
if(self){
    self.width = (NSInteger)[dict getNSNumber:@"width"];
    self.height = (NSInteger)[dict getNSNumber:@"height"];
    self.url = [dict getURL];
}
return self;
}@end
