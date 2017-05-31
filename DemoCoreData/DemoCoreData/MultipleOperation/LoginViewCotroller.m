//
//  LoginViewCotroller.m
//  DemoCoreData
//
//  Created by Shankar on 31/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "LoginViewCotroller.h"
#import "LoginOperation.h"
#import "NirvanaSharedOperationQueue.h"
#import "CDOManagementService.h"

@interface LoginViewCotroller ()
{
    LoginOperation *loginOperation;
    CDOManagementService *cdoManagementService;
}
@end

@implementation LoginViewCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loginOperation = [[LoginOperation alloc] init];
    [self addLocalObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)loginButtonClick:(id)sender
{
    loginOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    NirvanaSharedOperationQueue *sharedQueue = [NirvanaSharedOperationQueue sharedInstance];
    [sharedQueue.operationQueue addOperation:loginOperation];
    [sharedQueue.operationQueue waitUntilAllOperationsAreFinished];
}

-(void)loginServiceFinished:(NSMutableString *)data
{
    [self pullCdoManagementData];
}

- (void)pullCdoManagementData
{
    cdoManagementService=[[CDOManagementService alloc]init];
    
    [cdoManagementService getAllCDOManagementDataWhereSchemaName:@"MyApp"];
}

#pragma mark Delegate
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@,object:%@, change:%@",keyPath,object,change);
    
    if (context == &self->loginOperation)
    {
        if ([keyPath isEqualToString:@"opFinished"])
        {
            [self loginServiceFinished:loginOperation.serviceResponse];
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
    [loginOperation addObserver:self forKeyPath:@"opFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:&self->loginOperation];
    [loginOperation addObserver:self forKeyPath:@"opExecuting" options:0 context:&self->loginOperation];
}

-(void) removeLocalObserver
{
    [loginOperation removeObserver:self forKeyPath:@"opFinished" context:&self->loginOperation];
    [loginOperation removeObserver:self forKeyPath:@"opExecuting"context:&self->loginOperation];
}

- (void)dealloc
{
    // This is the root view controller of our application, so it can never be
    // deallocated.  Supporting -dealloc in a view controller in the presence of
    // threading, even highly constrained threading as used by this example, is
    // tricky.  I generally recommend that you avoid this, and confine your threads
    // to your model layer code.  If that's not possible, you can use a technique
    // like that shown in the QWatchedOperationQueue class in the LinkedImageFetcher
    // sample code.
    //
    // <http://developer.apple.com/mac/library/samplecode/LinkedImageFetcher/>
    //
    // However, I didn't want to drag parts of that sample into this sample (especially
    // given that -dealloc can never be called in this sample and thus I can't test it),
    // nor did I want to demonstrate an ad hoc, and potentially buggy, version of
    // -dealloc.  So, for the moment, we just don't support -dealloc.
    
    assert(NO);
    
    // Despite the above, I've left in the following just as an example of how you
    // manage self observation in a view controller.
    
    [self removeLocalObserver];
}

@end
