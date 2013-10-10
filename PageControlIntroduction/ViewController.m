//
//  ViewController.m
//  PageControlIntroduction
//
//  Created by Patrick Balestra on 9/18/13.
//  Copyright (c) 2013 Patrick Balestra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Motion effects built into iOS 7
    
    UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontal.minimumRelativeValue = @-20;
    interpolationHorizontal.maximumRelativeValue = @20;
    
    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVertical.minimumRelativeValue = @-20;
    interpolationVertical.maximumRelativeValue = @20;
    
    // Add motion effects to the imageView
    
    [parallaxBackground addMotionEffect:interpolationHorizontal];
    [parallaxBackground addMotionEffect:interpolationVertical];
    
    // Page Control properties
    
    pageControlBeingUsed = NO;
    pageControlIntroduction.currentPage = 0;
    
    page1.alpha = 0.0;
    page2.alpha = 0.0;
    page3.alpha = 0.0;
    
    // Set status bar text to white so it looks gorgeous :)
	[self preferredStatusBarStyle];
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Scroll View properties
    
    scrollViewIntroduction.scrollEnabled = YES;
    scrollViewIntroduction.pagingEnabled = YES;
    scrollViewIntroduction.showsVerticalScrollIndicator = NO;
    scrollViewIntroduction.showsHorizontalScrollIndicator = NO;
    scrollViewIntroduction.delegate = (id)self;
    
    // Scroll View content size

    scrollViewIntroduction.contentSize = CGSizeMake(960, 568);
    
    // Fade in the first pageView when the view appears
    
    [UIView animateWithDuration:0.5 animations:^{
        page1.alpha = 1.0;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!pageControlBeingUsed) {
        
        // Page control updates
        
        CGFloat pageWidth = scrollViewIntroduction.frame.size.width;
        int page = floor((scrollViewIntroduction.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControlIntroduction.currentPage = page;
        
        // Parallax Background Scrolling (background image out of the scrollView)
        
        float offsetX = scrollViewIntroduction.contentOffset.x;
        CGRect imageFrame = parallaxBackground.frame;
        imageFrame.origin.x = - 50 -(offsetX / 4);
        parallaxBackground.frame = imageFrame;
        
        // Fade Effect if the user is in view 1
        
        if (scrollViewIntroduction.contentOffset.x < 320) {
            page2.alpha = scrollViewIntroduction.contentOffset.x / 320;
            page1.alpha = 1 - (scrollViewIntroduction.contentOffset.x / 320);
        }
        
        // Fade Effect if the user is in view 2
        
        if (scrollViewIntroduction.contentOffset.x > 320 && scrollViewIntroduction.contentOffset.x < 640) {
            page2.alpha = 2 - (scrollViewIntroduction.contentOffset.x / 320);
            page3.alpha = (scrollViewIntroduction.contentOffset.x / 320) - 1;
        }
        
    }
}

- (IBAction)changePage {
    
    // Page Control stuff
    
    CGRect frame;
    frame.origin.x = scrollViewIntroduction.frame.size.width * pageControlIntroduction.currentPage;
    frame.origin.y = 0;
    frame.size = scrollViewIntroduction.frame.size;
    [scrollViewIntroduction scrollRectToVisible:frame animated:YES];
    
    pageControlBeingUsed = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // Change Status Bar to white
    return UIStatusBarStyleLightContent;
}

@end
