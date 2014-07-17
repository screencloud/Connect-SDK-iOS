//
//  AddressHelper.h
//  Remote
//
//  Created by Luke Hubbard on 7/17/14.
//  Copyright (c) 2014 Luke Hubbard. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <sys/param.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "if_types.h"
// #import "route.h"
#include <net/route.h>
#import "if_ether.h"

#include <netinet/in.h>

#include <arpa/inet.h>

#include <err.h>
#include <errno.h>
#include <netdb.h>

#include <paths.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


@interface AddressHelper : NSObject

+ (NSString*)address2mac:(NSString *)address;
+ (NSString*)ip2mac:(in_addr_t)addr;

@end
