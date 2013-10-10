//
//  ViewController.h
//  PageControlIntroduction
//
//  Created by Patrick Balestra on 9/18/13.
//  Copyright (c) 2013 Patrick Balestra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    
    IBOutlet UIImageView *parallaxBackground;
    IBOutlet UIScrollView *scrollViewIntroduction;
    IBOutlet UIPageControl *pageControlIntroduction;
    
    IBOutlet UIView *page1;
    IBOutlet UIView *page2;
    IBOutlet UIView *page3;
    
    BOOL pageControlBeingUsed;
}

- (IBAction)changePage;

@end
