//
//  ServiceDescription+id.m
//  ConnectSDK
//
//  Created by Luke Hubbard on 7/18/14.
//  Copyright (c) 2014 LG Electronics. All rights reserved.
//

#import "ServiceDescription+id.h"

#import "NSUUID+V5.h"
#import "AddressHelper.h"

@implementation ServiceDescription(id)

- (BOOL) looksLikeMacAddress: (NSString *)input
{
    static NSString *expression = @"^([0-9a-f]{2}[.:-]){3,}([0-9a-f]{2})$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:input options:0 range:NSMakeRange(0, [input length])];
    if (match){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL) looksLikeUUID: (NSString *)input
{
    static NSString *expression = @"([0-9a-f]{2}[.:-]?){16,}";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:input options:0 range:NSMakeRange(0, [input length])];
    if (match){
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)id
{
    // rather than use random uuid, we needed a id that wont change for a given device
    // some devices (cough cough LG smart TV's) return thier model name as their unique id
    // hence we need to do a bit of detection to ensure we have a unique id
    // if it looks fishy then grab the mac address and append that
    
    static NSString *uuidNamespaceDNSValue = @"6ba7b810-9dad-11d1-80b4-00c04fd430c8";
    NSUUID *uuidNamespaceDNS = [[NSUUID alloc] initWithUUIDString:uuidNamespaceDNSValue];
    
    NSString *input = self.UUID;
    if(![self looksLikeUUID: self.UUID] && ![self looksLikeMacAddress: self.UUID]){
        // NSLog(@"uuid: %@", self.UUID);
        // NSLog(@"address: %@", self.address);
        NSString *mac = [AddressHelper address2mac:self.address];
        // NSLog(@"mac: %@", mac);
        if(mac && [self looksLikeMacAddress:mac]){
            input = [input stringByAppendingString: mac ];
        } else {
            NSLog(@"unable to determine mac address for address: %@", self.address);
        }
        
    }
    
    return [[[NSUUID withNamespaceUUID:uuidNamespaceDNS name:input] UUIDString] lowercaseString];
}

@end
