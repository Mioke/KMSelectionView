//
//  KMPopSelectionCell.m
//  XKRW
//
//  Created by Klein Mioke on 15/8/15.
//  Copyright (c) 2015年 XiKang. All rights reserved.
//

#import "KMPopSelectionCell.h"

@interface KMPopSelectionCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *checkImage;

@property (nonatomic) CGFloat cellWidth;

@end

@implementation KMPopSelectionCell

- (instancetype)initWithCellStyle:(KMPopSelectionCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier witdh:(CGFloat) width {
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.cellWidth = width;
        
        if (style == KMPopSelectionCellStyleDefault) {
            [self initWithStyleDefault];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}

- (void)initWithStyleDefault {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.cellWidth - 30, self.contentView.frame.size.height)];
    self.titleLabel.textColor = XK_TEXT_COLOR;
    self.titleLabel.font = XKDefaultNumEnFontWithSize(14);
    
    [self.contentView addSubview:self.titleLabel];
    
    UIImage *check = [UIImage imageNamed:@"list_select"];
    
    self.checkImage = [[UIButton alloc] initWithFrame:CGRectMake(self.cellWidth - check.size.width - 15, 0, check.size.width, self.contentView.frame.size.height)];
    self.checkImage.userInteractionEnabled = NO;
    
    [self.checkImage setImage:check forState:UIControlStateSelected];
    [self.checkImage setImage:self.delegate.options[KMPSV_Unselected_image] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.checkImage];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.cellWidth, 0.5)];
    line.backgroundColor = XK_ASSIST_LINE_COLOR;
    
    [self addSubview:line];
}

- (void)setDelegate:(KMPopSelectionView *)delegate {
    
    _delegate = delegate;
    
    if (_delegate.options[KMPSV_Text_alignment]) {
        self.titleLabel.textAlignment = (NSTextAlignment)([self.delegate.options[KMPSV_Text_alignment] integerValue]);
    }
    if (_delegate.options[KMPSV_Selected_image]) {
        [self.checkImage setImage:_delegate.options[KMPSV_Selected_image] forState:UIControlStateSelected];
    } else {
        // TODO: with default image
        UIImage *check = [UIImage imageNamed:@"list_select"];
        [self.checkImage setImage:check forState:UIControlStateSelected];
    }
    if (_delegate.options[KMPSV_Unselected_image]) {
        [self.checkImage setImage:self.delegate.options[KMPSV_Unselected_image] forState:UIControlStateNormal];
    } else {
        // same
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [self.checkImage setSelected:selected];
    
    if (selected) {
        self.titleLabel.textColor = XKMainSchemeColor;
    } else {
        self.titleLabel.textColor = XK_TEXT_COLOR;
    }
}

@end
