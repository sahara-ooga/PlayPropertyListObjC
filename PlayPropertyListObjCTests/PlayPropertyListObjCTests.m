//
//  PlayPropertyListObjCTests.m
//  PlayPropertyListObjCTests
//
//  Created by yuu ogasawara on 2017/06/09.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PlayPropertyListObjCTests : XCTestCase

@end

@implementation PlayPropertyListObjCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSavePlist{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    NSArray* array = @[@"北海道", @"青森県", @"岩手県",@"秋田県"];
    BOOL successful = [array writeToFile:filePath atomically:NO];
    XCTAssertTrue(successful);
}

-(void)testLoadPlist{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    NSArray* array = @[@"北海道", @"青森県", @"岩手県",@"秋田県"];
    [array writeToFile:filePath atomically:NO];
    
    NSArray *loadedArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    XCTAssertNotNil(loadedArray);
}

-(void)testLoadedPlistIsTheSame{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    NSArray* array = @[@"北海道", @"青森県", @"岩手県",@"秋田県"];
    [array writeToFile:filePath atomically:NO];
    
    NSArray *loadedArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    if (loadedArray) {
        [loadedArray enumerateObjectsUsingBlock:^(NSString* string, NSUInteger idx, BOOL *stop){
            NSString* referencedString = array[idx];
            XCTAssertEqualObjects(string, referencedString);
        }];
    }
}

@end
