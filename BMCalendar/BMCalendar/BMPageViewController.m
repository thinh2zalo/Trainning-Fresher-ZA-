//
//  BMPageViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/25/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMPageViewController.h"
#import "SolarViewController.h"
@interface BMPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (assign) NSInteger currentIndex;
@property (assign) NSInteger viewControllerCount;
@property (assign) NSInteger expectedTransitionIndex;
// map to store viewController
@property (nonatomic, strong, readonly, nonnull) NSMapTable<UIViewController *, NSNumber*> *map;


@end


@implementation BMPageViewController
 


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    _map = [[NSMapTable alloc] initWithKeyOptions:NSMapTableWeakMemory | NSMapTableObjectPointerPersonality
                                            valueOptions:NSMapTableWeakMemory
                                                capacity:0];
    // lấy những thông tin default.
    if (![self.BMPaingDataSource respondsToSelector:@selector(defaultPage)]) {
        return;
    }

    
    self.currentIndex = [self.BMPaingDataSource defaultPage];
    self.viewControllerCount = [self.BMPaingDataSource numberOfViewControllers:self];
    
    UIViewController * vc = [self fetchViewController:self.currentIndex];
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
// MARK: - UIPageViewControllerDelegate

-  (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSInteger index = [self.map objectForKey:previousViewControllers.firstObject].integerValue;
        index = self.expectedTransitionIndex;
        [self updateCurrentPageIndexIfNeeded:index];
        if ([self.BMPaingDelegate respondsToSelector:@selector(bmPageViewController:didScrollTo:)]) {
            [self.BMPaingDelegate bmPageViewController:self didScrollTo:index];
        }
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    // get viewController sẽ được scroll tới.
    UIViewController *viewController = pendingViewControllers.firstObject;
    if (!viewController) {
        return;
    }
    // get Index của viewController sẽ được scroll tới
    NSNumber* index = [self.map objectForKey:viewController]; // bốc từ trong map.
    self.expectedTransitionIndex = index.integerValue;
    if ([self.BMPaingDelegate respondsToSelector:@selector(bmPageViewController:willScrollToPageAt:direction:animated:)]) {
        // get direction
        NavigationDirection direction = [self determineDirection:index.integerValue previousPage:self.currentIndex];
        [self.BMPaingDelegate bmPageViewController:self willScrollToPageAt:index.integerValue direction:direction animated:YES];
    }
}

- (NavigationDirection)determineDirection:(NSInteger)index previousPage:(NSInteger)previousPage {
    if (index == previousPage) {
        return DirectionNetrue;
    } else {
        // nếu page hiện tại là page cuối và page tiếp theo là page 0 thì là Forword;
        // nếu page hiện tại < page tiếp theo 1 đơn vị thì là Forword;
        if (((previousPage == self.viewControllerCount - 1) && (index == 0)) || (index - previousPage == 1)) {
            return DirectionForword;
        }
        return DirectionReverse;
    }
}

- (BOOL)updateCurrentPageIndexIfNeeded:(NSInteger)index {
    if ((self.currentIndex != index) && (index >= 0 )&& (index < self.viewControllerCount)) {
        self.currentIndex = index;
        return true;
    }
    return false;
}

// MARK: - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    if (self.viewControllerCount == NSNotFound || self.currentIndex == NSNotFound) {
        return nil;
    }
    if (self.currentIndex == self.viewControllerCount - 1) {
        return [self fetchViewController:0];
    } else {
        return [self fetchViewController:self.currentIndex + 1];
    }
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    if (self.viewControllerCount == NSNotFound || self.currentIndex == NSNotFound) {
        return nil;
    }
    if (self.currentIndex != 0) {
        return  [self fetchViewController:self.currentIndex - 1];
    } else {
        return  [self fetchViewController:self.viewControllerCount - 1];
    }
}

-(UIViewController *)getCurrentViewController {
    return  [self fetchViewController:self.currentIndex];
}

-(UIViewController *)fetchViewController:(NSInteger)index {
    if ([self.BMPaingDataSource respondsToSelector:@selector(viewControllerFor:atIndex:)]) {
        UIViewController * viewController = [self.BMPaingDataSource viewControllerFor:self atIndex:index];
        if (viewController) {
            [self.map setObject:@(index) forKey:viewController];
        }
        return viewController;
    }
    return nil;
}

- (NSInteger )getCurrentIndex {
    return self.currentIndex;
}

@end
