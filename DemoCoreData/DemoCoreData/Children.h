//
//  Children.h
//  DemoCoreData
//
//  Created by Shankar on 18/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Children : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger age;
@property (nonatomic, strong) Children *child;
@end
