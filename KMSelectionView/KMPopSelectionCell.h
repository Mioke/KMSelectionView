//
//  KMPopSelectionCell.h
//  XKRW
//
//  Created by Klein Mioke on 15/8/15.
//  Copyright (c) 2015年 XiKang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMPopSelectionView.h"

typedef NS_ENUM(int, KMPopSelectionCellStyle) {

    KMPopSelectionCellStyleDefault = 1
};

@interface KMPopSelectionCell : UITableViewCell

@property (nonatomic, weak) KMPopSelectionView *delegate;

- (instancetype)initWithCellStyle:(KMPopSelectionCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier witdh:(CGFloat) width;

- (void)setTitle:(NSString *)title;

@end
