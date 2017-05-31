//
//  UserCDOService.h
//  POSNirvanaCDO
//
//  Created by Shankar on 02/04/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCDOService : NSObject

/** @method getUser get all users from service */
+ (BOOL)getUserByUpdatedTime:(NSString *)updatedTime  ;

+ (void)getUserByUpdatedTime:(NSString*)updatedTime completionHandler:(void (^)(BOOL success, NSError* connectionError))handler;
- (void)downloadUsersDataByUpdatedTime:(NSString*)updatedTime;
@end
