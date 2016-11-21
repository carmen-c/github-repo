//
//  Repo.m
//  Github Repos
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "Repo.h"

@implementation Repo
-(instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self){
        _name = name;
    }
    return self;
}
@end
