//
//  JSKSpaceObject.m
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/10/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import "JSKSpaceObject.h"
#import "AstronomicalData.h"

@implementation JSKSpaceObject

-(id)init
{
    
    self = [self initWithData:nil andimage:nil];
    return self;
}

-(id) initWithData:(NSDictionary *)data andimage:(UIImage *)image
{
    self = [super init];
    self.name = data[PLANET_NAME];
    self.gravitaionalForce = [data[PLANET_GRAVITY] floatValue];
    self.diameter = [data[PLANET_DIAMETER] floatValue];
    self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.dayLength = [data[PLANET_DAY_LENGTH] floatValue];
    self.temperature = [data[PLANET_TEMPERATURE] floatValue];
    self.numberOfMoons = [data[PLANET_NUMBER_OF_MOONS] intValue];
    self.nickName = data[PLANET_NICKNAME];
    self.interest = data[PLANET_INTERESTING_FACT];
    self.spaceImage = image;
                          
    return self;
    
}
@end
