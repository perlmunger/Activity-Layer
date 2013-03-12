Activity Indicator Core Animation Layer
===================================

The activity indicator views provided by UIKit don't provide a lot of customization and if you need to enlarge them, they start to pixelate. The activity indicator Core Animation layer provides a way to create a layer that mimics the activity indicator view functionality, but allows you to set the colors to whatever you like and you can scale it to any size and it will still appear crisp around the edges.

![Black activity indicator layer](blackam.png)
![White activity indicator layer](whiteam.png)

Or you can set the colors to your own custom ones.

![Orange/yellow activity indicator layer](orangeam.png)

Here is how you use the code. To add it to a view controller,

```
- (void)viewDidLoad
{
  [super viewDidLoad];

  MLActivityIndicatorLayer *activityLayer = [[MLActivityIndicatorLayer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 150.0f)];
  [activityLayer setPosition:[[self view] center]];
  [activityLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
  
  // Use some custom colors for the tick marks
  [activityLayer setTickColor:[UIColor orangeColor]];
  [activityLayer setSwooshTickColor:[UIColor yellowColor]];

  [[[self view] layer] addSublayer:activityLayer];
}
```

The animation will begin immediately.

The code is MIT licensed. Have fun with it. Submit pull requests if you add some cool or interesting features.

Thanks and have fun.


