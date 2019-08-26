#import "MainViewController.h"

@protocol PassData <NSObject>
@required
- (void)passData;
@end

@interface MainViewController () < PassDataBack,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) float heightOfString;
@property (nonatomic, strong) NSArray <Content *> *arrContents;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainViewController
int getCurrentIndex = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [self updateUI];
    }completion:nil];
}

- (void)updateUI{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float originX = 0.0f;
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        originX = 25;
    }
    self.tableView.frame = CGRectMake(originX , 0, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    
}


- (void)getDataBack:(SecondViewController *)dataInsideSecond{
    
    Content * contentToUpdate = self.arrContents[dataInsideSecond.indexPath.row];
    contentToUpdate.title = dataInsideSecond.data;
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:dataInsideSecond.indexPath];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }
    [self.tableView reloadRowsAtIndexPaths:@[dataInsideSecond.indexPath] withRowAnimation:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray<Content *> *)arrContents{
    if (!_arrContents){
        _arrContents = ConnectData.connectData.contents;
    }
    return _arrContents;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:ThreeImageCell.class forCellReuseIdentifier:ThreeImageCellIdenti];
        [_tableView registerClass:SingleImageCell.class forCellReuseIdentifier:SingleImageCellIdenti];
        [_tableView registerClass:BigImageCell.class forCellReuseIdentifier:BigImageCellIdenti];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Content * contentToUpdate = self.arrContents[indexPath.row];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }
    if (indexPath.row >= [self.arrContents count] -3) {
        //TODO: Load More cell.
        // upadte arrContents
        //
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  
    ParentsCell * cell;
    if (indexPath.row % 3 == 1) {
         cell  = [self.tableView dequeueReusableCellWithIdentifier:SingleImageCellIdenti forIndexPath:indexPath];
      
    } else if (indexPath.row % 3 == 2){
        cell  = [self.tableView dequeueReusableCellWithIdentifier:BigImageCellIdenti        forIndexPath:indexPath];
    } else {
          cell  = [self.tableView dequeueReusableCellWithIdentifier:ThreeImageCellIdenti forIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContents count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * titleToCal = [self.arrContents objectAtIndex:indexPath.row].title;
    if (indexPath.row % 3 == 0) {
        return [ThreeImageCell heightOfCell:titleToCal];
    } else if (indexPath.row % 3 == 1 ) {
            return [SingleImageCell heightOfCell];
        
    } else {
        return [BigImageCell heightOfCell:titleToCal];
 }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = [self.arrContents objectAtIndex:indexPath.row].title;
    secondVC.indexPath = indexPath;
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end

