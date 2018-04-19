//
//  Event.h
//  AdVok8
//
//  Created by Shagun Verma on 20/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property int EventId;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *EventName;
@property(nonatomic ,strong) NSString *Matter;
@property(nonatomic ,strong) NSString *Location;
@property(nonatomic ,strong) NSString *Attendees;
@property(nonatomic ,strong) NSString *Description;
@property(nonatomic ,strong) NSString *StartAt;
@property(nonatomic ,strong) NSString *EndAt;
@property(nonatomic ,strong) NSString *StartTime;
@property(nonatomic ,strong) NSString *EndTime;
@property bool AllDay;

@end


