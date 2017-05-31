//
//  NirvanaSharedOperationQueue.m
//  BusinessApplication
//
//  Created by Shankar on 17/05/17.
//
//

#import "NirvanaSharedOperationQueue.h"
@interface NirvanaSharedOperationQueue()
{
    NSOperationQueue* operationQueue;
}
//@property(nonatomic,strong) NSOperationQueue* operationQueue;
@end

static NirvanaSharedOperationQueue* sharedInstance = nil;
@implementation NirvanaSharedOperationQueue

+ (instancetype) sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[NirvanaSharedOperationQueue alloc] init];
    });
    return sharedInstance;
}

- (NSOperationQueue*) operationQueue{
    if(!operationQueue)
    {
        operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.name = @"com.nirvana.queue";
    }
    return operationQueue;
}

@end
