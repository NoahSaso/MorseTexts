//
//  MCGMorseCodeConverter.m
//  MorseCodeGenerator
//
//  Created by Kenny Tang on 8/9/13.
//  Copyright (c) 2013 com.corgitoergosum.net. All rights reserved.
//

#import "MCGMorseCodeConverter.h"

@interface MCGMorseCodeConverter()

@property (nonatomic, strong) NSDictionary * morseCodeDict;

@end

@implementation MCGMorseCodeConverter

- (id)init {
    self = [super init];
    if (self != nil){
        [self initConversionTable];
    }
    return self;
}

#pragma mark - public
- (NSArray*)convertStringToMorseCodes:(NSString*)inputString {
    NSMutableArray * convertedMorseCodesArray = [@[] mutableCopy];
    
    for (int index = 0; index < inputString.length; index++){
        NSString * charString = [[inputString lowercaseString] substringWithRange:NSMakeRange(index, 1)];
        NSArray * charMorseCodes = self.morseCodeDict[charString];
        
        [charMorseCodes enumerateObjectsUsingBlock:^(NSString * morseCodeCharNum, NSUInteger idx, BOOL *stop) {
            [convertedMorseCodesArray addObject:morseCodeCharNum];
        }];
        
        if (index < (inputString.length-1)){
            [convertedMorseCodesArray addObject:kMorseCodeDahSpaceString];
        }
    }
    
    return convertedMorseCodesArray;
}

#pragma mark - private
- (void) initConversionTable {
    
    // source: http://morsecode.scphillips.com/morse.html http://home.windstream.net/johnshan/cw_ss_list_punc.html
    
    NSMutableDictionary * morseCodeDict = [[NSMutableDictionary alloc] init];
    morseCodeDict[@" "] = @[kMorseCodeDahThreeSpacesString];
    morseCodeDict[@"a"] = @[kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"b"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"c"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"d"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"e"] = @[kMorseCodeDitString];
    morseCodeDict[@"f"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"g"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"h"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"i"] = @[kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"j"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"k"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"l"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"m"] = @[kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"n"] = @[kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"o"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"p"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"q"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"r"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"s"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"t"] = @[kMorseCodeDahString];
    morseCodeDict[@"u"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"v"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"w"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"x"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"y"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"z"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString];
    
    morseCodeDict[@"0"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"1"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"2"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"3"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@"4"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"5"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"6"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"7"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"8"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"9"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    
    morseCodeDict[@"."] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@","] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString];
    morseCodeDict[@":"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@";"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"?"] = @[kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString];
    morseCodeDict[@"'"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"-"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"/"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"("] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@")"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"\""] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"@"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"="] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDitString, kMorseCodeDahString];
    morseCodeDict[@"!"] = @[kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"["] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"]"] = @[kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDahString, kMorseCodeDitString];
    morseCodeDict[@"+"] = @[kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString, kMorseCodeDahString, kMorseCodeDitString];
    
    self.morseCodeDict = morseCodeDict;
}


@end
