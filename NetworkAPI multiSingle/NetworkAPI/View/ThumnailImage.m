//
//  Thumbnail.m
//  NetworkAPI
//
//  Created by Steve on 10/31/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ThumnailImage.h"

@implementation ThumnailImage

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 6.0f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
