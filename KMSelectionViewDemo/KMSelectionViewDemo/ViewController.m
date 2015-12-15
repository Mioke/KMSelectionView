//
//  ViewController.m
//  KMSelectionViewDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "ViewController.h"
#import "KMSelectionView.h"

@interface ViewController () <KMSelectionViewDelegate>

@property (nonatomic, assign) KMDirection direction;

@property (nonatomic, strong) KMSelectionView *selectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.selectionView = ({
        KMSelectionView *view =
        [[KMSelectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)
                                          type:KMSelectionViewTypeDefault
                                        titles:@[@"row 1", @"row 2", @"row 3"]
                                       options:nil];

        [view setCellTextAlignment:NSTextAlignmentCenter];
        view.delegate = self;
        
        view;
    });
    
    self.direction = KMDirectionDown;
}
- (IBAction)changeDirection:(id)sender {
    
    UISegmentedControl *control = (UISegmentedControl *)sender;
    self.direction = (KMDirection)(control.selectedSegmentIndex + 1);
}
- (IBAction)show:(id)sender {
    
    [self.selectionView doAnimationToPoint:CGPointMake(0, 64) inView:self.view fromDirection:self.direction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)KMSelectionView:(KMSelectionView *)view didSelectIndex:(NSInteger)index {
    
    NSLog(@"select line %ld", index);
}

- (void)KMSelectionViewDidCancel:(KMSelectionView *)view {
    
    NSLog(@"cancel");
}

@end
