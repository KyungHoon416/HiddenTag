

#import <UIKit/UIKit.h>
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : UIViewController <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet ASAuthorizationAppleIDButton *appleLogin;
@property (strong, nonatomic) UIWindow * window;
@property (weak, nonatomic) IBOutlet UITextField *Nickname;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *gender;





@end

NS_ASSUME_NONNULL_END
