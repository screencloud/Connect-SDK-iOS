//
//  NSUUID+V5.h
//  Remote
//
//  Created by Luke Hubbard on 7/17/14.
//  Copyright (c) 2014 Luke Hubbard. All rights reserved.
//

@interface NSUUID (V5)

+ (NSUUID*)withNamespaceUUID:(NSUUID*)namespace name:(NSString*)name;

@end