////
////  Util.m
////  HiddenTagCOP
////
////  Created by cknb_mac03 on 2016. 10. 4..
////  Copyright © 2016년 cknb. All rights reserved.
////
//
//#import "Util.h"
//#import "AppDelegate.h"
//
//#define AES_KEY2 @"oriquackquackpyask0113cknb841678";
//
//
//@implementation Util
//
//+ (NSString*) unescapeUnicodeString:(NSString*)string {
//    NSString* esc1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
//    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
//    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
//                                                       mutabilityOption:NSPropertyListImmutable format:NULL
//                                                       errorDescription:NULL];
//
//
//    return unesc;
//}
//
//+ (NSString *)getPlistPath {
//    NSError *error;
//    NSString *plistPath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:[NSString stringWithFormat:@"AdList.plist"]];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (![fileManager fileExistsAtPath:plistPath])
//    {
//        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"AdList" ofType:@"plist"];
//        [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
//        NSLog(@"파일 복사됨");
//    }else {
//        NSLog(@"파일이 있음.");
//    }
//
//    return plistPath;
//}
//
//+ (NSString *)getAESEncodingStr:(NSString *)str{
//    NSString *key = AES_KEY2;
//
//    NSData *str_text = [[str dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
//    NSString* encodedStr = [str_text base64EncodedString];
//
//    return encodedStr;
//}
//
//// uuid decrypt
//+ (NSString *)getAESDecryptStr:(NSString *)str {
//
//    NSData *ret = [NSData dataWithBase64EncodedString:str];
//    NSString *key = AES_KEY;
//    NSString *uniqId  = [[NSString alloc] initWithData:[ret AES256DecryptWithKey:key] encoding:NSUTF8StringEncoding];
//    NSLog(@"decString : %@", uniqId);
//
//    return uniqId;
//}
//
//+ (NSString *)getLanguage {
//    //NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
//    NSString *language = [[NSLocale preferredLanguages] firstObject];
//
//    if ([language hasPrefix:@"zh"]) {
//        language = @"cn";
//    } else if ([language hasPrefix:@"ja"]) {
//        language = @"jp";
//    } else if ([language hasPrefix:@"id"]) {
//        language = @"in";
//    } else if ([language hasPrefix:@"ru"]) { // 21.05.31 러시아어 추가
//        language = @"ru";
//    }
//    /*
//    // 간체, 일본어는 변경해서 넘겨줌.
//    if ([language hasPrefix:@"zh-Hans"]) {
//        language = @"cn";
//    }
//    else if ([language hasPrefix:@"ja"]) {
//        language = @"jp";
//    }
//     */
//    NSLog(@"lang = %@", language);
//    language = [[language componentsSeparatedByString:@"-"] firstObject];
//    NSLog(@"lang = %@", language);
//
//    return language;
//}
//
//+ (NSString *)encryptedGpsInfoWithLongitude:(NSString *)lon latitude:(NSString *)lat {
//
//    NSArray *oritext = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m"
//                      ,@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"
//                      ,@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"
//                      ,@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"
//                      ,@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"
//                      ,@"@",@"_",@"-",@".", nil];
//    NSArray *outtext = [NSArray arrayWithObjects:@"z",@"y",@"x",@"w",@"v",@"u",@"t",@"s",@"r",@"q",@"p",@"o",@"n"
//                      ,@"m",@"l",@"k",@"j",@"i",@"h",@"g",@"f",@"e",@"d",@"c",@"b",@"a"
//                      ,@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"
//                      ,@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"
//                      ,@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"0"
//                      ,@".",@"-",@"_",@"@", nil];
//
//
//    //위치정보 확인
//    NSString *latstr = @"", *lonstr = @"", *modifylat = @"", *modifylod = @"", *tempstr = @"";
//
//    latstr = lat;
//    lonstr = lon;
//
//
//    if(lat != 0 || lon != 0)
//    {
//        //좌표 암호화
//        //lat
//        for(int i = 0; i< latstr.length; i++)
//        {
//            tempstr = [latstr substringWithRange:NSMakeRange(i, 1)];
//            for(int j = 0; j< [oritext count]; j++)
//            {
//                NSString *text = [oritext objectAtIndex:j];
//                if([tempstr isEqualToString:text])
//                {
//                    modifylat = [modifylat stringByAppendingString:[outtext objectAtIndex:j]];
//                    j = [oritext count];
//                }
//            }
//        }
//        //lod
//        for(int i = 0; i< lonstr.length; i++)
//        {
//            tempstr = [lonstr substringWithRange:NSMakeRange(i, 1)];
//            for(int j = 0; j< [oritext count]; j++)
//            {
//                NSString *text = [oritext objectAtIndex:j];
//                if([tempstr isEqualToString:text])
//                {
//                    modifylod = [modifylod stringByAppendingString:[outtext objectAtIndex:j]];
//                    j = [oritext count];
//                }
//            }
//        }
//    }
//    else
//    {
//        modifylat = @"9@9";
//        modifylod = @"9@9";
//    }
//
//    NSString *gps = [modifylat stringByAppendingFormat:@",%@" , modifylod];
//
//    return gps;
//}
//
//// uicolor to uiimage
//+ (UIImage *)getImageByColor:(UIColor *)color
//{
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//
//+ (void) delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds{
//
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        if(callback){
//            callback();
//        }
//    });
//}
//
//@end
