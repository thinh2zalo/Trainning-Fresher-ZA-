//
//  DateModel.m
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "DateModel.h"
#import "SingletonAPI.h"
#import <SDWebImage.h>

@interface DateModel ()

@end

@implementation DateModel

- (instancetype)initWithDate:(NSInteger)jdn quote:(NSString *)quote {
    self = [super init];
    if (self) {
        _jdn = jdn;
        _quote = quote;
    }
    return self;
}

+ (DateModel *)createDataModel:(NSInteger)jdn {
    NSString *quote = [SingletonAPI.sharedInstance getQuote:jdn];
    return [[DateModel alloc] initWithDate:jdn quote:quote];
}


- (NSString *)quote {
    if (!_quote) {
        _quote = NSString.new;
    }
    return _quote;
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
