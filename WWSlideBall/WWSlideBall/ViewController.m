//
//  ViewController.m
//  WWSlideBall
//
//  Created by apple on 2021/11/22.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate,CAAnimationDelegate>
@property(nonatomic, strong)NSArray *data;
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UIImageView *imageView1;
@property(nonatomic, strong)UIImageView *imageView2;
@property(nonatomic, strong)UIImageView *imageView3;
@property(nonatomic, strong)UIImageView *imageView4;

@property(nonatomic, assign)CGRect frame1;
@property(nonatomic, assign)CGRect frame2;
@property(nonatomic, assign)CGRect frame3;
@property(nonatomic, assign)CGRect frame4;
@property(nonatomic, strong)NSMutableArray *frameArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _data = @[UIColor.redColor,UIColor.greenColor,UIColor.blueColor,UIColor.yellowColor];
    _frameArray = NSMutableArray.array;
    _contentView = UIView.new;
    _contentView.backgroundColor = UIColor.whiteColor;
    
    _imageView1 = UIImageView.new;
    _imageView1.backgroundColor = UIColor.redColor;
    
    _imageView2 = UIImageView.new;
    _imageView2.backgroundColor = UIColor.greenColor;
    
    _imageView3 = UIImageView.new;
    _imageView3.backgroundColor = UIColor.blueColor;
    
    _imageView4 = UIImageView.new;
    _imageView4.backgroundColor = UIColor.yellowColor;
    
    
    [self.view addSubview:_contentView];
    [_contentView addSubview:_imageView1];
    [_contentView addSubview:_imageView2];
    [_contentView addSubview:_imageView3];
    [_contentView addSubview:_imageView4];

    
    
    
    _contentView.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-400);
    
    _frame1 = CGRectMake(_contentView.frame.size.width - 100, 0, 100, 100);
    _frame2 = CGRectMake(0, (_contentView.frame.size.width/2.0)-50, 100, 100);
    _frame3 = CGRectMake(_contentView.frame.size.width - 100, _contentView.frame.size.height-100, 100, 100);
    _frame4 = CGRectMake((_contentView.frame.size.width - 100)*2, (_contentView.frame.size.width/2.0)-50, 100, 100);
    
    [_frameArray addObject:@(_frame1)];
    [_frameArray addObject:@(_frame2)];
    [_frameArray addObject:@(_frame3)];
    [_frameArray addObject:@(_frame4)];
    
    _imageView1.frame = _frame1;
    _imageView2.frame = _frame2;
    _imageView3.frame = _frame3;
    _imageView4.frame = _frame4;
    [_imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    [_imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    [_imageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    [_imageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    
    _imageView1.tag = 1;
    _imageView2.tag = 2;
    _imageView3.tag = 3;
    _imageView4.tag = 4;
    
    _imageView1.userInteractionEnabled = YES;
    _imageView2.userInteractionEnabled = YES;
    _imageView3.userInteractionEnabled = YES;
    _imageView4.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    ges.delegate = self;
    [_contentView addGestureRecognizer:ges];
    
}

- (void)layoutItems{
    CGRect newFrame1 = [_frameArray[0] CGRectValue];
    CGRect newFrame2 = [_frameArray[1] CGRectValue];
    CGRect newFrame3 = [_frameArray[2] CGRectValue];
    CGRect newFrame4 = [_frameArray[3] CGRectValue];
    for (int i = 0; i < _frameArray.count; i++) {
        CGRect frame = [_frameArray[i] CGRectValue];
        if (frame.origin.x == _imageView1.frame.origin.x && frame.origin.y == _imageView1.frame.origin.y ) {
            NSInteger index = i == 3 ? 0 : i++;
            newFrame1 = [_frameArray[index] CGRectValue];
            NSLog(@"FrameTag = %ld",index); 
        }
        if (frame.origin.x == _imageView2.frame.origin.x && frame.origin.y == _imageView2.frame.origin.y ) {
            NSInteger index = i == 3 ? 0 : i++;
            newFrame2 = [_frameArray[index] CGRectValue];
            NSLog(@"FrameTag = %ld",index);
        }
        if (frame.origin.x == _imageView3.frame.origin.x && frame.origin.y == _imageView3.frame.origin.y ) {
            NSInteger index = i == 3 ? 0 : i++;
            newFrame3 = [_frameArray[index] CGRectValue];
            NSLog(@"FrameTag = %ld",index);
        }
        if (frame.origin.x == _imageView4.frame.origin.x && frame.origin.y == _imageView4.frame.origin.y ) {
            NSInteger index = i == 3 ? 0 : i++;
            newFrame4 = [_frameArray[index] CGRectValue];
            NSLog(@"FrameTag = %ld",index);
        }
        
    }
    _imageView1.frame = newFrame1;
    _imageView2.frame = newFrame2;
    _imageView3.frame = newFrame3;
    _imageView4.frame = newFrame4;
}


- (void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"viewTag = %ld",[tap view].tag);
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //获取偏移量
    // 返回的是相对于最原始的手指的偏移量
    CGPoint transP = [pan translationInView:self.view];
    NSLog(@"translationInView == %f----%f",transP.x,transP.y);
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        
        [_imageView1.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView1.center toValue:_imageView2.center] forKey:@"animation1"];
        [_imageView2.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView2.center toValue:_imageView3.center] forKey:@"animation2"];
        [_imageView3.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView3.center toValue:_imageView4.center] forKey:@"animation3"];
        
        [_imageView4.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView4.center toValue:_imageView1.center] forKey:@"animation4"];
    }

}




//创建动画
- (CABasicAnimation *)createBasicAnimationWithFromValue:(CGPoint)fromValue toValue:(CGPoint)toValue{
    //创建动画对象
    CABasicAnimation *basicAni = [CABasicAnimation animation];

    //设置动画属性
    basicAni.keyPath = @"position";

    //设置动画的起始位置。也就是动画从哪里到哪里
    basicAni.fromValue = [NSValue valueWithCGPoint:fromValue];

    //动画结束后，layer所在的位置
    basicAni.toValue = [NSValue valueWithCGPoint:toValue];

    //动画持续时间
    basicAni.duration = 0.28;

    //动画重复次数
    basicAni.repeatCount = 1;

    //xcode8.0之后需要遵守代理协议
    basicAni.delegate = self;
    
    //动画填充模式
    basicAni.fillMode = kCAFillModeForwards;
    basicAni.removedOnCompletion = NO;

    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    return basicAni;
}

- (CGPoint)center:(CGRect)frame{
    return CGPointMake(frame.origin.x + (frame.size.width/2.0), frame.origin.y + (frame.size.height/2.0));
}


//动画开始的时候调用
- (void)animationDidStart:(CAAnimation *)anim{


}

//动画结束的时候调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"CAAnimation = %@---%@",[_imageView1.layer animationForKey:@"animation1"],anim);
    if ([_imageView1.layer animationForKey:@"animation1"] == anim) {
        [self layoutItems];
        [_imageView1.layer removeAllAnimations];
        [_imageView2.layer removeAllAnimations];
        [_imageView3.layer removeAllAnimations];
        [_imageView4.layer removeAllAnimations];
        
        NSLog(@"animationDidStop");
    }

    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}


@end
