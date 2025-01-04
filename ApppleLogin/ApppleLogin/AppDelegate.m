//
//  AppDelegate.m
//  ApppleLogin
//
//  Created by Inje Cho on 2022/06/09.
//

#import "AppDelegate.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "LoginVC.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //continue with password 선택 후 비번입력하면 full name, email, userIdentifier 가 받아진다.
        //사용자가 다시 로그인하면 사용자의 id만 반환된다.
    
//    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
//    [appleIDProvider getCredentialStateForUserID:@"" completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
//
//
//        BOOL check = false;
//
//        switch (credentialState) {
//            case ASAuthorizationAppleIDProviderCredentialRevoked:
//
//                NSLog(@"ASAuthorizationAppleIDProviderCredentialRevoked");
//
//                break;
//
//            case ASAuthorizationAppleIDProviderCredentialAuthorized:
//
//                //로그인 성공 - 메인화면 이동
//                NSLog(@"ASAuthorizationAppleIDProviderCredentialAuthorized");
//
//                break;
//
//            case ASAuthorizationAppleIDProviderCredentialNotFound:
//
//                //APPLE ID 인증 취소 or 찾을 수 없음
//                //Sign-in 화면으로 이동
//                NSLog(@"ASAuthorizationAppleIDProviderCredentialNotFound");
//
//                check = true;
//
//                break;
//
//            case ASAuthorizationAppleIDProviderCredentialTransferred:
//
//
//                NSLog(@"ASAuthorizationAppleIDProviderCredentialTransferred");
//
//                break;
//        }
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//             이 블럭은 메인스레드(UI)에서 실행된다.

//            if (check) {

//                최상위 뷰로 띄우기
//                self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//                LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
//                self.window.rootViewController = loginVC;
//                [self.window makeKeyAndVisible];
                

    //xib 파일을 최상위 뷰로
    //https://stackoverflow.com/questions/32094241/how-to-set-a-starting-viewcontroller-xib-in-ios-using-objective-c
                
//            }else{
//
//                self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//                //스토리 보드에서 Indentity Inspector 탭에서 Storyboard ID : ViewController 설정
//                ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//
//                //[[[UIApplication sharedApplication] delegate].window setRootViewController:rootViewController];
//                self.window.rootViewController = vc;
//                [self.window makeKeyAndVisible];
            
        //스토리보드를 코드로 불러오기
        //https://stackoverflow.com/questions/22653993/programmatically-change-rootviewcontroller-of-storyboard
        //https://stackoverflow.com/questions/26753925/set-initial-viewcontroller-in-appdelegate-swift
//            }
            
            
//        });
        
//    }];
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
