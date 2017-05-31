 //
//  PullAndProcessCDOResponse.m
//  POSNirvanaCDO
//
//  Created by Shankar on 26/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import "PullAndProcessCDOResponse.h"
#import "LocationsCDOService.h"
#import "UserCDOService.h"

@implementation PullAndProcessCDOResponse
- (id)initWithCDOResponseArray:(NSArray *)responseArray
{
    @try
    {
        if(self = [super init])
        {
            _cdoResponseArray = [[NSMutableArray alloc]initWithArray:responseArray];
        }
        return self;
    }
    @catch (NSException *exception)
    {
    }
}

-(void)compareVersionAndPullAsyncCDOForArrayWithOperation
{
    NSString *lastUpdatedTime = @"1970-07-01%2000:00:00";
    
    for (int i=0; i< 2; i++)
    {
        {
            if(i == 0)
            {
                LocationsCDOService *locationService = [[LocationsCDOService alloc] init];
                [locationService downloadLocationsDataByUpdatedTime:lastUpdatedTime];
            }
            else if(i == 1)
            {
                UserCDOService *userService = [[UserCDOService alloc] init];
                [userService downloadUsersDataByUpdatedTime:lastUpdatedTime];
            }
        }
    }
}

@end
