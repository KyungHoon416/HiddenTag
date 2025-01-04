

#import "LoginVC.h"
#import "ViewController.h"
//#import "EncodedUUID.h"
//#import "Util.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize appleLogin;
//@synthesize LoginSucces;
//@synthesize succesView;
//로그인 버튼 생성
- (void)viewDidLoad {
    [super viewDidLoad];
    
        NSLog(@"로그인 페이지 진입");
//    [self perfomExistingAccountSetupFlows];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
       [tapGestureRecognizer setCancelsTouchesInView:NO];
       [self.view addGestureRecognizer:tapGestureRecognizer];
    
        //1.로그인 버튼 생성
        ASAuthorizationAppleIDButton *appleIDButton = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
    [appleIDButton setFrame:CGRectMake(0,0, 200, 100)];
        //2. 로그인 버튼 이벤트 설정
        [appleIDButton addTarget:self action:@selector(handleAuthrization:) forControlEvents:UIControlEventTouchUpInside];
    
        //3.스택뷰에 ADD
    [appleLogin addSubview:appleIDButton];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}






//애플 로그인 클릭 - 이벤트
-(void)handleAuthrization:(UIButton *)sender{
    
    
    NSLog(@"handleAuthrization 진입");
    
    NSLog(@"Nickname : %@",self.Nickname.text); // 닉네임 텍스트
    NSLog(@"age : %@",self.age.text); // 나이 텍스트
    NSLog(@"address : %@",self.address.text); // 주소 텍스트
    NSLog(@"gender : %@",self.gender.text); // 성별 텍스트
    
    NSUserDefaults *nsdata = [NSUserDefaults standardUserDefaults];
    [nsdata setObject:self.Nickname.text forKey:@"NickName"]; //nickName 저장
    [nsdata setObject:self.age.text forKey:@"age"]; //나이 저장
    [nsdata setObject:self.address.text forKey:@"address"]; //주소 저장
    [nsdata setObject:self.gender.text forKey:@"gender"]; //성별 저장
    

    //1.애플 로그인 요청 객체 생성
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    
    //2.요청 스코프 설정
    request.requestedScopes = @[ASAuthorizationScopeFullName , ASAuthorizationScopeEmail];
    
    
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    
    controller.delegate = self;
    controller.presentationContextProvider = self;
    [controller performRequests];
    
}

//3
- (void)perfomExistingAccountSetupFlows{
    
     NSLog(@"perfomExistingAccountSetupFlows 진입");
    
   
    
    if (@available(iOS 13.0, *)) {
        
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        
        ASAuthorizationPasswordProvider *passwordProvider = [[ASAuthorizationPasswordProvider alloc] init];
        ASAuthorizationPasswordRequest *passwordRequest = [passwordProvider createRequest];

        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest, passwordRequest]];
        
        
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
    }
}

//로그인 에러 처리
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error{
    
     NSLog(@"didCompleteWithError 진입");
    

    
    
    
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            
            NSLog(@"ASAuthorizationErrorCanceled");
            
            break;
            
        case ASAuthorizationErrorFailed:
            
            NSLog(@"ASAuthorizationErrorFailed");
            
            break;
            
        case ASAuthorizationErrorInvalidResponse:
            
            NSLog(@"ASAuthorizationErrorInvalidResponse");
            
            break;
            
        case ASAuthorizationErrorNotHandled:
            
            NSLog(@"ASAuthorizationErrorNotHandled");
            
            break;
            
        case ASAuthorizationErrorUnknown:
            
            NSLog(@"ASAuthorizationErrorUnknown");
            
            break;
    }
    
}

//presentaion 처리
//델리게이트에게 어떤 윈도우에서 사용자에게 콘텐츠를 제공해야 하는지 알려줌
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller{
    
    NSLog(@"presentationAnchorForAuthorizationController 진입");
    
    return  self.view.window;
}


//로그인 처리
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    
    NSLog(@"didCompleteWithAuthorization 진입");
    
    //성공시 인증정보를 받는다.
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        
        NSString *user =  appleIDCredential.user;
        
        //email.정보는 최초 로그인 되었을 때만 받을 수 있다.
        NSString *email = appleIDCredential.email;
        NSData *identityToken = appleIDCredential.identityToken;
        NSString *accessToken = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSData *authorizationCode = appleIDCredential.authorizationCode;
        NSString *accessToken1 = [[NSString alloc] initWithData:authorizationCode encoding:NSUTF8StringEncoding];
        
//        NSString *url = nil;
////        if([citycode isEqualToString:@"CN"]){
////            url = [NSString stringWithFormat:@"%@/%@", CONFIG_URL_HIDDENTAG_CN, CONFIG_URL_SNSLOGIN];
////        }else{
//            url = [NSString stringWithFormat:@"%@/%@", @"https://www.hiddentagiqr.com", @"snslogin.acc"];
////        }
//        NSString *params = [NSString stringWithFormat:@"uniq=%@&type=8&id=%@", [EncodedUUID getGroupUUID], accessToken1];
//
//        NSLog(@"snsLoginWithURL:%@%@",url,params);
//
//        [self snsLoginWithURL:url parameters:params];
//
//        url = nil;
//        params = nil;

        
        NSLog(@"ASAuthorizationAppleIDCredential.credential.user : %@" , user);
        NSLog(@"ASAuthorizationAppleIDCredential.credential.email : %@" , email);
        NSLog(@"ASAuthorizationAppleIDCredential.credential.accessToken : %@" , accessToken);
        NSLog(@"ASAuthorizationAppleIDCredential.credential.accessToken : %@" , accessToken1);

//        [self performSegueWithIdentifier:@"ViewToLogin" sender:nil];
//        NSUserDefaults *nsdata = [NSUserDefaults standardUserDefaults];
        
//        [nsdata setObject:self.Nickname.text forKey:@"NickName"];
//        [nsdata setObject:self.age.text forKey:@"age"];
//        [nsdata setObject:self.address.text forKey:@"address"];
//        [nsdata setObject:self.gender.text forKey:@"gender"];
        
        
//        LoginSucces.hidden = NO;
//        succesView.hidden = NO;
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        
        
        ASPasswordCredential *passwordCredential = authorization.credential;
        
        NSString *user =  passwordCredential.user;
        NSData *identityToken = passwordCredential.accessibilityAssistiveTechnologyFocusedIdentifiers;
        NSString *accessToken = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSString *password = passwordCredential.password;
        
        NSLog(@"ASPasswordCredential.credential.user : %@" , user);
        NSLog(@"ASPasswordCredential.credential.password : %@" , password);
        NSLog(@"ASPasswordCredential.credential.accessToken : %@" , accessToken);
//        [self performSegueWithIdentifier:@"ViewToLogin" sender:nil];
        
//        LoginSucces.hidden = NO;
//        succesView.hidden = NO;
    }else{
        
        NSLog(@"apple login failed...");

    }
    
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
                    //스토리 보드에서 Indentity Inspector 탭에서 Storyboard ID : ViewController 설정
//                    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
                    //[[[UIApplication sharedApplication] delegate].window setRootViewController:rootViewController];
//                    self.window.rootViewController = vc;
//                    [self.window makeKeyAndVisible];

}


//- (void)snsLoginWithURL:(NSString *)url parameters:(NSString *)parameters {
//    NSLog(@"[LeBeer] snsLoginWithURL : %@?%@", url, parameters);
//    NSMutableURLRequest *l_request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [l_request setHTTPMethod: @"POST"];
//    NSString *params = [NSString stringWithFormat:@"gen=%@", [Util getAESEncodingStr:parameters]];
//    [l_request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData *rtData = [NSURLConnection sendSynchronousRequest:l_request returningResponse:nil error:nil];
//        NSString *rtString = [[NSString alloc] initWithData:rtData encoding:NSUTF8StringEncoding];
//
//    if (rtData != nil) {
//
//            NSLog(@"[LeBeer] snsLogin return string : %@", rtString);
//            NSRange rtRange = [rtString rangeOfString:@"{"];
//            NSUInteger rtStart = rtRange.location;
//            rtRange = [rtString rangeOfString:@")" options:NSBackwardsSearch];
//            rtString = [rtString substringWithRange:NSMakeRange(rtStart, rtRange.location-rtStart)];
//            rtData = [rtString dataUsingEncoding:NSUTF8StringEncoding];
//            NSError *jsonError;
//            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:rtData options:0 error:&jsonError];
//            NSString *result = jsonDict[@"result"];
//            @try {
//                if([result integerValue] == 1) {
//
//
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoogleUserID" object:nil];
//                    NSLog(@"JHJH SNS Login 완료");
//                        NSLog(@"Login 완료 rtString : %@",rtString);
//                    [self performSegueWithIdentifier:@"ViewToLogin" sender:nil];
//
//                }
//            } @catch(NSException *e) {
//                NSLog(@"[LeBeer] exception : %@", e);
//            }
////        }
//        rtData = nil;
//        rtString = nil;
//        jsonError = nil;
//        jsonDict = nil;
//        result = nil;
//        NSLog(@"SNS Login rtData : %@",rtData);
//        NSLog(@"SNS Login jsonDict : %@",jsonDict);
//        NSLog(@"SNS Login result : %@",result);
//        }
//
////    }
//    [_progressView stopImageAnimation];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
