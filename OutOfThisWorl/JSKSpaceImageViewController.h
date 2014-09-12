//
//  JSKSpaceImageViewController.h
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/11/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSKSpaceObject.h"

@interface JSKSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong, nonatomic)JSKSpaceObject *spaceObject;

@end
