//
//  ViewController.m
//  Animation
//
//  Created by 李勇猛 on 16/3/17.
//  Copyright © 2016年 李勇猛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//展示图片
@property (weak, nonatomic) IBOutlet UIImageView *topViewImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
//手势的view
@property (weak, nonatomic) IBOutlet UIView *dragView;

//手势的view


@property (nonatomic,strong) CAGradientLayer * GraLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageLayer];
    // Do any additional setup after loading the view, typically from a nib.
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
   // 添加到view上
    [_dragView addGestureRecognizer:pan];

}

#pragma mark -  图片的图层属性
- (void)imageLayer{

    //图层图片显示大小
    _topViewImage.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    
    _topViewImage.layer.anchorPoint = CGPointMake(0.5, 1);
    
    _bottomImage.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);

    _bottomImage.layer.anchorPoint = CGPointMake(0.5, 0);
    
    
//    //渐变图层设置阴影
    CAGradientLayer * GraLayer = [CAGradientLayer layer];
//    
    GraLayer.frame = _bottomImage.bounds;
//    
    GraLayer.opacity = 0;
//    //图层必须用id转换一下
//    
    GraLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
//   
    _GraLayer = GraLayer;
//    
    [_bottomImage.layer addSublayer:GraLayer];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取偏移量
    CGPoint transP = [pan translationInView:_dragView];
    
    //旋转角度 往下逆时针 往上顺时针 求出 拖动时候的时的角度 拖动偏移量在200里面的大小
    CGFloat angle = - transP.y/200 *M_PI;
    
    //一开始先角度清空 为了增加立体感
    CATransform3D  tranForm = CATransform3DIdentity;
    
    // 增加旋转的立体感，近大远小,d：距离图层的距离
    tranForm.m34 = -1 / 500.0;
    
    tranForm = CATransform3DRotate(tranForm, angle, 1, 0, 0);
    
    _topViewImage.layer.transform = tranForm;
    
//    渐变图层的取值范围是0 －1 就是通过拖动的偏移量 乘上 200分之一的偏移量 因为 图片的大小是200
    _GraLayer.opacity = transP.y * 1/200;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //系统自带的弹簧效果
        // SpringWithDamping:弹性系数,越小，弹簧效果越明显
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
           _topViewImage.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
