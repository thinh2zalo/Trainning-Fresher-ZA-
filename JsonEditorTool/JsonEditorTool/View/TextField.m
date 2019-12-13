//
//  TextField.m
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "TextField.h"

@implementation TextField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.frame = CGRectMake(0.0f, 0.0f, 0.0f, MIN_HEIGHT);
    self.returnKeyType = UIReturnKeyDone;
    self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
  
}


@end
