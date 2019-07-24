//
//  ViewController.m
//  UIcroll
//
//  Created by 王晨旭 on 2019/4/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int count=5;
    CGFloat imageY=0;
    CGFloat imageW=self.scrollView.frame.size.width;
    CGFloat imageH=self.scrollView.frame.size.height;
    for(int i=0;i<count;i++){
        UIImageView *imagev=[[UIImageView alloc]init];
        CGFloat imageX=i*imageW;
        imagev.frame=CGRectMake(imageX, imageY, imageW, imageH);
        NSString *imageName=[NSString stringWithFormat:@"img_0%d",i+1];
        imagev.image=[UIImage imageNamed:imageName];
        [self.scrollView addSubview:imagev];
        CGFloat contentW = count * imageW;
        self.scrollView.contentSize = CGSizeMake(contentW, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.pageControl.numberOfPages = count;
        self.scrollView.pagingEnabled = YES;
        [self addTimer];
    }
    
}
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextImage{
    int count = 5;
    NSInteger page = 0;
    if (self.pageControl.currentPage == count - 1) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }

    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW*0.5) / scrollW;
    self.pageControl.currentPage = page;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
@end
