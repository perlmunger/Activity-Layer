// Copyright 2013 Matt Long http://www.cimgf.com/
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MLActivityIndicatorLayer.h"

@implementation MLActivityIndicatorLayer

#define kDefaultLayerSize       CGSizeMake(37.0f, 37.0f)
#define kDefaultTickCount       12
#define kTickWidthRatio         0.08f
#define kTickSizeRatio          0.25f
#define kDefaultTickColor       [UIColor lightGrayColor]
#define kDefaultSwooshTickColor [UIColor whiteColor]

+ (id)layer
{
  return [[[self class] alloc] init];
}

- (id)init
{
  return [self initWithFrame:CGRectMake(0.0f, 0.0f, kDefaultLayerSize.width, kDefaultLayerSize.height)];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super init];
  if (self) {
    [self setBounds:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    [self setMasksToBounds:YES];
    _ticks = [[NSMutableArray alloc] init];
    _swooshTicks = [[NSMutableArray alloc] init];
    [self setTickCount:kDefaultTickCount];
    [self setTickColor:kDefaultTickColor];
    [self setSwooshTickColor:kDefaultSwooshTickColor];
    [self buildSublayers];
  }
  return self;
}

- (void)buildSublayers
{
  for (NSInteger i = 0; i < [self tickCount]; ++i) {
    CALayer *tickLayer = [CALayer layer];
    [tickLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width * kTickWidthRatio, [self bounds].size.width*kTickSizeRatio)];
    [tickLayer setPosition:CGPointMake([self bounds].size.width/2.0f, [self bounds].size.height/2.0f)];
    [tickLayer setCornerRadius:2.0f];
    [tickLayer setBackgroundColor:[[self tickColor] CGColor]];
    [tickLayer setAnchorPoint:CGPointMake(0.5f, 1.0f)];
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, ((2*M_PI)/[self tickCount])*i, 0.0f, 0.0f, 1.0f);
    transform = CATransform3DTranslate(transform, 0.0f, [self bounds].size.width*kTickSizeRatio*-1.0f, 0.0f);
    [tickLayer setTransform:transform];
    
    [self addSublayer:tickLayer];
    [_ticks addObject:tickLayer];
  }
  
  _swooshLayer = [CALayer layer];
  [_swooshLayer setBounds:[self bounds]];
  [_swooshLayer setPosition:CGPointMake([self bounds].size.width/2.0f, [self bounds].size.height/2.0f)];
  
  NSInteger swooshTickCount = [self tickCount] / 2;
  for (NSInteger i = 0; i < swooshTickCount; ++i) {
    CALayer *tickLayer = [CALayer layer];
    [tickLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width * kTickWidthRatio, [self bounds].size.width*kTickSizeRatio)];
    [tickLayer setPosition:CGPointMake([self bounds].size.width/2.0f, [self bounds].size.height/2.0f)];
    [tickLayer setCornerRadius:2.0f];
    [tickLayer setBackgroundColor:[[self swooshTickColor] CGColor]];
    
    CGFloat increment = 1.0f / (CGFloat)swooshTickCount;
    [tickLayer setOpacity:(CGFloat)i*increment];
    [tickLayer setAnchorPoint:CGPointMake(0.5f, 1.0f)];
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, ((2*M_PI)/[self tickCount])*i, 0.0f, 0.0f, 1.0f);
    transform = CATransform3DTranslate(transform, 0.0f, [self bounds].size.width*kTickSizeRatio*-1.0f, 0.0f);
    [tickLayer setTransform:transform];
    
    [_swooshLayer addSublayer:tickLayer];
    [_swooshTicks addObject:tickLayer];
  }
  [self addSublayer:_swooshLayer];
  [self startAnimating];

}

- (void)layoutSublayers
{
  for (CALayer *tickLayer in _ticks){
    [tickLayer setBackgroundColor:[[self tickColor] CGColor]];
  }
  
  for (CALayer *swooshTickLayer in _swooshTicks) {
    [swooshTickLayer setBackgroundColor:[[self swooshTickColor] CGColor]];
  }
  
}

- (void)startAnimating
{
  NSMutableArray *transforms = [NSMutableArray array];

  for (NSInteger i = 0; i < [self tickCount]; ++i) {
    CATransform3D transform = CATransform3DMakeRotation(((2*M_PI)/[self tickCount])*i, 0.0f, 0.0f, 1.0f);
    [transforms addObject:[NSValue valueWithCATransform3D:transform]];
  }
  
  CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
  [rotationAnimation setDuration:1.0f];
  [rotationAnimation setRepeatCount:HUGE_VALF];
  [rotationAnimation setValues:transforms];
  [rotationAnimation setCalculationMode:kCAAnimationDiscrete];
  
  [_swooshLayer addAnimation:rotationAnimation forKey:@"transform"];

}

@end
