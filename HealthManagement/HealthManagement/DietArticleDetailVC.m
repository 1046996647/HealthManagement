//
//  DietArticleDetailVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietArticleDetailVC.h"
#import "HXTagsView.h"
#import <WebKit/WebKit.h>



@interface DietArticleDetailVC ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIImageView *imgView3;
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) HXTagsView *tagsView;
@property (strong, nonatomic) WKWebView *webView;
 @property (strong, nonatomic) UIProgressView *progressView;

@property (copy, nonatomic) NSString *Opertion;



@end

@implementation DietArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, kScreen_Width-20, 20)];
    _lab2.font = [UIFont boldSystemFontOfSize:16];
    _lab2.text = self.model.title;
    _lab2.textAlignment = NSTextAlignmentLeft;
    //        _lab1.textColor = [UIColor grayColor];
    [self.headerView addSubview:_lab2];
    
    
    _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+12, 120, 11)];
    _lab4.font = [UIFont boldSystemFontOfSize:10];
    _lab4.text = self.model.aTime;
    _lab4.textAlignment = NSTextAlignmentRight;
    //        _lab4.backgroundColor = [UIColor redColor];
    _lab4.textColor = [UIColor grayColor];
    [self.headerView addSubview:_lab4];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(_lab4.right+15, _lab4.center.y-5.5, 60, 11);
    [_btn setImage:[UIImage imageNamed:@"browse"] forState:UIControlStateNormal];
    //        _btn.backgroundColor = [UIColor redColor];
    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    _btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btn setTitle:self.model.cilckCount forState:UIControlStateNormal];
    [self.headerView addSubview:_btn];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(_btn.right, _btn.top, 60, 11);
    [_btn1 setImage:[UIImage imageNamed:@"thumbs_normal"] forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"thumbs-up"] forState:UIControlStateSelected];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    _btn1.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    _btn1.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btn1 setTitle:self.model.loveCount forState:UIControlStateNormal];
    [self.headerView addSubview:_btn1];
    [_btn1 addTarget:self action:@selector(thumbAction:) forControlEvents:UIControlEventTouchUpInside];
    _btn1.tag = 100;
    
    if (_model.PointPraise.integerValue == 0) {
        _btn1.selected = NO;
    }
    else {
        _btn1.selected = YES;
    }
    
    _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_lab4.left, _lab4.bottom+12, 16, 16)];
    _imgView3.image = [UIImage imageNamed:@"tag"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headerView addSubview:_imgView3];
    
    //单行滚动  ===============
    //        NSArray *tagAry = @[@"红烧",@"油闷",@"清蒸"];
    //    单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_imgView3.right+12, _imgView3.top-12, kScreen_Width-_imgView3.right-12-12, 0)];
    _tagsView.type = 1;
    _tagsView.tagSpace = 4.0;
    _tagsView.showsHorizontalScrollIndicator = NO;
    _tagsView.tagHeight = 15.0;
    _tagsView.titleSize = 10.0;
    _tagsView.tagOriginX = 0.0;
    _tagsView.titleColor = [UIColor grayColor];
    _tagsView.cornerRadius = 3;
    _tagsView.userInteractionEnabled = NO;
    _tagsView.backgroundColor = [UIColor clearColor];
    _tagsView.borderColor = [UIColor grayColor];
    [_tagsView setTagAry:self.model.tags delegate:nil];
    [self.headerView addSubview:_tagsView];
    
    self.headerView.height = _imgView3.bottom;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(8, self.headerView.bottom+10, kScreen_Width-16, kScreen_Height-64-self.headerView.bottom)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]]];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,2)];
    _progressView.trackTintColor = [UIColor clearColor];
//    _progressView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_progressView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
    
//    // 监听
//    [_webView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"DJWebKitContext"];
    
    [self articleCilck];


}

- (void)thumbAction:(UIButton *)sender
{
    
    if (_btn1.selected == YES) {
        
        self.Opertion = @"Delete";
        
    }
    else {
        
        self.Opertion = @"Insert";

    }
    
    [self articlePointPraise];
}

// 文章点赞
- (void)articlePointPraise
{
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.Opertion forKey:@"Opertion"];
    [paramDic  setObject:self.model.ArticleId forKey:@"OtherId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:ArticlePointPraise dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = responseObject[@"HttpCode"];
        if (code.integerValue == 200) {
            
            if (_btn1.selected == YES) {
                
                _btn1.selected = NO;
                
                self.model.PointPraise = @0;
                
                self.model.loveCount = [NSString stringWithFormat:@"%ld",self.model.loveCount.integerValue-1];
                [_btn1 setTitle:self.model.loveCount forState:UIControlStateNormal];

            }
            else {
                
                _btn1.selected = YES;
                
                self.model.PointPraise = @1;

                self.model.loveCount = [NSString stringWithFormat:@"%ld",self.model.loveCount.integerValue+1];

                [_btn1 setTitle:self.model.loveCount forState:UIControlStateNormal];


            }
            
            if (self.block) {
                self.block(self.model);
            }
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


// 文章查看
- (void)articleCilck
{
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.model.ArticleId forKey:@"Id"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:ArticleClick dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}

//// 监听方法
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
////    NSLog(@"---%d",self.webView.isLoading);
//    if (!self.webView.isLoading) {
//        if([keyPath isEqualToString:@"scrollView.contentOffset"])
//        {
//            CGFloat offsetY = self.webView.scrollView.contentOffset.y;
//            NSLog(@"%f",offsetY);
//            
//            if (offsetY >= 0) {
//                self.headerView.top = self.headerView.top-offsetY;
//
//            }
//            
//        }
//    }
//}
//
//- (void)dealloc {
//    [self.webView removeObserver:self forKeyPath:@"scrollView.contentOffset" context:@"DJWebKitContext"];
//}

@end
