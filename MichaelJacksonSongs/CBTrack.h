//
//  CBSong.h
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTrack : NSObject

@property (nonatomic, strong) NSString *smallArtworkURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *mediumArtworkURL;
@property (nonatomic, strong) NSString *largeArtworkURL;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *collectionName;
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *explicity;

- (void)downloadImageWithCompletionBlock:(void (^)())completion;

@end
