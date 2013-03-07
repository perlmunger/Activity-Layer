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
