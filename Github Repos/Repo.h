//
//  Repo.h
//  Github Repos
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject
@property (nonatomic) NSString *name;
-(instancetype)initWithName:(NSString *)name;
@end
