//
//  PlayPropertyListObjCTests.m
//  PlayPropertyListObjCTests
//
//  Created by yuu ogasawara on 2017/06/09.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

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

#pragma mark Plistへの配列の保存と読み込み
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


#pragma mark Plistへの自作オブジェクトの保存と読み込み
//自作オブジェクトを直接Plistに保存することはできないので、NSDataに変換して保存する
-(void)testSaveObjectToPlist{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    
    NSArray<Person*>* personsArray = [self personsArray];
    NSMutableArray<NSData*>* array = [NSMutableArray array];
    
    for (Person* person in personsArray) {
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:person];
        [array addObject:data];
    }
    
    BOOL successful = [array writeToFile:filePath atomically:YES];
    XCTAssertTrue(successful);
}

-(void)testLoadObjectNotNil{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    
    NSArray<Person*>* personsArray = [self personsArray];
    NSMutableArray<NSData*>* array = [NSMutableArray array];
    
    for (Person* person in personsArray) {
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:person];
        [array addObject:data];
    }
    
    [array writeToFile:filePath atomically:YES];

    NSArray<NSData*> *loadedArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    XCTAssertNotNil(loadedArray);
}

-(void)testLoadedObjectValid{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [directory stringByAppendingPathComponent:@"data.plist"];
    
    NSArray<Person*>* personsArray = [self personsArray];
    NSMutableArray<NSData*>* array = [NSMutableArray array];
    
    for (Person* person in personsArray) {
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:person];
        [array addObject:data];
    }
    
    [array writeToFile:filePath atomically:YES];
    
    NSArray<NSData*> *loadedArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    if (loadedArray) {
        [loadedArray enumerateObjectsUsingBlock:^(NSData* data, NSUInteger idx, BOOL *stop){
            //NSDataをモデルクラスに変換
            Person* person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            Person* referencedPerson = personsArray[idx];
            
            XCTAssertEqualObjects(person.name, referencedPerson.name);
            
            Address* referencedAddress = referencedPerson.address;
            XCTAssertEqualObjects(person.address.zipCode, referencedAddress.zipCode);
            XCTAssertEqualObjects(person.address.state, referencedAddress.state);
            XCTAssertEqualObjects(person.address.city, referencedAddress.city);
            XCTAssertEqualObjects(person.address.other, referencedAddress.other);
        }];

    }
}

-(NSArray<Person*>*)personsArray{
    Person *tYamada = [[Person alloc] init];
    tYamada.name = @"山田敏郎";
    Address* yAddress = [[Address alloc] init];
    yAddress.zipCode = @"104-0061";
    yAddress.state = @"東京都";
    yAddress.city = @"中央区";
    yAddress.other = @"銀座１丁目";
    tYamada.address = yAddress;
    
    Person* hYamada = [[Person alloc] init];
    hYamada.name = @"山田ひかり";
    hYamada.address = yAddress;
    
    Person *tanaka = [[Person alloc] init];
    tanaka.name = @"田中翔太";
    Address* tAddress = [[Address alloc] init];
    tAddress.zipCode = @"145-0071";
    tAddress.state = @"東京都";
    tAddress.city = @"大田区";
    tAddress.other = @"田園調布１丁目";
    tanaka.address = tAddress;
    
    return @[tYamada,hYamada,tanaka];
}
@end
