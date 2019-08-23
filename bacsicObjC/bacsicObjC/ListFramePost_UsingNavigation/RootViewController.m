//#import "RootViewController.h"
//
//@protocol PassData <NSObject>
//@required
//- (void)passData;
//@end
//
//@interface NavigationExample () <ViewDelegate, PassDataBack,UITableViewDelegate, UITableViewDataSource>
//
//@property (nonatomic, strong) NSMutableArray <ContainerCell *> *listView ;
//@property (nonatomic, strong) NSArray <Content *> *contentsModel;
//@property (nonatomic, strong) UIButton *previousBtn;
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIButton *nextBtn;
//
//
//
//@end
//
//@implementation NavigationExample
//int getCurrentIndex = 0;
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self layoutViewFlowOrientation];
//    
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        [self layoutViewFlowOrientation];
//        
//    }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        
//    }];
//}
//- (void)layoutViewFlowOrientation{
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    [self updateUI:(orientation == UIInterfaceOrientationPortrait ||
//                    orientation == UIInterfaceOrientationPortraitUpsideDown)];
//  
//}
//- (void)updateUI:(BOOL)isPortrait{
//     _tableView = self.tableView;
//    float originX = 0.0f;
//    if (!isPortrait) {
//        originX = 25;
//    }
//    self.tableView.frame = CGRectMake(originX , 0, SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
//    
//}
//
//- (void)onTouched:(ContainerCell*) view andIndexPath:(NSIndexPath *)indexpath{
//    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
//    secondVC.data = view.label.text;
//    secondVC.indexPath = indexpath;
//    secondVC.delegate = self;
//    
//    [self.navigationController pushViewController:secondVC animated:YES];
//}
//
//- (void)getDataBack:(SecondViewController *)dataInsideSecond{
//
//    ContainerCell * cellToUpdate = [self.tableView cellForRowAtIndexPath:dataInsideSecond.indexPath];
//    Content * contentToUpdate = [self.contentsModel objectAtIndex:[dataInsideSecond.indexPath row]];
//    contentToUpdate.title = dataInsideSecond.data;
//    [cellToUpdate updateContentInsideContainerView:contentToUpdate];
//    
////    [self.contentsModel objectAtIndex:[dataInsideSecond.indexPath row]].title = dataInsideSecond.data;
////
////
////    [self.tableView rectForRowAtIndexPath:dataInsideSecond.indexPath];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (NSInteger )createView:(NSArray<Content *> *) listData{
//    NSUInteger count = ([listData count] >= 5) ? 5 : [listData count];
//    for (NSUInteger i = 0; i < 5 ; i ++){
//        if (i < count ) {
//            [[self.listView objectAtIndex:i] updateContentInsideContainerView:[listData objectAtIndex:i]];
//            [self.listView objectAtIndex:i].hidden = NO;
//        } else {
//            [self.listView objectAtIndex:i].hidden = YES;
//            
//        }
//    }
//    return  count;
//}
//
//
//- (void)refreshContent: (id)sender {
//    UIButton *btnPre = (UIButton *)sender;
//    NSRange boldedRange ;
//    int sizeOfContents = (int)[self.contentsModel count];
//    NSUInteger numberElementOfRange = 5;
//    
//    getCurrentIndex = getCurrentIndex + 5;
//    if ([btnPre isEqual:_previousBtn]) {
//        getCurrentIndex = getCurrentIndex - 10;
//    }
//    if (getCurrentIndex + 5 > sizeOfContents) {
//        
//        numberElementOfRange = sizeOfContents - getCurrentIndex;
//        getCurrentIndex = getCurrentIndex - 5;
//        
//    }
//    if (getCurrentIndex < 0) {
//        getCurrentIndex = 0;
//    }
//    
//    boldedRange = NSMakeRange(getCurrentIndex, numberElementOfRange);
//    [self createView:[self.contentsModel subarrayWithRange:boldedRange]];
//}
//
//- (UIButton *)previousBtn {
//    if (!_previousBtn) {
//        _previousBtn = UIButton.new;
//        _previousBtn.frame = CGRectMake(20 , SCREEN_MAIN_HEIGHT - 100 , WIDTH_BTN, HEIGHT_BTN);
//        [_previousBtn addTarget:self action:@selector(refreshContent:) forControlEvents:UIControlEventTouchUpInside ] ;
//        
//        [_previousBtn setTitle:@"PREVIOUS" forState:UIControlStateNormal];
//        _previousBtn.layer.borderWidth = 1.0f;
//        _previousBtn.layer.cornerRadius = 8;
//        _previousBtn.backgroundColor = [UIColor darkGrayColor];
//        [self.view addSubview:_previousBtn ];
//    }
//    return _previousBtn;
//}
//
//- (UIButton *)nextBtn {
//    if (!_nextBtn) {
//        _nextBtn = UIButton.new;
//        float space = SCREEN_MAIN_WIDTH - _previousBtn.frame.origin.x * 2 - WIDTH_BTN * 2;
//        _nextBtn.frame = CGRectMake(20 + WIDTH_BTN + space , _previousBtn.frame.origin.y , WIDTH_BTN, HEIGHT_BTN);
//        [_nextBtn addTarget:self action:@selector(refreshContent:) forControlEvents: UIControlEventTouchUpInside];
//        [_nextBtn setTitle:@"NEXT" forState:UIControlStateNormal];
//        
//        _nextBtn.layer.borderWidth = 1.0f;
//        _nextBtn.layer.cornerRadius = 8;
//        _nextBtn.backgroundColor = [UIColor darkGrayColor];
//        [self.view addSubview:_nextBtn ];
//    }
//    return _nextBtn;
//}
//
//- (NSArray<Content *> *)contentsModel{
//    if (!_contentsModel){
//        _contentsModel = [ConnectData connectData].contents;
//    }
//    return _contentsModel;
//}
//
//- (NSMutableArray<ContainerCell *> *)listView{
//    if (!_listView) {
//        _listView = NSMutableArray.new;
//        for (NSInteger i = 0 ; i < 5; i++){
//            ContainerCell *tempContainner = ContainerCell.new;
//            tempContainner.delagte = self;
//            [self.view addSubview:tempContainner];
//            [_listView  addObject:tempContainner];
//        }
//    }
//    return _listView;
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = UITableView.new;
//       _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.dataSource = self;
//        [_tableView registerClass:ContainerCell.class forCellReuseIdentifier:@"Containerview"];
//        
//        _tableView.delegate = self;
//       
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}
//
//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    ContainerCell* cell = [[ContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Contrainerview"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//   [cell updateContentInsideContainerView:[self.contentsModel objectAtIndex:indexPath.row]];
//    return cell;
//}
//
//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.contentsModel count];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//    [self onTouched:[tableView cellForRowAtIndexPath:indexPath] andIndexPath:indexPath];
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = HEIGHT_VIEW;
//    return height;
//}
//@end
