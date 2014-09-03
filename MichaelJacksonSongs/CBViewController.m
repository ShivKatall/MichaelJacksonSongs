//
//  CBViewController.m
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "CBViewController.h"
#import "CBAppDelegate.h"
#import "CBNetworkController.h"

@interface CBViewController ()

@property (nonatomic, strong) CBAppDelegate *appDelegate;
@property (nonatomic, strong) CBNetworkController *networkController;
@property (nonatomic, strong) NSArray *currentTracks;

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _appDelegate = [UIApplication sharedApplication].delegate;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _networkController = _appDelegate.networkController;
    [_networkController fetchTracksWithCompletionBlock:^(NSMutableArray *tracks) {
        [self assignViewControllerTracksFromNetworkControllerTracks:tracks];
        NSLog(@"%@", _currentTracks);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)assignViewControllerTracksFromNetworkControllerTracks:(NSMutableArray *)networkControllerTracks
{
    _currentTracks = networkControllerTracks;
    
    dispatch_async(dispatch_get_main_queue(), ^{

    });
}

@end
