//
//  KMSelectionView.m
//  KMSelectionViewDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "KMSelectionView.h"
#import "KMSelectionCell.h"

@interface KMSelectionView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) KMSelectionViewType type;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic) KMDirection appearenceDirection;

@end

@implementation KMSelectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)
                                                      style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.scrollEnabled = NO;
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(KMSelectionViewType)type titles:(NSArray *)titles options:(NSMutableDictionary *)options {
    
    if (self = [self initWithFrame:frame]) {
        self.type = type;
        self.titles = titles;
        self.options = options;
        [self initSubviewsWithType:type];
    }
    return self;
}

- (void)initSubviewsWithType:(KMSelectionViewType)type {
    
    if (type == KMSelectionViewTypeDefault) {
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        CGRect frame = self.frame;
        frame.size.height = self.titles.count * 44;
        self.frame = frame;
        
        frame = self.tableView.frame;
        frame.size.height = self.titles.count * 44;
        self.tableView.frame = frame;
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.height - 0.5, frame.size.width, 0.5)];
//        line.backgroundColor = XK_ASSIST_LINE_COLOR;
//        [self.tableView addSubview:line];
    }
}

- (void)setCellTitles:(NSArray *)titles {
    self.titles = titles;
    
    CGRect frame = self.frame;
    frame.size.height = self.titles.count * 44;
    self.frame = frame;
    
    frame = self.tableView.frame;
    frame.size.height = self.titles.count * 44;
    self.tableView.frame = frame;
    
    [self.tableView reloadData];
}

- (void)setTableViewEdgeInsets:(UIEdgeInsets)tableViewEdgeInsets {
    
    _tableViewEdgeInsets = tableViewEdgeInsets;
    
    //    CGRect frame = self.tableView.frame;
    //
    //    frame.origin.x += _tableViewEdgeInsets.left;
    //    frame.size.width -= _tableViewEdgeInsets.right + _tableViewEdgeInsets.left;
    //
    //    frame.origin.y += _tableViewEdgeInsets.top;
    //    frame.size.height -= _tableViewEdgeInsets.top + _tableViewEdgeInsets.bottom;
    //
    //    self.tableView.frame = frame;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    self.tableView.backgroundColor = backgroundColor;
}

- (void)setSelectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unselectedImage {
    
    if (selectedImage) {
        [self.options setObject:selectedImage forKey:KMPSV_Selected_image];
    }
    if (unselectedImage) {
        [self.options setObject:unselectedImage forKey:KMPSV_Unselected_image];
    }
}

- (void)setCellTextAlignment:(NSTextAlignment)alignment {
    [self.options setObject:@(alignment) forKey:KMPSV_Text_alignment];
}

- (void)setCellSelectedWithIndex:(NSInteger)index {
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
}

- (NSMutableDictionary *)options {
    if (!_options) {
        _options = [[NSMutableDictionary alloc] init];
    }
    return _options;
}

- (void)doAnimationToPoint:(CGPoint)to inView:(UIView *)view fromDirection:(KMDirection)direction {
    
    self.isShown = YES;
    
    _appearenceDirection = direction;
    
    if (!self.transparentButton) {
        
//        CGFloat height;
//        
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            height = ((UIScrollView *)view).contentSize.height;
//            height = height >= view.frame.size.height ? height : view.frame.size.height;
//        } else {
//            height = view.frame.size.height;
//        }
//        
//        CGRect frame;
//        if (direction == KMDirectionUp) {
//            frame = CGRectMake(0, to.y, view.frame.size.width, height - to.y);
//        } else if (direction == KMDirectionDown) {
//            frame = CGRectMake(0, 0, view.frame.size.width, to.y + self.frame.size.height);
//        } else {
//            frame = CGRectMake(0, 0, view.frame.size.width, height);
//        }
        
        self.transparentButton = [[UIButton alloc] initWithFrame:view.bounds];
        if (self.backColor) {
            self.transparentButton.backgroundColor = self.backColor;
        }
    }
    [self.transparentButton addTarget:self action:@selector(cancelHide) forControlEvents:UIControlEventTouchDown];
    self.transparentButton.alpha = 0.0;
    
    [view addSubview:self.transparentButton];
    
    CGRect frame = self.frame;
    frame.origin = to;
    self.frame = frame;
    
    frame = self.tableView.frame;
    
    if (direction == KMDirectionUp) {
        frame.origin = CGPointMake(0, - frame.size.height);
    } else if (direction == KMDirectionDown) {
        frame.origin = CGPointMake(0, frame.size.height);
    } else if (direction == KMDirectionLeft) {
        frame.origin = CGPointMake(- frame.size.width, 0);
    } else if (direction == KMDirectionRight) {
        frame.origin = CGPointMake(frame.size.width, 0);
    }
    
    self.tableView.frame = frame;
    
    [view addSubview:self];
    
    frame.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transparentButton.alpha = 1;
    }];
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.tableView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)hide {
    
    self.isShown = NO;
    
    CGRect frame = self.tableView.frame;
    
    if (_appearenceDirection == KMDirectionUp) {
        frame.origin.y = - frame.size.height;
    } else if (_appearenceDirection == KMDirectionDown) {
        frame.origin.y = frame.size.height;
    } else if (_appearenceDirection == KMDirectionLeft) {
        frame.origin.x = - frame.size.width;
    } else if (_appearenceDirection == KMDirectionRight) {
        frame.origin.x = frame.size.width;
    }
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.tableView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transparentButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.transparentButton) {
            [self.transparentButton removeFromSuperview];
        }
    }];
    
}

- (void)cancelHide {
    if (self.delegate && [self.delegate respondsToSelector:@selector(KMSelectionViewDidCancel:)]) {
        [self.delegate KMSelectionViewDidCancel:self];
    }
    [self hide];
}


#pragma mark - UITableView's delegate and datasource
#pragma mark Header and Footer
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark Cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KMSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectionCell"];
    
    if (!cell) {
        cell = [[KMSelectionCell alloc] initWithCellStyle:KMSelectionCellStyleDefault
                                          reuseIdentifier:@"selectionCell"
                                                    witdh:self.frame.size.width];
        cell.delegate = self;
    }
    [cell setTitle:self.titles[indexPath.row]];
    
    return cell;
}

#pragma mark Actions
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(KMSelectionView:didSelectIndex:)]) {
        [self.delegate KMSelectionView:self didSelectIndex:indexPath.row];
    }
}

@end
