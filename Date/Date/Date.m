//
//  Date.m
//  Date
//
//  Created by nyuguest on 2/7/13.
//  Copyright (c) 2013 nyuguest. All rights reserved.
//
#import <limits.h>
#import "Date.h"

@implementation Date
@synthesize year;
@synthesize reminder;

//Put the date specified by the three arguments into the newborn Date object.

- (id) initWithMonth: (int) m day: (int) d year: (int) y {
	//Send the init message to the superclass object in myself.
    if (self = [super init]) {
		year = y;
		self.month = m;
		self.day = d;
	}
    reminder = @"";
	return self;
}

//Put today's date into the newborn Date object.

- (id) init {
    if (self = [super init]) {
		NSCalendar *calendar =
        [[NSCalendar alloc] initWithCalendarIdentifier: NSHebrewCalendar];
        
		NSDate *today = [[NSDate alloc] init];
		NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
		NSDateComponents *components = [calendar components: unitFlags fromDate: today];
        
		year  = components.year;
		self.month = components.month;
		self.day   = components.day;
	}
    reminder = @"";
	return self;
}

//Return the number of days in the month instance variable (1 to 31 inclusive).

- (int) monthLength {
	NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier: NSHebrewCalendar
                            ];
    
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear: year];
	[components setMonth: month];
	[components setDay: day];
    
	NSRange range = [calendar			//r is a structure, not an object
                     rangeOfUnit: NSDayCalendarUnit
                     inUnit: NSMonthCalendarUnit
                     forDate: [calendar dateFromComponents: components]
                     ];
	return range.length;
}

- (NSString *) description {
	return [NSString stringWithFormat: @"%d/%d/%d %@", month, day, year, reminder];
}

- (int) year {
	return year;
}

- (int) month {
	return month;
}

- (int) day {
	return day;
}

- (void) setYear: (int) y {
    if (y > INT_MAX) {
        NSLog(@"setYear: bad year %d", y);
        return;
    }
	year = y;
}

- (void) setMonth: (int) m {
	if (m < 1 || m > 12) {	//|| means "(non-bitwise) or"
		NSLog(@"setMonth: bad month %d", m);
		return;
	}
	month = m;
}

- (void) setDay: (int) d {
	if (d < 1 || d > [self monthLength]) {
		NSLog(@"setDay: bad day %d with month %d", d, month);
		return;
	}
	day = d;
}

//Return YES if this Date is equal to the other Date, NO otherwise.

- (BOOL) isEqual: (Date *) another {
	return year == another.year
    && month == another.month	//&& means "(non-bitwise) and"
    && day == another.day;
}

//Advance the Date one day into the future.
//This method accepts no arguments.

- (void) next {
	if (day < [self monthLength]) {
		++day;
		return;
	}
	
	day = 1;
	if (month < [self yearLength]) {
		++month;
		return;
	}
    
	month = 1;
	++year;
}
/*
 Advance the Date many days into the future.
 This method accepts one argument.
 It does the bulk of its work by calling the above method over and over.
 */

- (void) next: (int) distance {
	if (distance < 0) {
		NSLog(@"argument %d of next: must be non-negative", distance);
		return;
	}
	
	for (int i = 1; i <= distance; ++i) {
		[self next];
	}
}

// Reverse the Date one day into the past.
// This method accepts no arguments.

-(void) prev {
	if (day > 0) {
		--day;
		return;
	}
	
    // go back to the previous month
	if (month > 0) {
        --month;
        day = [self monthLength];
		return;
	}
    
	month = 1;
	--year;
}

/*
 Reverse the Date many days into the past.
 This method accepts one argument.
 It does the bulk of its work by calling the above method over and over.
 */

- (void) prev: (int) distance {
	if (distance < 0) {
		NSLog(@"argument %d of next: must be non-negative", distance);
		return;
	}
	
	for (int i = 1; i <= distance; ++i) {
		[self prev];
	}
}


// Return the number of months in a year.  A class method is marked with a plus.

- (int) yearLength {
/*
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
*/
    NSCalendar *calendar = [[NSCalendar alloc]
                                  initWithCalendarIdentifier: NSHebrewCalendar];
    
    // What is the range of months in the year that contains today?
    
    NSRange range = [calendar rangeOfUnit: NSMonthCalendarUnit
                                   inUnit: NSYearCalendarUnit
                                  forDate: [[NSDate alloc] init]
    ];
    return range.length;
}

@end