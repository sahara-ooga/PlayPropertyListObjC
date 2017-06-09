//
//  Address.h
//  PlaySilializeObject
//
//  Created by yuu ogasawara on 2017/06/08.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject <NSCoding>{
    
}
@property (nonatomic,strong) NSString* zipCode;
@property (nonatomic,strong) NSString* state;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* other;


@end
