//
//  CBNetworkController.h
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNetworkController : NSObject

-(void)fetchTracksWithCompletionBlock:(void(^)(NSMutableArray *tracks))completionBlock;

@end
