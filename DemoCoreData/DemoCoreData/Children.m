//
//  Children.m
//  DemoCoreData
//
//  Created by Shankar on 18/05/17.
//  Copyright © 2017 Shankar. All rights reserved.
//

#import "Children.h"

@implementation Children
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.age = 0;
    }
    return self;
}

-(void)setName:(NSString *)_source
{
    [self willChangeValueForKey:@"name"];
    _name = _source;
    [self didChangeValueForKey:@"name"];
    //[self didChange:<#(NSKeyValueChange)#> valuesAtIndexes:<#(nonnull NSIndexSet *)#> forKey:<#(nonnull NSString *)#>]
    //return _name;
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    else{
        return [super automaticallyNotifiesObserversForKey:key];
    }
}
@end
