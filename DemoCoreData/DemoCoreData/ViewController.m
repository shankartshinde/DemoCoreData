//
//  ViewController.m
//  DemoCoreData
//
//  Created by Shankar on 28/04/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,strong) NSMutableArray *oprationArray;
@end

static char CharForCurrentThread(void)
// Returns 'M' if we're running on the main thread, or 'S' otherwies.
{
    return [NSThread isMainThread] ? 'M' : 'S';
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Case-1 First Initalisation
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 4;
    
    //Case-2 Second Initalisation
//     Result - This paint one long and nothing happen ahead
//    _queue = [NSOperationQueue currentQueue];
//    _queue.maxConcurrentOperationCount = 4;
    
    //Case-3 Third Initalisation
//   Result - This paint one long and nothing happen ahead
//    _queue = [NSOperationQueue mainQueue];
//    _queue.maxConcurrentOperationCount = 4;
    
    //[self.queue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
    [self.queue addObserver:self forKeyPath:@"operationCount" options:0 context:NULL];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self create100OperationSet:nil];
    [self add100OperationToQueueSet:nil];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self create100OperationSet:nil];
//    [self add100OperationToQueueSet:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewOperationSet:(id)sender
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3");
    }];
    
    NSBlockOperation *waitOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op4");
    }];
    
    //Case-1
    [_queue addOperations:@[op1, op2, op3,waitOp] waitUntilFinished:NO];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    fprintf(stderr, "Thread Running :%c \n", CharForCurrentThread());
    //if (object == self.queue && [keyPath isEqualToString:@"operations"]) {
    if (object == self.queue && [keyPath isEqualToString:@"operationCount"]) {
        if (self.queue.operationCount == 0)
        {
            // Do something here when all operations has completed
            NSLog(@"queue has completed");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

-(IBAction)create100OperationSet:(id)sender
{
    _oprationArray = [NSMutableArray array];
    for(int i = 1 ; i < 101 ; i++)
    {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"op%d",i);
            sleep(2);
        }];
        [_oprationArray addObject:op];
    }
}

-(IBAction)add100OperationToQueueSet:(id)sender
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_queue addOperations:_oprationArray waitUntilFinished:YES];
}

-(IBAction)add100OperationToQueueSetAndSuspend:(id)sender
{
    //[_queue addOperations:_oprationArray waitUntilFinished:YES];
    if(!_queue.suspended)
    {
        _queue.suspended = YES;
    }
    else
    {
        _queue.suspended = NO;
    }
}

@end
