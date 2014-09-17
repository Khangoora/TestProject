//
//  JSKAddObjectViewController.h
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/14/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSKSpaceObject.h"

@protocol JSKAddObjectViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)addSpaceObject:(JSKSpaceObject *)spaceObject;

@end

@interface JSKAddObjectViewController : UIViewController

@property(weak,nonatomic) id <JSKAddObjectViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;

@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;


@end
