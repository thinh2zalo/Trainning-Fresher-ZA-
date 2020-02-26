//
//  testViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textLable.frame = CGRectMake(40, 40, 100, 100);
    self.textLable.center = self.view.center;
    // Do any additional setup after loading the view.
}

- (UILabel *)textLable {
    if (!_textLable) {
        _textLable = UILabel.new;
        [self.view addSubview:_textLable];
    }
    return _textLable;
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
