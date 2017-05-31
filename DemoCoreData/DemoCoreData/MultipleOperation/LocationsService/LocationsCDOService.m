//
//  LocationsCDOService.m
//  POSNirvanaCDO
//
//  Created by Shankar on 28/03/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import "LocationsCDOService.h"
//#import "LocationService.h"
#import "DLCDOLocationServiceOperation.h"
#import "DSCDOLocationServiceOperation.h"
#import "NirvanaSharedOperationQueue.h"

@interface LocationsCDOService()
@property(nonatomic,strong) DLCDOLocationServiceOperation *dlLocationServiceOp;
@property(nonatomic,strong) DSCDOLocationServiceOperation *dsLocationServiceOp;
@end

@implementation LocationsCDOService

//=====================================================================
- (void)downloadLocationsDataByUpdatedTime:(NSString*)updatedTime
{
    _dlLocationServiceOp = [[DLCDOLocationServiceOperation alloc] init];
    [self  addLocalObserver];
    
    _dlLocationServiceOp.queuePriority = NSOperationQueuePriorityNormal;
    _dlLocationServiceOp.updatedTime = updatedTime;
    
    NirvanaSharedOperationQueue *sharedQueue = [NirvanaSharedOperationQueue sharedInstance];
    [sharedQueue.operationQueue addOperation:_dlLocationServiceOp];
    //[sharedQueue.operationQueue waitUntilAllOperationsAreFinished];
}

#pragma mark Delegate
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@,object:%@, change:%@",keyPath,object,change);
    
    if (context == &self->_dlLocationServiceOp)
    {
        if ([keyPath isEqualToString:@"opFinished"])
        {
            NSArray *responseArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:_dlLocationServiceOp.serviceResponse options:NSJSONReadingAllowFragments error:nil];
            
            //NSLog(@"Response of LOCATION CDO Service  :%@",responseArray);
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
    [_dlLocationServiceOp addObserver:self forKeyPath:@"opFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:&self->_dlLocationServiceOp];
    [_dlLocationServiceOp addObserver:self forKeyPath:@"opExecuting" options:0 context:&self->_dlLocationServiceOp];
}

-(void) removeLocalObserver
{
    [_dlLocationServiceOp removeObserver:self forKeyPath:@"opFinished" context:&self->_dlLocationServiceOp];
    [_dlLocationServiceOp removeObserver:self forKeyPath:@"opExecuting" context:&self->_dlLocationServiceOp];
}

-(void) dealloc
{
    NSLog(@"%s opFinished :%d opExecuting :%d",__PRETTY_FUNCTION__,_dlLocationServiceOp.opFinished,_dlLocationServiceOp.opExecuting);
    if (_dlLocationServiceOp.opFinished == YES)
    {
        [self removeLocalObserver];
    }
}



@end
