//
//  JSKSpaceObject.h
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/10/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AstronomicalData.h"

@interface JSKSpaceObject : NSObject

@property(strong,nonatomic)NSString *name;
@property(nonatomic)float gravitaionalForce;
@property(nonatomic)float diameter;
@property(nonatomic)float yearLength;
@property(nonatomic)float dayLength;
@property(nonatomic)float temperature;
@property(nonatomic)int numberOfMoons;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *interest;

@property(nonatomic,strong)UIImage *spaceImage;

-(id) initWithData:(NSDictionary *)data andimage:(UIImage *) image;

@end
