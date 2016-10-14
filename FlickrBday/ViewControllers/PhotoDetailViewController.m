//
//  PhotoDetailViewController.m
//  Eversnap
//
//  Created by yanze on 10/8/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailViewController ()

@property(nonatomic,strong) UIImageView *photoImageView;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self addSwipeGesture];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPhotoImageView];
    [self setupPhotoOwnerBlurEffectAndText];
    
}

- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPhotoVc)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void)dismissPhotoVc {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupPhotoImageView {
    self.photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    if(self.photo[@"oImgUrl"] != nil){
        [self.photoImageView setImageWithURL:[NSURL URLWithString: self.photo[@"oImgUrl"]]
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else {
        self.photoImageView.image = [UIImage imageNamed:@"no_photo.jpg"];
    }
    
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.photoImageView];
    
}

- (void)setupPhotoOwnerBlurEffectAndText {
    UIBlurEffect *blurEffectStyle = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView  = [[UIVisualEffectView alloc] initWithEffect: blurEffectStyle];
    blurEffectView.frame = CGRectMake(0, self.photoImageView.frame.size.height - 100, self.photoImageView.frame.size.width, 100);
    
    [self.photoImageView addSubview:blurEffectView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.photoImageView.frame.size.width, 20)];
    textLabel.text = [NSString stringWithFormat:@"Owner: %@", self.photo[@"title"]];
    textLabel.font = [textLabel.font fontWithSize: 11];
    textLabel.textColor = [UIColor whiteColor];
    [blurEffectView addSubview:textLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
