//
//  FlickrManager.h
//  Eversnap
//
//  Created by yanze on 10/8/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlickrManagerDelegate;

@interface FlickrManager : NSObject

@property (nonatomic, retain) NSString *FlickrManagerSigleton;
@property (nonatomic, weak) id<FlickrManagerDelegate> delegate;
- (void)getPhotosAsync;
+ (instancetype)sharedManager;

@end

@protocol FlickrManagerDelegate <NSObject>

-(void)photosArrived:(NSArray *)photos;

@end
