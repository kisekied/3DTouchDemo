//
//  ViewController.m
//  3DTouchDemo
//
//  Created by kisekied on 15/11/17.
//  Copyright © 2015年 kisekied. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"
#import "DisplayViewController.h"

#import "TouchChangeView.h"

@interface ViewController () <UIViewControllerPreviewingDelegate, UITableViewDelegate, UITableViewDataSource>
{
    TouchChangeView *_view;
    UILabel *_label;
    UITableView *_tableView;
    NSUInteger _count;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3D Touch Demo";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self createView];
    [self createLabel];
    [self createTableView];
    
    [self check3DTouch];
}



#pragma mark 检测3D Touch
- (void)check3DTouch {
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

#pragma mark - UIViewControllerPreviewingDelegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    ++_count;
    NSLog(@"Count: %ld", _count);
    NSLog(@"%@", self.presentedViewController);
    

    
   
    
    if (CGRectContainsPoint(_tableView.frame, location)) {
        if ([self.presentedViewController isKindOfClass:[DisplayViewController class]]) {
            return nil;
        } else {
            location = [self.view convertPoint:location toView:_tableView];
            NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
            NSLog(@"%@", indexPath);
            DisplayViewController *displayVC = [[DisplayViewController alloc] init];
            displayVC.title = [_tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            
            displayVC.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0
                                                             green:arc4random() % 256 / 256.0
                                                              blue:arc4random() % 256 / 256.0
                                                             alpha:1.0];
            
            displayVC.preferredContentSize = CGSizeMake(0.0, 100 * indexPath.row);
            
            previewingContext.sourceRect = [self.view convertRect:[_tableView cellForRowAtIndexPath:indexPath].frame fromView:_tableView];
            
            return displayVC;
        }
        
    }
    
    
    if ([self.presentedViewController isKindOfClass:[MyViewController class]]) {
        
        return nil;
    } else {
        if (CGRectContainsPoint(_label.frame, location)) {
            MyViewController *vc = [[MyViewController alloc] init];
            vc.title = @"Hello";
            vc.view.backgroundColor = [UIColor cyanColor];
            NSLog(@"New ViewController.");
            return vc;
        }
    }
    
    return nil;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showViewController:viewControllerToCommit sender:self];
}


#pragma mark - TableView Delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DisplayViewController *displayVC = [[DisplayViewController alloc] init];
    displayVC.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    displayVC.view.backgroundColor = [UIColor lightGrayColor];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:displayVC animated:YES];
}



#pragma mark - UI控件

#pragma mark 创建View
- (void)createView {
    _view = [[TouchChangeView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    _view.userInteractionEnabled = YES;
    [self.view addSubview:_view];
    
}

#pragma mark 创建Label

- (void)createLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_view.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    _label.text = @"Peek & Pop";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:20.0f];
    _label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_label];
}

#pragma mark 创建TableView

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_label.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 64 - CGRectGetMaxY(_label.frame) - 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
