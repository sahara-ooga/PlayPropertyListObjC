//
//  Person.h
//  PlaySilializeObject
//
//  Created by yuu ogasawara on 2017/06/08.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

@interface Person : NSObject <NSCoding>{
    
}

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) Address* address;

@end
