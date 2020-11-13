/*
 * QRCodeReader
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "QRCodeReader.h"
#import <BerTlv/BerTlv.h>
#import <BerTlv/BerTlvBuilder.h>
#import <BerTlv/BerTag.h>
#import <BerTlv/BerTlvs.h>
#import <BerTlv/HexUtil.h>
#import <BerTlv/BerTlvParser.h>

@interface QRCodeReader () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureDevice            *defaultDevice;
@property (strong, nonatomic) AVCaptureDeviceInput       *defaultDeviceInput;
@property (strong, nonatomic) AVCaptureDevice            *frontDevice;
@property (strong, nonatomic) AVCaptureDeviceInput       *frontDeviceInput;
@property (strong, nonatomic) AVCaptureMetadataOutput    *metadataOutput;
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (copy, nonatomic) void (^completionBlock) (NSString *);

@end

@implementation QRCodeReader

- (id)init
{
  if ((self = [super init])) {
    _metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    [self setupAVComponents];
    [self configureDefaultComponents];
  }
  return self;
}

- (id)initWithMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
  if ((self = [super init])) {
    _metadataObjectTypes = metadataObjectTypes;

    [self setupAVComponents];
    [self configureDefaultComponents];
  }
  return self;
}

+ (instancetype)readerWithMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
  return [[self alloc] initWithMetadataObjectTypes:metadataObjectTypes];
}

#pragma mark - Initializing the AV Components

- (void)setupAVComponents
{
  self.defaultDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

  if (_defaultDevice) {
    self.defaultDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_defaultDevice error:nil];
    self.metadataOutput     = [[AVCaptureMetadataOutput alloc] init];
    self.session            = [[AVCaptureSession alloc] init];
    self.previewLayer       = [AVCaptureVideoPreviewLayer layerWithSession:self.session];

    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
      if (device.position == AVCaptureDevicePositionFront) {
        self.frontDevice = device;
      }
    }

    if (_frontDevice) {
      self.frontDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_frontDevice error:nil];
    }
  }
}

- (void)configureDefaultComponents
{
  [_session addOutput:_metadataOutput];

  if (_defaultDeviceInput) {
    [_session addInput:_defaultDeviceInput];
  }

  [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined) {
        [_metadataOutput setMetadataObjectTypes:_metadataObjectTypes];
    }
  
  [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)switchDeviceInput
{
  if (_frontDeviceInput) {
    [_session beginConfiguration];

    AVCaptureDeviceInput *currentInput = [_session.inputs firstObject];
    [_session removeInput:currentInput];

    AVCaptureDeviceInput *newDeviceInput = (currentInput.device.position == AVCaptureDevicePositionFront) ? _defaultDeviceInput : _frontDeviceInput;
    [_session addInput:newDeviceInput];

    [_session commitConfiguration];
  }
}

- (BOOL)hasFrontDevice
{
  return _frontDevice != nil;
}

- (BOOL)isTorchAvailable
{
  return _defaultDevice.hasTorch;
}

- (void)toggleTorch
{
  NSError *error = nil;

  [_defaultDevice lockForConfiguration:&error];

  if (error == nil) {
    AVCaptureTorchMode mode = _defaultDevice.torchMode;

    _defaultDevice.torchMode = mode == AVCaptureTorchModeOn ? AVCaptureTorchModeOff : AVCaptureTorchModeOn;
  }
  
  [_defaultDevice unlockForConfiguration];
}

#pragma mark - Controlling Reader

- (void)startScanning
{
  if (![self.session isRunning]) {
    [self.session startRunning];
  }
}

- (void)stopScanning
{
  if ([self.session isRunning]) {
    [self.session stopRunning];
  }
}

- (BOOL)running {
  return self.session.running;
}

#pragma mark - Managing the Orientation

+ (AVCaptureVideoOrientation)videoOrientationFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  switch (interfaceOrientation) {
    case UIInterfaceOrientationLandscapeLeft:
      return AVCaptureVideoOrientationLandscapeLeft;
    case UIInterfaceOrientationLandscapeRight:
      return AVCaptureVideoOrientationLandscapeRight;
    case UIInterfaceOrientationPortrait:
      return AVCaptureVideoOrientationPortrait;
    default:
      return AVCaptureVideoOrientationPortraitUpsideDown;
  }
}

#pragma mark - Checking the Reader Availabilities

+ (BOOL)isAvailable
{
  @autoreleasepool {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    if (!captureDevice) {
      return NO;
    }

    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];

    if (!deviceInput || error) {
      return NO;
    }

    return YES;
  }
}

+ (BOOL)supportsMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
  if (![self isAvailable]) {
    return NO;
  }

  @autoreleasepool {
    // Setup components
    AVCaptureDevice *captureDevice    = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    AVCaptureMetadataOutput *output   = [[AVCaptureMetadataOutput alloc] init];
    AVCaptureSession *session         = [[AVCaptureSession alloc] init];

    [session addInput:deviceInput];
    [session addOutput:output];

    if (metadataObjectTypes == nil || metadataObjectTypes.count == 0) {
      // Check the QRCode metadata object type by default
      metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }

    for (NSString *metadataObjectType in metadataObjectTypes) {
      if (![output.availableMetadataObjectTypes containsObject:metadataObjectType]) {
        return NO;
      }
    }

    return YES;
  }
}

#pragma mark - Managing the Block

- (void)setCompletionWithBlock:(void (^) (NSString *resultAsString))completionBlock
{
  self.completionBlock = completionBlock;
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate Methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
  for (AVMetadataObject *current in metadataObjects) {
    if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
        && [_metadataObjectTypes containsObject:current.type]) {
      NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];

//        [self clearLayers];
//        AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:current];
//        [self drawLine:obj];
        
      if (_completionBlock) {
        _completionBlock(scannedResult);
      }

      break;
    }
  }
}

#pragma mark - 

- (void)clearLayers
{
    if (self.containerLayer.sublayers)
    {
        for (CALayer *subLayer in self.containerLayer.sublayers)
        {
            [subLayer removeFromSuperlayer];
        }
    }
}

- (CALayer *)containerLayer
{
    if (_containerLayer == nil) {
        _containerLayer = [[CALayer alloc] init];
    }
    return _containerLayer;
}

- (void)drawLine:(AVMetadataMachineReadableCodeObject *)objc
{
    NSArray *array = objc.corners;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    

    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point = CGPointZero;
    int index = 0;
    
    CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);

    CGPointMakeWithDictionaryRepresentation(dict, &point);
    
    [path moveToPoint:point];
    

    for (int i = 1; i<array.count; i++) {
        CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[i], &point);
        [path addLineToPoint:point];
    }

    [path closePath];
    
    layer.path = path.CGPath;

    [self.containerLayer addSublayer:layer];
    
}

#pragma mark - qr customer parser

- (NSData *)base64DataFromString: (NSString *)string {
    unsigned long ixtext, lentext;
    unsigned char ch, input[4], output[3];
    short i, ixinput;
    Boolean flignore, flendtext = false;
    const char *temporary;
    NSMutableData *result;

    if (!string) {
        return [NSData data];
    }

    ixtext = 0;

    temporary = [string UTF8String];

    lentext = [string length];

    result = [NSMutableData dataWithCapacity: lentext];

    ixinput = 0;

    while (true) {
        if (ixtext >= lentext) {
            break;
        }

        ch = temporary[ixtext++];

        flignore = false;

        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }

        if (!flignore) {
            short ctcharsinput = 3;
            Boolean flbreak = false;

            if (flendtext) {
                if (ixinput == 0) {
                    break;
                }

                if ((ixinput == 1) || (ixinput == 2)) {
                    ctcharsinput = 1;
                } else {
                    ctcharsinput = 2;
                }

                ixinput = 3;

                flbreak = true;
            }

            input[ixinput++] = ch;

            if (ixinput == 4) {
                ixinput = 0;

                unsigned char0 = input[0];
                unsigned char1 = input[1];
                unsigned char2 = input[2];
                unsigned char3 = input[3];

                output[0] = (char0 << 2) | ((char1 & 0x30) >> 4);
                output[1] = ((char1 & 0x0F) << 4) | ((char2 & 0x3C) >> 2);
                output[2] = ((char2 & 0x03) << 6) | (char3 & 0x3F);

                for (i = 0; i < ctcharsinput; i++) {
                    [result appendBytes: &output[i] length: 1];
                }
            }

            if (flbreak) {
                break;
            }
        }
    }

    return result;
}

-(void)readerQRString:(NSString*)qrStr callback:(void (^)(NSString *bankAccNo, NSString *bankName, NSString *bankCode, NSString *accName, NSString *phone, NSString *error, NSString *message))callback {
    
    NSData *dataByte=[self base64DataFromString:qrStr];
//    NSString *qrContent=[HexUtil format:dataByte];
    
    BerTlvParser *bParser=[[BerTlvParser alloc] init];
    
    BerTlvs *tlvs =[bParser parseTlvs:dataByte error:nil];
    
    BerTag *bTag57=[BerTag parse:@"57"];
    BerTlv *headerTlv=[tlvs find:bTag57];
    NSString *bTag57Value=[headerTlv textValue];
    NSArray *valueArr=[bTag57Value componentsSeparatedByString:@"D"];
    NSString *addValue=[valueArr objectAtIndex:3];
    
    NSString *phoneStr=[addValue substringFromIndex:12];
    phoneStr=[phoneStr substringToIndex:10];
    NSString *timeStr=[addValue substringToIndex:12];
    
    
    BerTag *bTag61=[BerTag parse:@"61"];
    BerTag *bTag4f=[BerTag parse:@"4F"];
    
    
    BerTlv *bTag61Tlv=[tlvs find:bTag61];
    BerTlv *bTagB4fValue=[bTag61Tlv find:bTag4f];
    NSString *bankCode=[bTagB4fValue textValue];
    NSLog(@"bTagB4fValue: %@",bankCode);
 
    
    BerTag *bTag50=[BerTag parse:@"50"];
    BerTlv *bTag50Value=[bTag61Tlv find:bTag50];
    NSString *bankName=[bTag50Value textValue];
    NSLog(@"bankName: %@",bankName);
    
    
    BerTag *bTag9F24=[BerTag parse:@"9F24"];
    BerTlv *bTag63Tlv=[bTag61Tlv find:bTag9F24];
    BerTlv *bTag9f24fValue=[bTag63Tlv find:bTag9F24];
    NSString *bankAccountNo=[bTag9f24fValue textValue];
    NSLog(@"bankAccountNo: %@",bankAccountNo);
    
    NSString *bankAccLength=[bankAccountNo substringWithRange:NSMakeRange(2, 2)];
    int bankAccLengthInt=[bankAccLength intValue];
    if ([bankAccountNo length]>4+bankAccLengthInt) {
        bankAccountNo=[bankAccountNo substringWithRange:NSMakeRange(4, bankAccLengthInt)];
    }
    
    
    BerTag *bTag62=[BerTag parse:@"62"];
    BerTag *bTag5f20=[BerTag parse:@"5F20"];
    BerTlv *bTag62Tlv=[tlvs find:bTag62];
    BerTlv *bTag5f20Value=[bTag62Tlv find:bTag5f20];
    NSString *accountName=[bTag5f20Value textValue];
    NSLog(@"accountName: %@",accountName);
    
    NSDateFormatter *dateFm=[[NSDateFormatter alloc] init];
    [dateFm setDateFormat:@"yyMMddHHmmss"];
    NSDate *expDate=[dateFm dateFromString:timeStr];
    NSDate *nowDate=[NSDate date];
    
    [dateFm setDateFormat:@"HH:mm:ss dd/MM/yyyy"];
    NSString *dateToDisplay=[dateFm stringFromDate:expDate];

    if ([expDate compare:nowDate] == NSOrderedAscending) {
        callback(nil, nil, nil, nil, phoneStr, kExpiredDate, dateToDisplay);
        return;
    }
    
    if ([self isNotEmpty:bankAccountNo] && [self isNotEmpty:bankName] && [self isNotEmpty:bankCode] && [self isNotEmpty:accountName]) {
        callback(bankAccountNo, bankName, bankCode, accountName, phoneStr, nil, nil);
    } else {
        callback(nil, nil, nil, nil, phoneStr, kQRInvalid, nil);
    }
}

-(BOOL)isNotEmpty: (NSString *)str
{
    if (str == nil)
    {
        return NO;
    }
    if ([str isKindOfClass:[NSString class]] == NO)
    {
        return NO;
    }
    NSString *trim = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trim.length > 0)
    {
        return YES;
    }
    return NO;
}

@end
