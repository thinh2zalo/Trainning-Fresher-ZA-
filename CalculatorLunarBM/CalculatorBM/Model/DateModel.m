//
//  DateModel.m
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "DateModel.h"

@interface DateModel ()

@end

@implementation DateModel

- (instancetype)initWithDate:(NSInteger)jdn quote:(NSString *)quote image:(UIImage *)image {
    self =[super init];
    if (self) {
        _jdn = jdn;
        _quote = quote;
        _image = image;
    }
    return self;
}

- (NSString *)quote {
    if (!_quote) {
        _quote = NSString.new;
    }
    return _quote;
}

- (UIImage *)image {
    if (!_image) {
        _image = UIImage.new;
    }
    return _image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
