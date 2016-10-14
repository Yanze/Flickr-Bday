//
//  FlickrManager.m
//  Eversnap
//
//  Created by yanze on 10/8/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import "FlickrManager.h"
#import "AFHTTPSessionManager.h"


@interface FlickrManager()
@property(nonatomic, strong) NSString *apiKey;

@end

@implementation FlickrManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"];
        NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        self.apiKey = config[@"Key"];
    }
    return self;
}

- (void) getPhotos {
    NSString *url = @"https://api.flickr.com/services/rest/";
    NSDictionary *params = @{
                             @"method": @"flickr.photos.search",
                             @"api_key": self.apiKey,
                             @"tags": @"birthday",
                             @"per_page": @"10",
                             @"format": @"json",
                             @"nojsoncallback": @"1",
                             @"extras": @"owner_name,url_c,url_o,url_sq",
                             @"orientation": @"landscape",
                             @"restrict": @"landscape"
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *photos = [[NSArray alloc]init];
        photos = [self extractPhotos: responseObject];
        
        if (self.delegate) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate photosArrived: photos];
            });
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(NSArray *)extractPhotos: (NSDictionary *)dict {
    NSArray *photos = dict[@"photos"][@"photo"];
    NSMutableArray *photoList = [[NSMutableArray alloc]init];
    for (int i = 0; i< photos.count; i++) {
        NSString *pId = photos[i][@"id"];
        NSString *title = photos[i][@"ownername"];
        NSString *thumbnailUrl = @"";
        if (photos[i][@"url_c"] != nil) {
            thumbnailUrl = photos[i][@"url_c"];
        }
        else if (photos[i][@"url_sq"] != nil) {
            thumbnailUrl = photos[i][@"url_sq"];
        }
        
        NSString *oImgUrl = @"";
        if (photos[i][@"url_o"] != nil) {
            oImgUrl = photos[i][@"url_o"];
        }
        
        NSDictionary *currentObj = @{
                                     @"id": pId,
                                     @"title": title,
                                     @"thumbnailUrl": thumbnailUrl,
                                     @"oImgUrl": oImgUrl
                                     };
        [photoList addObject:currentObj];
    }
    return photoList;
}




@end

