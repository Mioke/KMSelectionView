//
//  KMPopSelectionView.h
//  XKRW
//
//  Created by Klein Mioke on 15/8/15.
//  Copyright (c) 2015年 XiKang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMPopoverView.h"

#define KMPSV_Selected_image @"selected_image"
#define KMPSV_Unselected_image @"unselected_image"
#define KMPSV_Text_alignment @"text_alingment"

typedef NS_ENUM(NSInteger, KMPopSelectionViewType) {
    
    KMPopSelectionViewTypeDefault = 0,
    
    KMPopSelectionViewTypeCustomCell = 100
};

@class KMPopSelectionView;

@protocol KMPopSelectionViewDelegate <NSObject>

@optional
- (void)popSelectionView:(KMPopSelectionView *)view didSelectIndex:(NSInteger)index;

- (void)popSelectionViewDidCancel:(KMPopSelectionView *)view;

@end

@interface KMPopSelectionView : UIView
/**
 *  The displaying tableView
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  The tableView's edges with SELF
 */
@property (nonatomic) UIEdgeInsets tableViewEdgeInsets;
/**
 *  The delegate of KMPopSelectionView, respond for the click action;
 */
@property (weak, nonatomic) id <KMPopSelectionViewDelegate> delegate;
/**
 *  If you wants to show customized cell, set this datasource to ViewController, and return the cell in tableView's delegate and datasource.
 */
@property (weak, nonatomic) id <UITableViewDataSource, UITableViewDelegate> datasource;

@property (strong, nonatomic) NSMutableDictionary *options;

@property (strong, nonatomic) UIButton *transparentButton;
/**
 *  The color of button under the selection view
 */
@property (strong, nonatomic) UIColor *backColor;

@property (nonatomic) BOOL isShown;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(KMPopSelectionViewType)type
                       titles:(NSArray *)titles
                      options:(NSMutableDictionary *)options;

- (void)setSelectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unselectedImage;

- (void)setCellTextAlignment:(NSTextAlignment)alignment;

- (void)setCellTitles:(NSArray *)titles;

// Actions:

- (void)setCellSelectedWithIndex:(NSInteger)index;

- (void)doAnimationToPoint:(CGPoint)to inView:(UIView *)view fromDirection:(KMDirection)direction;

- (void)hide;
@end
