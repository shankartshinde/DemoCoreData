//
//  UserCDOService.m
//  POSNirvanaCDO
//
//  Created by Shankar on 02/04/13.
//  Copyright (c) 2013 Shankar. All rights reserved.
//

#import "UserCDOService.h"
#import "DLCDOUserServiceOperation.h"
#import "NirvanaSharedOperationQueue.h"

@interface UserCDOService()
@property(nonatomic,strong) DLCDOUserServiceOperation *dlUserServiceOp;
@end


@implementation UserCDOService

//=====================================================================
- (void)downloadUsersDataByUpdatedTime:(NSString*)updatedTime
{
    _dlUserServiceOp = [[DLCDOUserServiceOperation alloc] init];
    [self  addLocalObserver];
    
    _dlUserServiceOp.queuePriority = NSOperationQueuePriorityNormal;
    _dlUserServiceOp.updatedTime = updatedTime;
    
    NirvanaSharedOperationQueue *sharedQueue = [NirvanaSharedOperationQueue sharedInstance];
    [sharedQueue.operationQueue addOperation:_dlUserServiceOp];
    //[sharedQueue.operationQueue waitUntilAllOperationsAreFinished];
}

#pragma mark Delegate
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@,object:%@, change:%@",keyPath,object,change);
    
    if (context == &self->_dlUserServiceOp)
    {
        if ([keyPath isEqualToString:@"opFinished"])
        {
            NSArray *responseArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:_dlUserServiceOp.serviceResponse options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"Response of USER CDO Service  :%@",responseArray);
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
    [_dlUserServiceOp addObserver:self forKeyPath:@"opFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:&self->_dlUserServiceOp];
    [_dlUserServiceOp addObserver:self forKeyPath:@"opExecuting" options:0 context:&self->_dlUserServiceOp];
}

-(void) removeLocalObserver
{
    [_dlUserServiceOp removeObserver:self forKeyPath:@"opFinished" context:&self->_dlUserServiceOp];
    [_dlUserServiceOp removeObserver:self forKeyPath:@"opExecuting" context:&self->_dlUserServiceOp];
}

-(void) dealloc
{    
    NSLog(@"%s opFinished :%d opExecuting :%d",__PRETTY_FUNCTION__,_dlUserServiceOp.opFinished,_dlUserServiceOp.opExecuting);
    if (_dlUserServiceOp.opFinished == YES)
    {
        [self removeLocalObserver];
    }
    
}



@end
