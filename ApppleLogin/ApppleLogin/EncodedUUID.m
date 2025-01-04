////
////  EncodedUUID.m
////  HiddenTagCOP
////
////  Created by cknb on 2015. 9. 15..
////  Copyright (c) 2015년 cknb. All rights reserved.
////
//
//#import "EncodedUUID.h"
//#import "KeychainItemWrapper.h"
//
//@implementation EncodedUUID
//
//+ (NSString *)getGroupUUID {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *userDefaultUUID = [userDefault objectForKey:@"uuid"];
//      NSLog(@"user default userDefaultUUID : %@", userDefaultUUID);
//    NSString *keyChainUUID = [EncodedUUID getUUID]; // KeychainItemWrapper 를 2개 생성할때 1개를 리셋하지 않으면 에러 나기 때문에. group KeychainItemWrapper 보다 먼저 생성후 리셋 시켜줌.
//    
//    NSString *str = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppIdentifierPrefix"];
//    KeychainItemWrapper *sharedWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:[NSString stringWithFormat: @"%@com.cknb.sharing", str]];
//    
//    NSString *uuid = [sharedWrapper objectForKey:(__bridge id)(kSecAttrAccount)];
//      NSLog(@"user default uuid : %@", uuid);
//    if( uuid == nil || uuid.length == 0) {
//        if (userDefaultUUID.length > 0) {
//            uuid = userDefaultUUID;
//            [sharedWrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
//            NSLog(@"user default uuid : %@", uuid);
//        }
//        else if (keyChainUUID.length > 0) {
//            uuid = keyChainUUID;
//            [sharedWrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
//            NSLog(@"keychain HTUUID : %@", uuid);
//        }
//        else {
//            // if there is not UUID in keychain, make UUID and save it.
//            CFUUIDRef uuidRef = CFUUIDCreate(NULL);
//            CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
//            CFRelease(uuidRef);
//            uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
//            CFRelease(uuidStringRef);
//            
//            NSLog(@"keychain group uuid : %@", uuid);
//            
//            NSString *key = AES_KEY;
//            NSData *uuid_text = [[uuid dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
//            NSLog(@"uuid_text :%@",uuid_text);
//            NSString* uuidEnc = [uuid_text base64EncodedString];
//            uuid = uuidEnc;
//            
//            [sharedWrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
//        }
//    }
//    
//    
//    
//    NSLog(@"uuid : %@",uuid);
//    NSString *key = AES_KEY;
////    NSData *uuid_text = [[uuid dataUsingEncoding:NSUTF8StringEncoding] AES256DecryptWithKey:key];
//    NSString* uuidDec = [uuid AES256DecryptWithKey:key];
//    NSLog(@"decode uuid : %@",uuidDec);
//    
//    return uuid;
//}
//
//+ (NSString *)getUUID {
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"HTUUID" accessGroup:nil];
//    
//    NSString *uuid = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
//    
//    if (uuid.length == 0) {
//        NSLog(@"HTUUID lenth = 0");
//        
//        // test code
//        /*
//        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
//        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
//        CFRelease(uuidRef);
//        uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
//        CFRelease(uuidStringRef);
//        
//        NSString *key = AES_KEY;
//        NSData *uuid_text = [[uuid dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
//        NSString* uuidEnc = [uuid_text base64EncodedString];
//        uuid = uuidEnc;
//        
//        [wrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
//        */
//    }
//    
//    NSLog(@"htuuid %@",uuid);
//    
//    [wrapper resetKeychainItem];
//    
//    return uuid;
//}
//
//@end
