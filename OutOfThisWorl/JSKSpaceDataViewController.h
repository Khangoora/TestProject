//
//  JSKSpaceDataViewController.h
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/12/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSKSpaceObject.h"

@interface JSKSpaceDataViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) JSKSpaceObject *spaceObject;
@end
