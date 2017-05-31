//
//  LocationsCDOService.h
//  POSNirvanaCDO
//
//  Created by Shankar on 28/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationsCDOService : NSObject

- (void)downloadLocationsDataByUpdatedTime:(NSString*)updatedTime;
@end
