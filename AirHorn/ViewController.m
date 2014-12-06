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
    SystemSoundID airHorn;
    UIButton *playSoundButton;
}

@property (nonatomic) SystemSoundID airHorn;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor greenColor];
    
    NSString *airHornWAVPath = [[NSBundle mainBundle] pathForResource:@"convert-test.caf" ofType:nil];
    NSURL *airHornURL = [NSURL fileURLWithPath:airHornWAVPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)airHornURL, &airHorn);
    
    [self addButtonToView];
    [self addConstraintsToView];
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(_airHorn);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonToView
{
    playSoundButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playSoundButton setTitle:@"Play Sound" forState:UIControlStateNormal];

    [playSoundButton addTarget:self action:@selector(playAirHornSound) forControlEvents:UIControlEventTouchDown];
    [playSoundButton addTarget:self action:@selector(revertBackgroundColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playSoundButton];
    playSoundButton.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)playAirHornSound
{
    NSLog(@"Play the Air Horn Sound Now");
    AudioServicesPlaySystemSound(airHorn);
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
