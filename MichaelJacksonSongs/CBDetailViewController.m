//
//  CBDetailViewController.m
//  MichaelJacksonSongs
//
//  Created by Cole Bratcher on 9/3/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "CBDetailViewController.h"

@interface CBDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explicitLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation CBDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.title = _currentTrack.trackName;
    
    // labels
    _artistLabel.text       = _currentTrack.artistName;
    _collectionLabel.text   = _currentTrack.collectionName;
    _trackLabel.text        = _currentTrack.trackName;
    _genreLabel.text        = _currentTrack.genre;
    _explicitLabel.text     = _currentTrack.explicity;
    
    // Image
    if (_currentTrack.image) {
        _imageView.image = _currentTrack.image;
    } else {
        [_currentTrack downloadImageWithCompletionBlock:^{
            _imageView.image = _currentTrack.image;
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
