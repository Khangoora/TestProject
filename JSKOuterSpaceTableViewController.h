//
//  JSKOuterSpaceTableViewController.h
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/9/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSKAddObjectViewController.h"


@interface JSKOuterSpaceTableViewController : UITableViewController<JSKAddObjectViewControllerDelegate>

@property(strong,nonatomic) NSMutableArray *planets;
@property(strong,nonatomic) NSMutableArray *addedSpaceObjects;


@end
