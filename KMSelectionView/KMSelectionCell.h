//
//  KMSelectionCell.h
//  KMSelectionViewDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMSelectionView.h"

typedef NS_ENUM(int, KMSelectionCellStyle) {
    
    KMSelectionCellStyleDefault = 1
};

@interface KMSelectionCell : UITableViewCell

@property (nonatomic, weak) KMSelectionView *delegate;

- (instancetype)initWithCellStyle:(KMSelectionCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier witdh:(CGFloat) width;

- (void)setTitle:(NSString *)title;

@end
