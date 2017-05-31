//
//  KVC_KVO_ViewController.m
//  DemoCoreData
//
//  Created by Shankar on 22/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "KVC_KVO_ViewController.h"
#import "Children.h"

static void *child1Context = &child1Context;
static void *child2Context = &child2Context;

@interface KVC_KVO_ViewController ()
@property (nonatomic, strong) Children *child1;

@property (nonatomic, strong) Children *child2;

@property (nonatomic, strong) Children *child3;

@end

@implementation KVC_KVO_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.child1 = [[Children alloc] init];
    
    //    self.child1.name = @"George";
    //    self.child1.age = 15;
    //
    //    NSLog(@"%@, %lu", self.child1.name, (unsigned long)self.child1.age);
    
    
    [self.child1 setValue:@"Shankar" forKey:@"name"];
    [self.child1 setValue:[NSNumber numberWithInteger:30] forKey:@"age"];
    
    NSString *childName = [self.child1 valueForKey:@"name"];
    NSUInteger childAge = [[self.child1 valueForKey:@"age"] integerValue];
    
    NSLog(@"%@, %lu", childName, (unsigned long)childAge);
    
    //-----------------------------------------------------------
    self.child2 = [[Children alloc] init];
    
    [self.child2 setValue:@"Archana" forKey:@"name"];
    [self.child2 setValue:[NSNumber numberWithInteger:28] forKey:@"age"];
    self.child2.child = [[Children alloc] init];
    
    [self.child2 setValue:@"Yug" forKeyPath:@"child.name"];
    [self.child2 setValue:[NSNumber numberWithInteger:1] forKeyPath:@"child.age"];
    NSLog(@"%@, %lu", self.child2.child.name, (unsigned long)self.child2.child.age);
    //Output =Yug, 1
    //-------------------------------------------------
    self.child3 = [[Children alloc] init];
    self.child3.child = [[Children alloc] init];
    self.child3.child.child = [[Children alloc] init];
    
    [self.child3 setValue:@"Tom" forKeyPath:@"child.child.name"];
    [self.child3 setValue:[NSNumber numberWithInteger:2] forKeyPath:@"child.child.age"];
    
    NSLog(@"%@, %lu", self.child3.child.child.name, (unsigned long)self.child3.child.child.age);
    // Output ==Tom, 2
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*
     // Case-1
     [self.child1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
     [self.child1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
     
     [self.child1 setValue:@"Shanky" forKey:@"name"];
     [self.child1 setValue:[NSNumber numberWithInt:32] forKey:@"age"];
     
     // CAse-2 We are going to make everything much more interesting now, simply by adding one more observer for the age property of the child2 object. After that, we will assign a new value to that property.
     
     [self.child2 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
     [self.child2 setValue:[NSNumber numberWithInteger:30] forKey:@"age"];
     */
    
    // Note that the context value for each observed property must be a global variable, because it has to be accessible from both the addObserver… and the observeValueForKeyPath… methods.
    [self.child1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:child1Context];
    [self.child1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:child1Context];
    
    //    [self.child1 willChangeValueForKey:@"name"];
    //    [self.child1 setValue:@"Shanky" forKey:@"name"];
    //    [self.child1 didChangeValueForKey:@"name"];
    
    self.child1.name = @"Shanky";
    
    [self.child1 setValue:[NSNumber numberWithInt:32] forKey:@"age"];
    
    // CAse-2 We are going to make everything much more interesting now, simply by adding one more observer for the age property of the child2 object. After that, we will assign a new value to that property.
    
    [self.child2 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:child2Context];
    [self.child2 setValue:[NSNumber numberWithInteger:30] forKey:@"age"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_child1 removeObserver:self forKeyPath:@"name"];
    [_child1 removeObserver:self forKeyPath:@"age"];
    [_child2 removeObserver:self forKeyPath:@"age"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void) dealloc
{
    NSLog(@"Dealloc of ViewController get called");
    _child1 = nil;
    _child2 = nil;
    _child3 = nil;
    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    //fprintf(stderr, "Thread Running :%c \n", CharForCurrentThread());
    
    if (context == child1Context) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"The name of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
        
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
    }
    else if (context == child2Context){
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the SECOND child was changed.");
            NSLog(@"%@", change);
        }
    }    
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

@end
