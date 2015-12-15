//
//  KMSelectionView.h
//  KMSelectionViewDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KMSV_Selected_image @"selected_image"
#define KMSV_Unselected_image @"unselected_image"
#define KMSV_Text_alignment @"text_alingment"

/**
 *  方向枚举
 */
typedef NS_ENUM(int, KMDirection) {
    /**
     *  上
     */
    KMDirectionUp = 1,
    /**
     *  右
     */
    KMDirectionRight,
    /**
     *  下
     */
    KMDirectionDown,
    /**
     *  左
     */
    KMDirectionLeft
};

typedef NS_ENUM(NSInteger, KMSelectionViewType) {
    
    KMSelectionViewTypeDefault = 0,
    
    KMSelectionViewTypeCustomCell = 100
};

@class KMSelectionView;

@protocol KMSelectionViewDelegate <NSObject>

@optional
- (void)KMSelectionView:(KMSelectionView *)view didSelectIndex:(NSInteger)index;

- (void)KMSelectionViewDidCancel:(KMSelectionView *)view;

@end

@interface KMSelectionView : UIView
/**
 *  The displaying tableView
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  The tableView's edges with SELF
 */
@property (nonatomic) UIEdgeInsets tableViewEdgeInsets;
/**
 *  The delegate of KMSelectionView, respond for the click action;
 */
@property (weak, nonatomic) id <KMSelectionViewDelegate> delegate;
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
                         type:(KMSelectionViewType)type
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
