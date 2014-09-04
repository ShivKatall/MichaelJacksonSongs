//
//  CBViewController.m
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "CBMasterViewController.h"
#import "CBAppDelegate.h"
#import "CBNetworkController.h"
#import "CBTrack.h"
#import "CBTrackCell.h"
#import "CBDetailViewController.h"

@interface CBMasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CBAppDelegate *appDelegate;
@property (nonatomic, strong) CBNetworkController *networkController;
@property (nonatomic, strong) NSArray *currentTracks;
@property (weak, nonatomic) IBOutlet UITableView *tracksTableView;

@end

@implementation CBMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _appDelegate = [UIApplication sharedApplication].delegate;
    _tracksTableView.delegate = self;
    _tracksTableView.dataSource = self;
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

- (void)assignViewControllerTracksFromNetworkControllerTracks:(NSMutableArray *)networkControllerTracks
{
    _currentTracks = networkControllerTracks;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tracksTableView reloadData];
    });
}


#pragma mark Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        CBDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath      = [_tracksTableView indexPathForSelectedRow];
        destination.currentTrack  = _currentTracks [indexPath.row];
    }
}

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_currentTracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBTrackCell *trackCell = [tableView dequeueReusableCellWithIdentifier:@"trackCell" forIndexPath:indexPath];
    CBTrack *track = [_currentTracks objectAtIndex:indexPath.row];
    
    // Text
    trackCell.artistLabel.text      = [NSString stringWithFormat:@"%@", track.artistName];
    trackCell.collectionLabel.text  = [NSString stringWithFormat:@"%@", track.collectionName];
    trackCell.trackLabel.text       = [NSString stringWithFormat:@"%@", track.trackName];
    
    // Photos
    if (track.image) {
        trackCell.thumbnail.image = track.image;
    } else {
        [track downloadImageWithCompletionBlock:^{
            [tableView reloadRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    return trackCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
