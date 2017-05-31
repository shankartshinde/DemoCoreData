//
//  PullAndProcessCDOResponse.h
//  POSNirvanaCDO
//
//  Created by Shankar on 26/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullAndProcessCDOResponseDelegate <NSObject>

/**@method pullAndProcessDidFinishSuccessfully delegate to notify that the pulling for each cdo table was completed successfully*/
- (void)pullAndProcessCDODidFinishSuccessfully;

/**@method pullAndProcessDidFailWithError delegate to notify that the pulling for each cdo table was not completed successfully
 @param the error*/
- (void)pullAndProcessCDODidFailWithError:(NSString *)error;
@end

@class CDO;
@interface PullAndProcessCDOResponse : NSObject

@property (nonatomic, strong) CDO *cdoResponse;
@property (nonatomic, strong) NSMutableArray *cdoResponseArray;
@property (nonatomic, strong) id<PullAndProcessCDOResponseDelegate>delegate;
@property (nonatomic, strong) NSString *schemaName;
@property (nonatomic)BOOL isPullingAfterSocketReconnect;

/**@method initWithCDOResponse constructor for PullAndProcessCDOResponse
 @param CDO object
 @return instance of the PullAndProcessCDOResponse*/
- (id)initWithCDOResponse:(CDO *)response;

/**@method initWithCDOResponseArray constructor for PullAndProcessCDOResponse
 @param CDO response array
 @return instance of the PullAndProcessCDOResponse*/
- (id)initWithCDOResponseArray:(NSArray *)responseArray;

/**@method compareVersionAndPullCDO compares version*/
- (void)compareVersionAndPullCDO;

/**@method compareVersionAndPullCDOForArray compares version*/
- (void)compareVersionAndPullCDOForArray;

- (void)compareVersionAndPullAsyncCDOForArray;

- (void)compareVersionAndPullAsyncCDOForArrayForCDOPush;
-(void)compareVersionAndPullAsyncCDOForArrayWithOperation;
@end
