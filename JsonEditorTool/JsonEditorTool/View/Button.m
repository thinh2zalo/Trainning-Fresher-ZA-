//
//  Button.m
//  JsonEditorTool
//
//  Created by Steve on 12/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "Button.h"

@implementation Button

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 3.0f;
    }
    return self;
}

@end
