
//
//  GuidePageViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/22.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "GuidePageViewController.h"
#import "AllUtils.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define UISCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface GuidePageViewController ()<UIScrollViewDelegate,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *guidepageScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:@"exist" forKey:@"guidepage"];
  self.pageControl  = [[UIPageControl alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 50, [[UIScreen mainScreen] bounds].size.height - 50, 100, 20)];
  self.pageControl.numberOfPages = 5;
  [self.view addSubview:self.pageControl];
  [self setGuidePageScrollViewFrame];
}

#pragma mark - 设置控件的位置大小
- (void)setGuidePageScrollViewFrame{
  
  self.guidepageScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 5, [[UIScreen mainScreen] bounds].size.height);
  [self.guidepageScrollView setUserInteractionEnabled:true];
  [self.guidepageScrollView setScrollEnabled:true];
  [self.guidepageScrollView setPagingEnabled:true];
  [self.guidepageScrollView setShowsHorizontalScrollIndicator:false];
  [self.guidepageScrollView setShowsVerticalScrollIndicator:false];
  [self.guidepageScrollView setBounces:false];
  [self setGuidePageImageFrame];
}

- (void)setGuidePageImageFrame{
  
  for (int i = 0; i < 4; i++) {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width * i, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [imageView setUserInteractionEnabled:true];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guidepage%d",i]]];
    [self.guidepageScrollView addSubview:imageView ];
  }
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width * 4, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
  [view setUserInteractionEnabled:true];
  [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"guidepage0.png"]]];

  UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((UISCREEN_WIDTH - 200) / 3, UISCREEN_HEIGHT - 100, 100, 30)];
  [loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [loginButton.layer setBorderColor:[UIColor whiteColor].CGColor];
  [loginButton.layer setBorderWidth:0.5];
  [loginButton.layer setMasksToBounds:true];
  [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((UISCREEN_WIDTH - 200) / 3 + (UISCREEN_WIDTH - 200) / 3 + 100, UISCREEN_HEIGHT - 100, 100, 30)];
  [registerButton setTitle:@"注册" forState:UIControlStateNormal];
  [registerButton.layer setBorderColor:[UIColor whiteColor].CGColor];
  [registerButton.layer setBorderWidth:0.5];
  [registerButton.layer setMasksToBounds:true];
  [registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [view addSubview:loginButton];
  [view addSubview:registerButton];
  
  [self.guidepageScrollView addSubview:view];

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  CGFloat offsetWidth = self.guidepageScrollView.contentOffset.x;
  int pageNum = offsetWidth / [[UIScreen mainScreen] bounds].size.width;
  self.pageControl.currentPage = pageNum;
}

#pragma mark - 所有按钮的点击事件
- (void)loginButtonPressed:(id)sender{
  
  [AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
}

- (void)registerButtonPressed:(id)sender{
  
  [AllUtils jumpToViewController:@"RegisterViewController" contextViewController:self handler:nil];
}

@end
