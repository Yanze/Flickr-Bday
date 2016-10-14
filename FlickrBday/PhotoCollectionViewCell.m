//
//  PhotoCollectionViewCell.m
//  Eversnap
//
//  Created by yanze on 10/8/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell()
@property(nonatomic, strong) UIVisualEffectView *blurEffectView;

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setElements];
        
    }
    return self;
}

- (void)setElements {
    [self setupImageView];
    [self addBlurEffectView];
    [self setupTitleLabel];
}

- (void)setupImageView {
    self.imageView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, 170, 170)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.imageView];
}

- (void)addBlurEffectView {
    UIBlurEffect *blurEffectStyle = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView  = [[UIVisualEffectView alloc] initWithEffect: blurEffectStyle];
    NSInteger blurViewHeight = 40;
    self.blurEffectView.frame = CGRectMake(0, self.imageView.bounds.size.height - blurViewHeight, self.bounds.size.width, blurViewHeight);
    [self addSubview: self.blurEffectView];
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 5, 100, 30)];
    self.titleLabel.text = @"photo title";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [self.titleLabel.font fontWithSize: 10];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    [self.blurEffectView addSubview:self.titleLabel];
}


@end

