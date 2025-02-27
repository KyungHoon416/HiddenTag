//
//  HIDDENPhotoViewCell.m
//  HiddentagUIimages_Example
//
//  Created by 경훈's MacBook on 2022/12/04.
//  Copyright © 2022 kimkyunghoon. All rights reserved.
//

#import "HIDDENPhotoViewCell.h"
#import "HIDDENPhotoPickerTheme.h"


static const CGFloat HIDDENHightedAnimationDuration = 0.15;
static const CGFloat HIDDENUnhightedAnimationDuration = 0.4;
static const CGFloat HIDDENHightedAnimationTransformScale = 0.9;
static const CGFloat HIDDENUnhightedAnimationSpringDamping = 0.5;
static const CGFloat HIDDENUnhightedAnimationSpringVelocity = 6.0;

@interface HIDDENPhotoViewCell(){
 
}

@property (nonatomic, assign, getter=isAnimatingHighlight) BOOL animateHighlight;
@property (nonatomic, assign) BOOL enableSelectionIndicatorViewVisibility;

@end

@implementation HIDDENPhotoViewCell
#pragma mark -포토 이미지 클릭시 관련해서 숫자와 이미지

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [self addGestureRecognizer:self.longPressGestureRecognizer];
    
    self.selectionOrderLabel.textColor = [HIDDENPhotoPickerTheme sharedInstance].orderLabelTextColor;
    self.selectionOrderLabel.font = [HIDDENPhotoPickerTheme sharedInstance].selectionOrderLabelFont;
    
    
    self.selectionVeil.layer.borderWidth = 2.0;
    self.selectionVeil.layer.cornerRadius = 8.0;
    
    
//    self.selectionOrderLabel.backgroundColor = [HIDDENPhotoPickerTheme sharedInstance].orderTintColor;
    self.selectionVeil.layer.borderColor = [HIDDENPhotoPickerTheme sharedInstance].orderTintColor.CGColor;
    
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    [self cancelImageRequest];

    self.imageView.image = nil;
    self.enableSelectionIndicatorViewVisibility = NO;
    self.selectionVeil.alpha = 0.0;
    self.selectionOrderLabel.alpha = 0.0;
    self.Selectimage.alpha = 0.0;
    
    

}



- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    [self setSelected:selected animated:self.animateSelection];
}

- (void)setSelectionOrder:(NSUInteger)selectionOrder
{
    _selectionOrder = selectionOrder;
    self.selectionOrderLabel.text = [NSString stringWithFormat:@"%zd", selectionOrder];
}


#pragma mark - Publics

- (void)loadPhotoWithManager:(PHImageManager *)manager forAsset:(PHAsset *)asset targetSize:(CGSize)size
{
    self.imageManager = manager;
//    self.im
    self.imageRequestID = [self.imageManager requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        // Set the cell's thumbnail image if it's still showing the same asset.
                                                        if ([self.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                                            self.thumbnailImage = result;
                                                        }
                                                    }];
}

- (void)setNeedsAnimateSelection
{
    self.animateSelection = YES;
}

- (void)animateHighlight:(BOOL)highlighted
{
    if (highlighted) {
        self.animateHighlight = YES;
        [UIView animateWithDuration:HIDDENHightedAnimationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformMakeScale(HIDDENHightedAnimationTransformScale, HIDDENHightedAnimationTransformScale);
        } completion:^(BOOL finished) {
            self.animateHighlight = NO;
        }];
    }
    else {
        [UIView animateWithDuration:HIDDENUnhightedAnimationDuration delay:self.isAnimatingHighlight? HIDDENHightedAnimationDuration: 0 usingSpringWithDamping:HIDDENUnhightedAnimationSpringDamping initialSpringVelocity:HIDDENUnhightedAnimationSpringVelocity options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}


#pragma mark - Privates

- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

- (void)cancelImageRequest
{
    if (self.imageRequestID != PHInvalidImageRequestID) {
        [self.imageManager cancelImageRequest:self.imageRequestID];
        self.imageRequestID = PHInvalidImageRequestID;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (!animated) {
        self.selectionVeil.alpha = selected ? 1.0 : 0.0;
        self.selectionOrderLabel.alpha = selected ? 1.0 : 0.0;
        self.Selectimage.alpha =  selected ? 1.0 : 0.0;
        self.enableSelectionIndicatorViewVisibility = selected;
    }
    else {
        self.enableSelectionIndicatorViewVisibility = YES;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.selectionVeil.alpha = selected ? 1.0 : 0.0;
            self.selectionOrderLabel.alpha = selected ? 1.0 : 0.0;
            self.Selectimage.alpha =  selected ? 1.0 : 0.0;
        } completion:^(BOOL finished) {
            self.enableSelectionIndicatorViewVisibility = selected;
        }];
    }
    self.animateSelection = NO;
}



@end
