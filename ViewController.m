//
//  ViewController.m
//  llbtableView
//
//  Created by llb on 16/10/17.
//  Copyright © 2016年 llb. All rights reserved.
//

#import "ViewController.h"

#define screenWidth     [UIScreen mainScreen].bounds.size.width

#define screenHeight         [UIScreen mainScreen].bounds.size.height

#import "llbTest.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,weak)UITableView *tableView;

@property (nonatomic ,strong)NSIndexPath *currentIndexPath;

@property (nonatomic ,strong)NSMutableArray *modelArray;

@end

@implementation ViewController

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tableView];
     CGPoint center = CGPointMake(screenWidth /2.0, screenHeight / 2.0);
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    redView.center = center;
    _currentIndexPath = nil;
    for (int i =0 ; i < 50; i++) {
        llbTest * test = [llbTest new];
        test.isSelected = NO;
        [self.modelArray addObject:test];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhangsan"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zhangsan"];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    llbTest *test = self.modelArray[indexPath.row];
    if (test.isSelected == NO) {
        cell.textLabel.text = [NSString stringWithFormat:@"~~~%ld~~~",indexPath.row];
    }else {
        cell.textLabel.text = @"哈哈 我在屏幕中央";
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:30];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height =  screenHeight /2.0 + scrollView.contentOffset.y;
    CGPoint center = CGPointMake(screenWidth/2.0, height);
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForRowAtPoint:center];
    if (_currentIndexPath == nil || _currentIndexPath != selectedIndexPath) {
        llbTest *test = self.modelArray[selectedIndexPath.row];
        test.isSelected = YES;
        if (_currentIndexPath == nil) {
            [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            llbTest *test = self.modelArray[_currentIndexPath.row];
            test.isSelected = NO;
            [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath,_currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        _currentIndexPath = selectedIndexPath;
    
    }
}

@end
