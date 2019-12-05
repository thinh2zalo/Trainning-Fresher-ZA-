//
//  KeyValueSectionController.m
//  JsonEditorTool
//
//  Created by Steve on 12/4/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "KeyValueSectionController.h"
#import "../View/InforJsonCell.h"
#import "../Model/JsonModel.h"
#import "../Controller/ViewController.h"

@interface KeyValueSectionController () {
    JsonModel * jsonModel;
    
}
@end
@implementation KeyValueSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return self;
}


#pragma mark - override listSectionController

- (NSInteger)numberOfItems {
    return 1;
}
- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 70);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    InforJsonCell * cell = [self.collectionContext dequeueReusableCellOfClass:InforJsonCell.class forSectionController:self atIndex:index];
    [cell updateContentInsideCell:jsonModel];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    jsonModel = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
    ViewController * viewController = ViewController.new;
    viewController.jsonModel = jsonModel;
    if (jsonModel.typeValue == typeValueArray || jsonModel.typeValue == typeValueDictionary) {
        UINavigationController *navController = self.viewController.navigationController;
        [navController pushViewController:viewController animated:YES];
    }
}

@end
