//
//  JSKOuterSpaceTableViewController.m
//  OutOfThisWorl
//
//  Created by Jaskirat Khangoora on 9/9/14.
//  Copyright (c) 2014 Jaskirat Khangoora. All rights reserved.
//

#import "JSKOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "JSKSpaceObject.h"
#import "JSKSpaceImageViewController.h"
#import "JSKSpaceDataViewController.h"

@interface JSKOuterSpaceTableViewController ()

@end

@implementation JSKOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

-(NSMutableArray *)planets
{
    if (!_planets) {
        _planets = [[NSMutableArray alloc]init];
    }
    return _planets;
}

-(NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc]init];
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    for(NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",planetData[PLANET_NAME]];
        JSKSpaceObject *planet = [[JSKSpaceObject alloc]initWithData:planetData andimage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        JSKSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

-(void)didCancel
{
    NSLog(@"Did Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSpaceObject:(JSKSpaceObject *)spaceObject{
    
    [self.addedSpaceObjects addObject:spaceObject];
    
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if(!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsPropertyList:spaceObject]];

    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


#pragma mark -Helper Methods
-(NSDictionary *)spaceObjectAsPropertyList:(JSKSpaceObject *)spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name, PLANET_GRAVITY : @(spaceObject.gravitaionalForce), PLANET_DIAMETER : @(spaceObject.diameter), PLANET_YEAR_LENGTH : @(spaceObject.yearLength), PLANET_DAY_LENGTH : @(spaceObject.dayLength), PLANET_TEMPERATURE : @(spaceObject.temperature) , PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons), PLANET_NICKNAME : spaceObject.nickName, PLANET_INTERESTING_FACT : spaceObject.interest, PLANET_IMAGE : imageData };
   
    return dictionary;
}

-(JSKSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *spaceImage = [UIImage imageWithData:dataForImage];
    JSKSpaceObject *spaceObject = [[JSKSpaceObject alloc] initWithData:dictionary andimage:spaceImage];
    return spaceObject;
    
}

#pragma mark - Table view data source

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        if ([segue.destinationViewController isKindOfClass:[JSKSpaceImageViewController class]]) {
            JSKSpaceImageViewController *nextViewController = segue.destinationViewController;
           //index into our array of objects
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            JSKSpaceObject *selectedObject;
            if (path.section ==0) {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            nextViewController.spaceObject = selectedObject;
        }
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[JSKSpaceDataViewController class]] ) {
            JSKSpaceDataViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            JSKSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            nextViewController.spaceObject = selectedObject;
        }
    }
    if ([segue.destinationViewController isKindOfClass:[JSKAddObjectViewController class]]) {
        JSKAddObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([self.addedSpaceObjects count]) {
        return 2;
    }
    else{
        NSLog(@"%i sections 1",[self.addedSpaceObjects count]);
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 1) {
        NSLog(@"%i if statement",[self.addedSpaceObjects count]);

        return [self.addedSpaceObjects count];
    }
    else{
        NSLog(@"%i esle statment",[self.addedSpaceObjects count]);

        return [self.planets count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    if (indexPath.section == 1) {
        //customize cell with new space object
        JSKSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
        
    }
    else{
        //get JSKSpaceObject from planets array and update cell properties.
        JSKSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.imageView.image = planet.spaceImage;
        cell.detailTextLabel.text = planet.nickName;
    }
    //appearance of cell
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
    
    
    return cell;
}

#pragma mark UITableView Delegates
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
