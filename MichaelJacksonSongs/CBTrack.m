//
//  CBSong.m
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "CBTrack.h"

@implementation CBTrack

- (void)downloadImageWithCompletionBlock:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *thumbnailURL = [NSURL URLWithString:_largeArtworkURL];
        NSData *thumbnailData = [NSData dataWithContentsOfURL:thumbnailURL];
        _image = [UIImage imageWithData:thumbnailData];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });
}

@end
