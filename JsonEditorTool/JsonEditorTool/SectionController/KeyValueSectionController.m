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
#import "../Controller/JETViewController.h"
#import "../Controller/AlertController.h"



@interface KeyValueSectionController ()<ZASwipeViewCellDelegate> {
    JsonModel * oldJsonModel;
    JsonModel * newJsonModel;

}
@property (nonatomic, strong)  AlertController * alert;
@end
@implementation KeyValueSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma make ZASwipeViewCellDelegate



- (void)view:(UIView<ZASwipeCellParentViewProtocol> *)view didEndEdittingRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
}


- (ZASwipeCellOptions *)view:(UIView<ZASwipeCellParentViewProtocol> *)view editActionsOptionsForRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
    ZASwipeCellOptions *options = [[ZASwipeCellOptions alloc] init];
    
    options.expansionStyle = orientation == ZASwipeActionsOrientationRight ? [ZASwipeExpansionStyle selection] : [ZASwipeExpansionStyle destructive];
    
    options.buttonSpacing = 11;
    
    return options;
}


- (void)view:(UIView<ZASwipeCellParentViewProtocol> *)view willBeginEdittingRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {

}

- (NSArray<ZASwipeAction *> *)view:(UIView<ZASwipeCellParentViewProtocol> *)view editActionsForRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
            __weak typeof(self) weakSelf = self;
    if (orientation == ZASwipeActionsOrientationRight) {
         ZASwipeAction *deleteAction = [[ZASwipeAction alloc] initWithStyle:ZASwipeActionStyleDestructive title:nil handler:^(ZASwipeAction *action, NSIndexPath *indexPath) {
                          [(JETViewController *)weakSelf.viewController deleteJson:self->oldJsonModel];
                      }];
               deleteAction.backgroundColor = [UIColor blueColor];
               deleteAction.image = [UIImage imageNamed:@"trash"];
                      return @[deleteAction];
    } else {
        return nil;
//        ZASwipeAction *deleteAction = [[ZASwipeAction alloc] initWithStyle:ZASwipeActionStyleDestructive title:nil handler:^(ZASwipeAction *action, NSIndexPath *indexPath) {
//                   [(JETViewController *)weakSelf.viewController deleteJson:self->oldJsonModel];
//               }];
//        deleteAction.backgroundColor = [UIColor blueColor];
//        deleteAction.image = [UIImage imageNamed:@"trash"];
//               return @[deleteAction];
           
    }
           
}


#pragma mark - override listSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    CGSize size = CGSizeMake(self.collectionContext.containerSize.width, 80);
    if (_isSearching) {
        size = CGSizeMake(self.collectionContext.containerSize.width, 120);
    }

    return size;
}


- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    InforJsonCell * cell = [self.collectionContext dequeueReusableCellOfClass:InforJsonCell.class forSectionController:self atIndex:index];
    cell.delegate = self;
    [cell updateContentInsideCell:oldJsonModel isSearching:_isSearching];
    [cell layoutSubviews];

    return cell;
}

- (BOOL)canMoveItemAtIndex:(NSInteger)index {
    return true;
}

- (void)didUpdateToObject:(id)object {
    oldJsonModel = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    JETViewController * viewController = JETViewController.new;
    viewController.jsonModel = oldJsonModel;

    if (oldJsonModel.typeValue == typeValueArray || oldJsonModel.typeValue == typeValueDictionary) {
        UINavigationController *navController = self.viewController.navigationController;
        
        [navController pushViewController:viewController animated:YES];
    } else {
        _alert = AlertController.new;
        _alert.alertView.typeEditJson = ktypeEditJson;
        _alert.alertView.delegate = (JETViewController *)self.viewController;
        [_alert showAlert:self.viewController withJsonModel:oldJsonModel];
    }
   
}



@end
