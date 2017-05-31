//
//  CDOService.m
//  POSNirvanaCDO
//
//  Created by Shankar on 26/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import "CDOManagementService.h"
#import "PullAndProcessCDOResponse.h"
//#import "CDO.h"
//#import "CDORepository.h"
// DL - Abbrivation for Download data using Serice
// DS - Abbrivation for downloaded data save in core data
#import "DLCDOServiceOperation.h"
#import "NirvanaSharedOperationQueue.h"

@interface CDOManagementService()
@property(nonatomic,strong) DLCDOServiceOperation *dlCdoSericeOp;
@end

@implementation CDOManagementService

//@synthesize delegate;
@synthesize schemaName = _schemaName;


/**@method getAllCDOManagementData */
- (void)getAllCDOManagementDataWhereSchemaName:(NSString *)schemaName
{
    @try
    {
        _dlCdoSericeOp = [[DLCDOServiceOperation alloc] init];
        [self  addLocalObserver];
        
        _dlCdoSericeOp.queuePriority = NSOperationQueuePriorityVeryHigh;

        NirvanaSharedOperationQueue *sharedQueue = [NirvanaSharedOperationQueue sharedInstance];
        [sharedQueue.operationQueue addOperation:_dlCdoSericeOp];
        [sharedQueue.operationQueue waitUntilAllOperationsAreFinished];
    }
    @catch (NSException *exception)
    {
    }
}


#pragma CDOService delegates

- (void)processCDOResponse:(NSArray *)responseArray
{
	@try
	{
		PullAndProcessCDOResponse *pullResponse = [[PullAndProcessCDOResponse alloc]initWithCDOResponseArray:responseArray];
		pullResponse.delegate = self;
		
		pullResponse.schemaName = _schemaName;
        [pullResponse compareVersionAndPullAsyncCDOForArrayWithOperation];
    //return;
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@ %@",exception.description,exception.callStackSymbols);
    }
		
}


#pragma mark Delegate
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@,object:%@, change:%@",keyPath,object,change);
    
    if (context == &self->_dlCdoSericeOp)
    {
        if ([keyPath isEqualToString:@"opFinished"])
        {
            NSLog(@"isFinished");
            NSLog(@"%@", change);
            id parseResponse = [NSJSONSerialization JSONObjectWithData:_dlCdoSericeOp.serviceResponse options:NSJSONReadingAllowFragments error:nil];
            //NSLog(@"Response of CDO Service  :%@",parseResponse);

            if([parseResponse isKindOfClass:[NSDictionary class]])
            {
                NSArray *responseArray = (NSArray *)parseResponse[@"result"];
                [self processCDOResponse:responseArray];
            }
            else
            {
                NSDictionary *responseDict = (NSDictionary *)parseResponse;
                if(responseDict[@"errorCode"])
                {
                    [self pullAndProcessCDODidFailWithError:responseDict[@"displayMessage"]];
                }
            }
        }
        else if ([keyPath isEqualToString:@"opExecuting"])
        {
            NSLog(@"isExecuting");
            NSLog(@"%@", change);
        }
    }
}

-(void) addLocalObserver
{    
    [_dlCdoSericeOp addObserver:self forKeyPath:@"opFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:&self->_dlCdoSericeOp];
    [_dlCdoSericeOp addObserver:self forKeyPath:@"opExecuting" options:0 context:&self->_dlCdoSericeOp];
}

-(void) removeLocalObserver
{
    [_dlCdoSericeOp removeObserver:self forKeyPath:@"opFinished" context:&self->_dlCdoSericeOp];
    [_dlCdoSericeOp removeObserver:self forKeyPath:@"opExecuting" context:&self->_dlCdoSericeOp];
}

-(void) dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self removeLocalObserver];
    //_dlCdoSericeOp = nil;
}

@end
