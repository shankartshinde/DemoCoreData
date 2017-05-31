//
//  ViewController.h
//  tempCoreData
//
//  Created by Shankar on 25/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end

