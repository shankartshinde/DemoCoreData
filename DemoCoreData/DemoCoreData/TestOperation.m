//
//  TestOperation.m
//  DemoCoreData
//
//  Created by Shankar on 11/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "TestOperation.h"

@implementation TestOperation

-(void)setCompletionBlock:(void (^)(void))completionBlock
{
    NSLog(@"Operation Count:%ld",(long)_countValue);
    sleep(2);
}

//- (void)start
//{
//    NSLog(@"Method start :%ld",(long)_countValue);
//    
//    NSLog(@"Operation Priority ::%ld",(long)self.queuePriority);
//    if ([self isCancelled])
//    {
//        NSLog(@"Operation is Canceled ::%@",self.name);
//    }
//    
//    if ([self isExecuting])
//    {
//        NSLog(@"Operation is Executing ::%@",self.name);
//    }
//    
//    
//    if ([self isFinished])
//    {
//        NSLog(@"Operation is Finished ::%@",self.name);
//    }
//    
//    
//    if ([self isConcurrent])
//    {
//        NSLog(@"Operation is Concurrent ::%@",self.name);
//    }
//    
//    
//    if ([self isAsynchronous])
//    {
//        NSLog(@"Operation is Asynchronous ::%@",self.name);
//    }
//    
//    if ([self isReady])
//    {
//        NSLog(@"Operation is is Ready ::%@",self.name);
//    }    
//    
//}

- (void)main
{
    NSLog(@"Method main :%ld",(long)_countValue);
    NSLog(@"Operation Priority ::%ld",(long)self.queuePriority);
    if ([self isCancelled])
    {
        NSLog(@"Operation is Canceled ::%@",self.name);
    }

    if ([self isExecuting])
    {
        NSLog(@"Operation is Executing ::%@",self.name);
    }

    
    if ([self isFinished])
    {
        NSLog(@"Operation is Finished ::%@",self.name);
    }

    
    if ([self isConcurrent])
    {
        NSLog(@"Operation is Concurrent ::%@",self.name);
    }

    
    if ([self isAsynchronous])
    {
        NSLog(@"Operation is Asynchronous ::%@",self.name);
    }

    if ([self isReady])
    {
        NSLog(@"Operation is is Ready ::%@",self.name);
    }    
}

-(BOOL)finished
{
    NSLog(@"Operation is Finished ::%@",self.name);
    return YES;
}

@end
