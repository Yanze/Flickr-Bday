//
//  HomeViewController.m
//  Eversnap
//
//  Created by yanze on 10/8/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import "HomeViewController.h"
#import "PhotoCollectionViewCell.h"
#import "FlickrManager.h"
#import "PhotoDetailViewController.h"
#import "UIImageView+AFNetworking.h"


@interface HomeViewController ()
@property(nonatomic, strong) UICollectionView *photoCollectionView;
@property(nonatomic,strong) NSString *photoCollectionViewCellId;
@property(nonatomic, strong) NSArray *photoList;
@property(nonatomic, retain) UIColor *barTintColor;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationItem];
    self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.photoCollectionViewCellId = @"photoCollectionViewCellId";
    
    self.photoList = [[NSArray alloc] init];
    [self setupPhotoCollectionView];
    [self setupPhotoCollectionViewConstraints];
    [self setupFlickrManager];
    
}

- (void)customNavigationItem {
    self.navigationItem.title = @"Photos With Birthday Tag";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

- (void)setupPhotoCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                                  collectionViewLayout:layout];
    [self.photoCollectionView setDelegate:self];
    [self.photoCollectionView setDataSource:self];
    
    [self.photoCollectionView registerClass:[PhotoCollectionViewCell class]
                 forCellWithReuseIdentifier: self.photoCollectionViewCellId];
    
    [self.photoCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.photoCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.photoCollectionView];
}

- (void)setupPhotoCollectionViewConstraints {
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_photoCollectionView]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views: NSDictionaryOfVariableBindings(_photoCollectionView)];
    
    NSArray *vertitalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_photoCollectionView]|"
                                                                           options:NSLayoutFormatDirectionLeadingToTrailing
                                                                           metrics:nil
                                                                             views: NSDictionaryOfVariableBindings(_photoCollectionView)];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:vertitalConstraints];
}

- (void)setupFlickrManager {
//    FlickrManager *manager = [[FlickrManager alloc]init];
    FlickrManager *manager = [FlickrManager sharedManager];
    manager.delegate = self;
    [manager getPhotosAsync];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[_photoCollectionView dequeueReusableCellWithReuseIdentifier:self.photoCollectionViewCellId
                                                                                                               forIndexPath:indexPath];
    NSDictionary *photo = self.photoList[indexPath.item];
    cell.titleLabel.text = photo[@"title"];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString: photo[@"thumbnailUrl"]]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(170, 170);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *pvc = [[PhotoDetailViewController alloc]init];
    pvc.photo = self.photoList[indexPath.item];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)photosArrived:(NSArray *)photos {
    self.photoList = photos;
    [self.photoCollectionView reloadData];
}

@end
