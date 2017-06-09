//
//  Address.m
//  PlaySilializeObject
//
//  Created by yuu ogasawara on 2017/06/08.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "Address.h"

@implementation Address
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.zipCode = [aDecoder decodeObjectForKey:@"zipCode"];
        self.state = [aDecoder decodeObjectForKey:@"state"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.other = [aDecoder decodeObjectForKey:@"other"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.zipCode forKey:@"zipCode"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.other forKey:@"other"];
}

@end
