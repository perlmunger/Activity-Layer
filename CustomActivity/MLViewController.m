//
//  MLViewController.m
//  CustomActivity
//
//  Created by Matt Long on 3/6/13.
//  Copyright (c) 2013 Matt Long. All rights reserved.
//

#import "MLViewController.h"
#import "MLActivityIndicatorLayer.h"

@interface MLViewController ()

@end

@implementation MLViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [_activityIndicator setTransform:CGAffineTransformMakeScale(5.0f, 5.0f)];
  
  MLActivityIndicatorLayer *activityLayer = [[MLActivityIndicatorLayer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 150.0f)];
  [activityLayer setPosition:[[self view] center]];
  [activityLayer setBackgroundColor:[[UIColor blackColor] CGColor]];

  
  [[[self view] layer] addSublayer:activityLayer];
}

@end
