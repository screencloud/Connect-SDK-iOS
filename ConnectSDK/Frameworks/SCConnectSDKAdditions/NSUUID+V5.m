#import "NSUUID+V5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSUUID (V5)

+ (NSUUID*)withNamespaceUUID:(NSUUID*)namespace name:(NSString*)name
{
    uuid_t namespaceBytes;
    [namespace getUUIDBytes:namespaceBytes];
    
    NSData *namespaceData = [NSData dataWithBytes:namespaceBytes length:16];
    
    const char *cstr = [name cStringUsingEncoding:NSUTF8StringEncoding];

    NSData *nameData = [NSData dataWithBytes:cstr length:name.length];
    
    NSMutableData *concatenatedData = [NSMutableData data];
    [concatenatedData appendData:namespaceData];
    [concatenatedData appendData:nameData];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(concatenatedData.bytes, concatenatedData.length, digest);
    
    uuid_t bytes;
    
    // Fill in the UUID bytes, masking in the version and reserved bits
    bytes[0]  = digest[0];   // time_low
    bytes[1]  = digest[1];
    bytes[2]  = digest[2];
    bytes[3]  = digest[3];
    bytes[4]  = digest[4];   // time_mid
    bytes[5]  = digest[5];
    bytes[6]  = ((digest[6] & 0x0F) | 0x50); // time_hi_and_version
    bytes[7]  = digest[7];
    bytes[8]  = ((digest[8] & 0x3F) | 0xB0); // clock_seq_hi_and_reserved
    bytes[9]  = digest[9];  // clock_seq_low
    bytes[10] = digest[10]; // node
    bytes[11] = digest[11];
    bytes[12] = digest[12];
    bytes[13] = digest[13];
    bytes[14] = digest[14];
    bytes[15] = digest[15];
    
    return [[NSUUID alloc] initWithUUIDBytes:bytes];
}

@end