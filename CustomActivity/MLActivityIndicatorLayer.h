//
//  MLActivityIndicatorLayer.h
//  CustomActivity
//
//  Created by Matt Long on 3/6/13.
//  Copyright (c) 2013 Matt Long. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MLActivityIndicatorLayer : CALayer

@property (nonatomic, assign) NSInteger tickCount;
@property (nonatomic, strong) CALayer *swooshLayer;
@property (nonatomic, strong) UIColor *tickColor;
@property (nonatomic, strong) UIColor *swooshTickColor;

- (id)initWithFrame:(CGRect)frame;

@end
