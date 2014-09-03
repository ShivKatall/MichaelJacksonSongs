//
//  CBNetworkController.m
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "CBNetworkController.h"
#import "CBTrack.h"

@implementation CBNetworkController

-(void)fetchTracksWithCompletionBlock:(void(^)(NSMutableArray *tracks))completionBlock
{
    // Request URL
    NSString *requestString = @"https://itunes.apple.com/search?term=Michael+jackson";
    NSURL *requestURL = [[NSURL alloc] initWithString:requestString];
    
    // Setup Session
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // Setup Request
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:requestURL];
    [request setHTTPMethod:@"GET"];
    
    // Setup Data Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error.description);
        }
        
        NSLog(@"%@", response.description);
        
        // Get Results
        NSDictionary *rawDataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:nil];
        NSArray *rawDataArray = [NSArray new];
        
        if ([rawDataDictionary objectForKey:@"results"] != [NSNull null]) {
            rawDataArray = [rawDataDictionary objectForKey:@"results"];
        }
        
        // Create Tracks with Results
        NSMutableArray *tracks = [NSMutableArray new];
        
        [rawDataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CBTrack *newTrack = [CBTrack new];
            
            if ([obj objectForKey:@"artworkUrl30"] != [NSNull null]) {
                newTrack.smallArtworkURL = [obj objectForKey:@"artworkUrl30"];
            }
            if ([obj objectForKey:@"artworkUrl60"] != [NSNull null]) {
                newTrack.mediumArtworkURL = [obj objectForKey:@"artworkUrl60"];
            }
            if ([obj objectForKey:@"artworkUrl100"] != [NSNull null]) {
                newTrack.largeArtworkURL = [obj objectForKey:@"artworkUrl100"];
            }
            if ([obj objectForKey:@"artistName"] != [NSNull null]) {
                newTrack.artistName = [obj objectForKey:@"artistName"];
            }
            if ([obj objectForKey:@"collectionName"] != [NSNull null]) {
                newTrack.collectionName = [obj objectForKey:@"collectionName"];
            }
            if ([obj objectForKey:@"trackName"] != [NSNull null]) {
                newTrack.trackName = [obj objectForKey:@"trackName"];
            }
            
            [tracks addObject:newTrack];
            
//            NSLog(@"%@", newTrack);
            
        }];
        
        completionBlock (tracks);
        
    }];
    
    [dataTask resume];
}

@end
