//
//  ViewController.m
//  AirHorn
//
//  Created by Erik Allar on 11/26/14.
//  Copyright (c) 2014 Erik Allar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    AVAudioPlayer *horn;
    UIButton *playSoundButton;
    NSURL *airHornURL;
    NSMutableArray *soundsArray;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *airHornWAVPath = [[NSBundle mainBundle] pathForResource:@"convert-test.caf" ofType:nil];
    airHornURL = [NSURL fileURLWithPath:airHornWAVPath];
    soundsArray = [[NSMutableArray alloc] init];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];

    [self addButtonToView];
    [self addConstraintsToView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonToView
{
    playSoundButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playSoundButton setTitle:@"Play Air Horn" forState:UIControlStateNormal];
    [playSoundButton setBackgroundColor:[UIColor clearColor]];
    float horiz = self.view.frame.size.width / 2;
    float vert  = self.view.frame.size.height / 2;
    playSoundButton.contentEdgeInsets = UIEdgeInsetsMake(vert, horiz, vert, horiz);

    [playSoundButton addTarget:self action:@selector(playAirHornSound:) forControlEvents:UIControlEventTouchDown];
    [playSoundButton addTarget:self action:@selector(revertBackgroundColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playSoundButton];
    playSoundButton.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)playAirHornSound:(id)sender
{
    AVAudioPlayer *hornSound = [[AVAudioPlayer alloc] initWithContentsOfURL:airHornURL error:nil];
    [soundsArray addObject:hornSound];
    [hornSound prepareToPlay];
    [hornSound play];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)revertBackgroundColor
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addConstraintsToView
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:playSoundButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:playSoundButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

@end
