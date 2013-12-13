//
//  TPTabBar.h
//  TilosPlayer
//
//  Created by Daniel Langh on 13/12/13.
//  Copyright (c) 2013 rumori. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTabBar : UITabBar

@property (nonatomic, retain) UIImageView *coverView;

- (void)deselectItems;


@end