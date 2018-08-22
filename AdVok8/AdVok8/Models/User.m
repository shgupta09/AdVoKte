//
//  User.m
//  AdVok8
//
//  Created by Shagun Verma on 15/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "User.h"


@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.FirstName forKey:@"FirstName"];
    [aCoder encodeObject:self.LastName forKey:@"LastName"];
    [aCoder encodeObject:self.ContactNo forKey:@"ContactNo"];
    [aCoder encodeObject:self.EmailId forKey:@"EmailId"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.UserName = [aDecoder decodeObjectForKey:@"UserName"];
        self.FirstName = [aDecoder decodeObjectForKey:@"FirstName"];
        self.LastName = [aDecoder decodeObjectForKey:@"LastName"];
        self.ContactNo = [aDecoder decodeObjectForKey:@"ContactNo"];
        self.EmailId = [aDecoder decodeObjectForKey:@"EmailId"];
    }
    return self;
}

@end
