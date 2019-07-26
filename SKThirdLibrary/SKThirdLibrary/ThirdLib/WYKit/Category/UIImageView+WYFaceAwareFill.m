//
//  UIImageView+WYFaceAwareFill.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UIImageView+WYFaceAwareFill.h"
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

static CIDetector* _faceDetector;

@implementation UIImageView (WYFaceAwareFill)


+ (void)initialize
{
    _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                       context:nil
                                       options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    
}


- (void) faceAwareFill {
    // Safe check!
    if (self.image == nil) {
        return;
    }
    
    CGRect facesRect = [self rectWithFaces];
    if (facesRect.size.height + facesRect.size.width == 0)
        return;
    self.contentMode = UIViewContentModeTopLeft;
    [self scaleImageFocusingOnRect:facesRect];
}


// 图片当人脸被检测到时，它会就以脸部中心替代图片的集合中心
- (CGRect) rectWithFaces {
    // Get a CIIImage
    CIImage* image = self.image.CIImage;
    
    // If now available we create one using the CGImage
    if (!image) {
        image = [CIImage imageWithCGImage:self.image.CGImage];
    }
    
    // Use the static CIDetector
    CIDetector* detector = _faceDetector;
    
    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:image];
    
    // we'll iterate through every detected face. CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.
    CGRect totalFaceRects = CGRectMake(self.image.size.width/2.0, self.image.size.height/2.0, 0, 0);
    
    if (features.count > 0) {
        //We get the CGRect of the first detected face
        totalFaceRects = ((CIFaceFeature*)[features objectAtIndex:0]).bounds;
        
        // Now we find the minimum CGRect that holds all the faces
        for (CIFaceFeature* faceFeature in features) {
            totalFaceRects = CGRectUnion(totalFaceRects, faceFeature.bounds);
        }
    }
    
    //So now we have either a CGRect holding the center of the image or all the faces.
    return totalFaceRects;
}

- (void) scaleImageFocusingOnRect:(CGRect) facesRect {
    CGFloat multi1 = self.frame.size.width / self.image.size.width;
    CGFloat multi2 = self.frame.size.height / self.image.size.height;
    CGFloat multi = MAX(multi1, multi2);
    
    //We need to 'flip' the Y coordinate to make it match the iOS coordinate system one
    facesRect.origin.y = self.image.size.height - facesRect.origin.y - facesRect.size.height;
    
    facesRect = CGRectMake(facesRect.origin.x*multi, facesRect.origin.y*multi, facesRect.size.width*multi, facesRect.size.height*multi);
    
    CGRect imageRect = CGRectZero;
    imageRect.size.width = self.image.size.width * multi;
    imageRect.size.height = self.image.size.height * multi;
    imageRect.origin.x = MIN(0.0, MAX(-facesRect.origin.x + self.frame.size.width/2.0 - facesRect.size.width/2.0, -imageRect.size.width + self.frame.size.width));
    imageRect.origin.y = MIN(0.0, MAX(-facesRect.origin.y + self.frame.size.height/2.0 -facesRect.size.height/2.0, -imageRect.size.height + self.frame.size.height));
    
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 2.0);
    [self.image drawInRect:imageRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
    
    //This is to show the red rectangle over the faces
#ifdef DEBUGGING_FACE_AWARE_FILL
    NSInteger theRedRectangleTag = -3312;
    UIView* facesRectLine = [self viewWithTag:theRedRectangleTag];
    if (!facesRectLine) {
        facesRectLine = [[UIView alloc] initWithFrame:facesRect];
        facesRectLine.tag = theRedRectangleTag;
    }
    else {
        facesRectLine.frame = facesRect;
    }
    
    facesRectLine.backgroundColor = [UIColor clearColor];
    facesRectLine.layer.borderColor = [UIColor redColor].CGColor;
    facesRectLine.layer.borderWidth = 4.0;
    
    CGRect frame = facesRectLine.frame;
    frame.origin.x = imageRect.origin.x + frame.origin.x;
    frame.origin.y = imageRect.origin.y + frame.origin.y;
    facesRectLine.frame = frame;
    
    [self addSubview:facesRectLine];
#endif
    
}


@end
