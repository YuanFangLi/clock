
#import "ViewController.h"

@interface ViewController ()
@property(weak,nonatomic)UIView *secondHandView;
@property(weak,nonatomic)UIView *minuteHandView;
@property(weak,nonatomic)UIView *hourHandView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *dialLayer= [[CALayer alloc] init];
    dialLayer.bounds = CGRectMake(0, 0, 150, 150);
    
    dialLayer.position = self.view.center;
    
    dialLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    
    [self.view.layer addSublayer:dialLayer];
    
    //    设置秒针
    UIView *secondHandView = [[UIView alloc]init];
    secondHandView.backgroundColor = [UIColor redColor];
    secondHandView.bounds = CGRectMake(0, 0, 1, 60);
    secondHandView.center = self.view.center;
    
    
    //    修改锚点
    secondHandView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:secondHandView];
    self.secondHandView = secondHandView;
    
    
    //    设置分针
    UIView *minuteHandView = [[UIView alloc]init];
    minuteHandView.backgroundColor = [UIColor darkGrayColor];
    minuteHandView.bounds = CGRectMake(0, 0, 3, 60);
    minuteHandView.center = self.view.center;
    
    
    //    修改锚点
    minuteHandView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:minuteHandView];
    self.minuteHandView = minuteHandView;
    
    //    设置时针
    UIView *hourHandView = [[UIView alloc]init];
    hourHandView.backgroundColor = [UIColor darkGrayColor];
    hourHandView.bounds = CGRectMake(0, 0, 4, 50);
    hourHandView.center = self.view.center;
    
    
    //    修改锚点
    hourHandView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:hourHandView];
    self.hourHandView = hourHandView;
    
    
    //    创建CADisplayLink
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(clockRunning)];
    //    将创建的CADisplayLink加入到主线程中
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)clockRunning{
    
    NSTimeZone *tZone = [NSTimeZone localTimeZone];
    
    
    //    获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //    calendar.timeZone = tZone;
    
    NSDate *currentDate = [NSDate date];
    
    [calendar setTimeZone:tZone];
    
    NSDateComponents *currentTime = [calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitTimeZone fromDate:currentDate];
    
    
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"ssSSSS"];
    NSString *t2=[nsdf2 stringFromDate:[NSDate date]];
    long curr=[t2 longLongValue];
    
    CGFloat angle = (M_PI * 2 / 60) * curr/10000 ;
    
    self.secondHandView.transform = CGAffineTransformMakeRotation(angle);
    
    CGFloat minuteAngle = (M_PI * 2 / 60) * currentTime.minute;
    self.minuteHandView.transform = CGAffineTransformMakeRotation(minuteAngle);
    
    CGFloat hourAngle = (M_PI * 2 / 12) * currentTime.hour;
    self.hourHandView.transform = CGAffineTransformMakeRotation(hourAngle);
}

@end
