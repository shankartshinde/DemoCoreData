//
//  OperationViewController.m
//  DemoCoreData
//
//  Created by Shankar on 28/04/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "OperationViewController.h"
#import "TestOperation.h"
#import "AppDelegate.h"

@interface OperationViewController ()
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,strong) NSMutableArray *oprationArray;
@property(nonatomic,strong) TestOperation *operation1;
@property(nonatomic,strong) TestOperation *operation2;
@property(nonatomic,strong) TestOperation *operation3;
@property(nonatomic,strong) TestOperation *operation4;
@property(nonatomic,strong) TestOperation *operation5;
@end

static char CharForCurrentThread(void)
// Returns 'M' if we're running on the main thread, or 'S' otherwies.
{
    return [NSThread isMainThread] ? 'M' : 'S';
}

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Case-1 First Initalisation
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 4;
    
    //_oprationArray = [NSMutableArray array];
    
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
    
    
    _operation1 = [[TestOperation alloc] init];
    _operation1.countValue = 1;
    //op.name = [NSString stringWithFormat:@"Operation-%d",i];
    [_operation1 setValue:[NSString stringWithFormat:@"Operation-%ld",(long)_operation1.countValue] forKey:@"name"]; //==

    
    _operation2 = [[TestOperation alloc] init];
    _operation2.countValue = 2;
    [_operation2 setValue:[NSString stringWithFormat:@"Operation-%ld",(long)_operation2.countValue] forKey:@"name"]; //==

    
    _operation3 = [[TestOperation alloc] init];
    _operation3.countValue = 3;
    _operation3.queuePriority = NSOperationQueuePriorityVeryHigh;
    [_operation3 setValue:[NSString stringWithFormat:@"Operation-%ld",(long)_operation3.countValue] forKey:@"name"]; //==

    _operation4 = [[TestOperation alloc] init];
    _operation4.countValue = 4;
    [_operation4 setValue:[NSString stringWithFormat:@"Operation-%ld",(long)_operation4.countValue] forKey:@"name"]; //==

    
    _operation5 = [[TestOperation alloc] init];
    _operation5.countValue = 5;
    _operation5.queuePriority = NSOperationQueuePriorityLow;
    [_operation5 setValue:[NSString stringWithFormat:@"Operation-%ld",(long)_operation5.countValue] forKey:@"name"]; // KVC complient
    
    [_operation1 addDependency:_operation5];
    
    [_operation5 addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_operation5 addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    _oprationArray = [NSMutableArray arrayWithObjects:_operation1,_operation2,_operation3,_operation4,_operation5, nil];
    [_queue addOperations:_oprationArray waitUntilFinished:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self create100OperationSet:nil];
    //    [self add100OperationToQueueSet:nil];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self create100OperationSet:nil];
//    [self add100OperationToQueueSet:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void) dealloc
{
    NSLog(@"Dealloc of ViewController get called");
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
    
    NSLog(@"keyPath:%@,object:%@, change:%@",keyPath,object,change);
    
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
        //[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(IBAction)create100OperationSet:(id)sender
{
    _oprationArray = [NSMutableArray array];
    for(int i = 1 ; i < 10 ; i++)
    {
//        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"op%d",i);
//            sleep(2);
//        }];
        
//        NSOperation *op = [[NSOperation alloc] init];
//        [op setCompletionBlock:^{
//            NSLog(@"op%d",i);
//            sleep(2);
//        }];
//        
//        [_oprationArray addObject:op];
        TestOperation *op = [[TestOperation alloc] init];
        op.countValue = i;
        //op.name = [NSString stringWithFormat:@"Operation-%d",i];
        [op setValue:[NSString stringWithFormat:@"Operation-%d",i] forKey:@"name"]; //== KVC
        
//        NSOperationQueuePriorityVeryLow = -8L,
//        NSOperationQueuePriorityLow = -4L,
//        NSOperationQueuePriorityNormal = 0,
//        NSOperationQueuePriorityHigh = 4,
//        NSOperationQueuePriorityVeryHigh = 8
        
        if(8 < i)
        {
            op.queuePriority = NSOperationQueuePriorityVeryHigh;
        }

        if(6 < i)
        {
            op.queuePriority = NSOperationQueuePriorityLow;
        }

        if(4 < i)
        {
            op.queuePriority = NSOperationQueuePriorityHigh;
        }

        if(2 < i)
        {
            op.queuePriority = NSOperationQueuePriorityVeryLow;
        }

        [_oprationArray addObject:op];
    }
}

-(IBAction)add100OperationToQueueSet:(id)sender
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_queue addOperations:_oprationArray waitUntilFinished:NO];
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
