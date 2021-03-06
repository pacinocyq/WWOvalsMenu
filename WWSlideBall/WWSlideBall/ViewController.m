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

@property(nonatomic, strong)NSMutableArray *frameArray;
@property(nonatomic, strong)NSMutableArray *itemArray;

@property(nonatomic, assign)CGFloat spaceX;
@property(nonatomic, assign)CGFloat spaceY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _data = @[UIColor.redColor,UIColor.greenColor,UIColor.blueColor,UIColor.yellowColor];
    _frameArray = NSMutableArray.array;
    _itemArray = NSMutableArray.array;
    _contentView = UIView.new;
    _contentView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_contentView];
    _contentView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200);
    
    CGRect frame1 = CGRectMake(_contentView.frame.size.width - 100, 0, 100, 100);
    CGRect frame2 = CGRectMake(0, (_contentView.frame.size.height/2.0)-50, 100, 100);
    CGRect frame3 = CGRectMake(_contentView.frame.size.width - 100, _contentView.frame.size.height-100, 100, 100);
    CGRect frame4 = CGRectMake((_contentView.frame.size.width - 100)*2, (_contentView.frame.size.height/2.0)-50, 100, 100);
    
    _spaceX = fabs(frame1.origin.x - frame2.origin.x);
    _spaceY = fabs(frame1.origin.y - frame2.origin.y);
    
    [_frameArray addObject:@(frame1)];
    [_frameArray addObject:@(frame2)];
    [_frameArray addObject:@(frame3)];
    [_frameArray addObject:@(frame4)];
    
    
    NSArray *colorArray = @[UIColor.redColor,UIColor.greenColor,UIColor.blueColor,UIColor.yellowColor];
    
    for (int i = 0 ; i < _frameArray.count; i++) {
        UIImageView *iv = UIImageView.new;
        iv.backgroundColor = colorArray[i];
        iv.tag = i;
        iv.userInteractionEnabled = YES;
        iv.frame = [_frameArray[i] CGRectValue];
        [iv addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
        [_itemArray addObject:iv];
        [_contentView addSubview:iv]; 
    }
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    ges.delegate = self;
    [_contentView addGestureRecognizer:ges];
    
}

- (void)layoutItems{
//    CGRect newFrame1 = [_frameArray[0] CGRectValue];
//    CGRect newFrame2 = [_frameArray[1] CGRectValue];
//    CGRect newFrame3 = [_frameArray[2] CGRectValue];
//    CGRect newFrame4 = [_frameArray[3] CGRectValue];
//
//
//
//
//    for (int i = 0; i < _frameArray.count; i++) {
//        CGRect frame = [_frameArray[i] CGRectValue];
//        if (frame.origin.x == _imageView1.frame.origin.x && frame.origin.y == _imageView1.frame.origin.y ) {
//            NSInteger index = i == 3 ? 0 : i+1;
//            newFrame1 = [_frameArray[index] CGRectValue];
//            _imageView1.tag = i;
//            NSLog(@"FrameTag = %ld",index);
//        }
//        if (frame.origin.x == _imageView2.frame.origin.x && frame.origin.y == _imageView2.frame.origin.y ) {
//            NSInteger index = i == 3 ? 0 : i+1;
//            newFrame2 = [_frameArray[index] CGRectValue];
//            _imageView2.tag = i;
//            NSLog(@"FrameTag = %ld",index);
//        }
//        if (frame.origin.x == _imageView3.frame.origin.x && frame.origin.y == _imageView3.frame.origin.y ) {
//            NSInteger index = i == 3 ? 0 : i+1;
//            newFrame3 = [_frameArray[index] CGRectValue];
//            _imageView3.tag = i;
//            NSLog(@"FrameTag = %ld",index);
//        }
//        if (frame.origin.x == _imageView4.frame.origin.x && frame.origin.y == _imageView4.frame.origin.y ) {
//            NSInteger index = i == 3 ? 0 : i+1;
//            newFrame4 = [_frameArray[index] CGRectValue];
//            _imageView4.tag = i;
//            NSLog(@"FrameTag = %ld",index);
//        }
//    }
//    _imageView1.frame = newFrame1;
//    _imageView2.frame = newFrame2;
//    _imageView3.frame = newFrame3;
//    _imageView4.frame = newFrame4;
}


- (void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"viewTag = %ld",[tap view].tag);
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //???????????????
    // ???????????????????????????????????????????????????
    CGPoint transP = [pan translationInView:self.view];
    NSLog(@"translationInView == %f----%f",transP.x,transP.y);
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        [self layoutItems:transP isPageEnable:NO];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self layoutItems:transP isPageEnable:YES];
        
//        [_imageView1.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView1.center toValue:_imageView2.center] forKey:@"animation1"];
//        [_imageView2.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView2.center toValue:_imageView3.center] forKey:@"animation2"];
//        [_imageView3.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView3.center toValue:_imageView4.center] forKey:@"animation3"];
//
//        [_imageView4.layer addAnimation:[self createBasicAnimationWithFromValue:_imageView4.center toValue:_imageView1.center] forKey:@"animation4"];
    }

}


- (void)layoutItems:(CGPoint)translation isPageEnable:(BOOL)isPageEnable{
    CGFloat translationX = translation.x;
    CGFloat translationY = translation.y;
    
    for (UIImageView *imageView in _itemArray) {
        
        CGFloat ivX = imageView.frame.origin.x;
        CGFloat ivY = imageView.frame.origin.y;
        //??????0????????????
        CGFloat muil = (fabs(translation.y)/self.contentView.frame.size.height) > 1 ? 1 : (fabs(translation.y)/self.contentView.frame.size.height);
        
        CGFloat moveY =  _spaceY * muil;
        CGFloat moveX =  _spaceX * muil;
  
        
        CGRect frame1 = [_frameArray[0] CGRectValue];
        CGRect frame2 = [_frameArray[1] CGRectValue];
        CGRect frame3 = [_frameArray[2] CGRectValue];
        CGRect frame4 = [_frameArray[3] CGRectValue];
        
        BOOL isDownPull = translationY > 0;
        
        
        BOOL downResult1 = (ivX <= frame1.origin.x  && ivX > frame2.origin.x) && (ivY >= frame1.origin.y  && ivY < frame2.origin.y);
        BOOL upResult1 = (ivX < frame1.origin.x  && ivX >= frame2.origin.x) && (ivY > frame1.origin.y  && ivY <= frame2.origin.y);
        BOOL result1 = isDownPull ? downResult1 : upResult1;
        if (result1) {
            CGRect tempFrame = imageView.frame;
            tempFrame.origin.x = isDownPull ? (frame1.origin.x - moveX) : (frame2.origin.x + moveX);
            tempFrame.origin.y = isDownPull ? (frame1.origin.y + moveY) : (frame2.origin.y + moveY);
            
            if (tempFrame.origin.x < frame2.origin.x) {
                tempFrame.origin.x = frame2.origin.x;
            }
            if (tempFrame.origin.y > frame2.origin.y) {
                tempFrame.origin.y = frame2.origin.y;
            }
            
            if (tempFrame.origin.x > frame1.origin.x) {
                tempFrame.origin.x = frame1.origin.x;
            }
            if (tempFrame.origin.y < frame1.origin.y) {
                tempFrame.origin.y = frame1.origin.y;
            }

    
            if (isPageEnable) {
                tempFrame = isDownPull ? frame2 : frame1;
            }
            [self updateFrame:tempFrame view:imageView isPageEnable:isPageEnable];
            NSLog(@"WW>>>> 111  %ld",(long)imageView.tag);
        }
        
        BOOL downResult2 = (ivX >= frame2.origin.x  && ivX < frame3.origin.x) && (ivY >= frame2.origin.y  && ivY < frame3.origin.y);
        BOOL upResult2 = (ivX > frame2.origin.x  && ivX <= frame3.origin.x) && (ivY > frame2.origin.y  && ivY <= frame3.origin.y);
        BOOL result2 = translationY > 0 ? downResult2 : upResult2;
        if (result2) {
            CGRect tempFrame = imageView.frame;
            tempFrame.origin.x = isDownPull ? (frame2.origin.x + moveX) : (frame3.origin.x - moveX);
            tempFrame.origin.y = isDownPull ? (frame2.origin.y + moveY) : (frame3.origin.y - moveY);
            
            if (tempFrame.origin.x > frame3.origin.x) {
                tempFrame.origin.x = frame3.origin.x;
            }
            if (tempFrame.origin.y > frame3.origin.y) {
                tempFrame.origin.y = frame3.origin.y;
            }
            if (tempFrame.origin.x < frame2.origin.x) {
                tempFrame.origin.x = frame2.origin.x;
            }
            if (tempFrame.origin.y < frame2.origin.y) {
                tempFrame.origin.y = frame2.origin.y;
            }
            
            if (isPageEnable) {
                tempFrame = isDownPull ? frame3 : frame2;
            }
            
            [self updateFrame:tempFrame view:imageView isPageEnable:isPageEnable];
            NSLog(@"WW>>>> 222  %ld",(long)imageView.tag);
        }
        
        BOOL downResult3 = (ivX >= frame3.origin.x  && ivX < frame4.origin.x) && (ivY <= frame3.origin.y  && ivY > frame4.origin.y);
        BOOL upResult3 = (ivX > frame3.origin.x  && ivX <= frame4.origin.x) && (ivY < frame3.origin.y  && ivY >= frame4.origin.y);
        BOOL result3 = isDownPull ? downResult3 : upResult3;
        if (result3) {
            CGRect tempFrame = imageView.frame;
            tempFrame.origin.x = isDownPull ? (frame3.origin.x + moveX) : (frame4.origin.x - moveX);
            tempFrame.origin.y = isDownPull ? (frame3.origin.y - moveY) : (frame4.origin.y + moveY);
            
            if (tempFrame.origin.x > frame4.origin.x ) {
                tempFrame.origin.x = frame4.origin.x;
            }
            if (tempFrame.origin.y < frame4.origin.y) {
                tempFrame.origin.y = frame4.origin.y;
            }
            if (tempFrame.origin.x < frame3.origin.x ) {
                tempFrame.origin.x = frame3.origin.x;
            }
            if (tempFrame.origin.y > frame3.origin.y) {
                tempFrame.origin.y = frame3.origin.y;
            }

            if (isPageEnable) {
                tempFrame = isDownPull ? frame4 : frame3;
            }
            
            [self updateFrame:tempFrame view:imageView isPageEnable:isPageEnable];
            NSLog(@"WW>>>> 333  %ld",(long)imageView.tag);
        }
        
        
        BOOL downResult4 = (ivX <= frame4.origin.x  && ivX > frame1.origin.x) && (ivY <= frame4.origin.y  && ivY > frame1.origin.y);
        BOOL upResult4 = (ivX < frame4.origin.x  && ivX >= frame1.origin.x) && (ivY < frame4.origin.y  && ivY >= frame1.origin.y);
        BOOL result4 = translationY > 0 ? downResult4 : upResult4;
        if (result4) {
            CGRect tempFrame = imageView.frame;
            tempFrame.origin.x = isDownPull ? (frame4.origin.x - moveX) : (frame1.origin.x + moveX);
            tempFrame.origin.y = isDownPull ? (frame4.origin.y - moveY) : (frame1.origin.y + moveY);

            if (tempFrame.origin.x < frame1.origin.x ) {
                tempFrame.origin.x = frame1.origin.x;
            }
            if (tempFrame.origin.y < frame1.origin.y) {
                tempFrame.origin.y = frame1.origin.y;
            }

            if (tempFrame.origin.x > frame4.origin.x ) {
                tempFrame.origin.x = frame4.origin.x;
            }
            if (tempFrame.origin.y > frame4.origin.y) {
                tempFrame.origin.y = frame4.origin.y;
            }
            
            
            if (isPageEnable) {
                tempFrame = isDownPull ? frame1 : frame4;
            }
            
            [self updateFrame:tempFrame view:imageView isPageEnable:isPageEnable];
            NSLog(@"WW>>>> 444  %ld",(long)imageView.tag);
        }
    }
}


- (void)updateFrame:(CGRect)frame view:(UIView*)view isPageEnable:(BOOL)isPageEnable {
     
    
    if (isPageEnable) {
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = frame;
        }];
    } else {
        view.frame = frame;
    }
}


//????????????
//- (CABasicAnimation *)createBasicAnimationWithFromValue:(CGPoint)fromValue toValue:(CGPoint)toValue{
//    //??????????????????
//    CABasicAnimation *basicAni = [CABasicAnimation animation];
//
//    //??????????????????
//    basicAni.keyPath = @"position";
//
//    //???????????????????????????????????????????????????????????????
//    basicAni.fromValue = [NSValue valueWithCGPoint:fromValue];
//
//    //??????????????????layer???????????????
//    basicAni.toValue = [NSValue valueWithCGPoint:toValue];
//
//    //??????????????????
//    basicAni.duration = 0.28;
//
//    //??????????????????
//    basicAni.repeatCount = 1;
//
//    //xcode8.0??????????????????????????????
//    basicAni.delegate = self;
//
//    //??????????????????
//    basicAni.fillMode = kCAFillModeForwards;
//    basicAni.removedOnCompletion = NO;
//
//    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//
//    return basicAni;
//}
//
//- (CGPoint)center:(CGRect)frame{
//    return CGPointMake(frame.origin.x + (frame.size.width/2.0), frame.origin.y + (frame.size.height/2.0));
//}


////???????????????????????????
//- (void)animationDidStart:(CAAnimation *)anim{
//
//
//}
//
////???????????????????????????
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//
//
//}
//
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}
//
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//
//
//}


@end
