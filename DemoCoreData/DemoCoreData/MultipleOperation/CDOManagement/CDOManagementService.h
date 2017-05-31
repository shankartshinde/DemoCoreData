//
//  CDOService.h
//  POSNirvanaCDO
//
//  Created by Shankar on 26/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CDOService.h"
//#import "CDOListener.h"
#import "PullAndProcessCDOResponse.h"


@interface CDOManagementService : NSObject <PullAndProcessCDOResponseDelegate>

//@property (nonatomic, strong) id<CDOListener>delegate;

@property (nonatomic, strong)NSString *schemaName;

@property (nonatomic)BOOL isPullingAfterSocketReconnect;

/**@method getAllCDOManagementData */
- (void)getAllCDOManagementData;

/**@method getAllCDOManagementData */
- (void)getAllCDOManagementDataWhereSchemaName:(NSString *)schemaName;

/**@method getCDOManagementDataForUserId gets the CDO data for userId
 @param userId*/
- (void)getCDOManagementDataForUserId:(NSNumber *)userId;

- (void)getAllCDOManagementDataLocationSpecificWhereLocationId:(NSNumber *)locId;


@end
