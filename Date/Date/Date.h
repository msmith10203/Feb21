//
//  Date.h
//  Date
//
//  Created by nyuguest on 2/7/13.
//  Copyright (c) 2013 nyuguest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date: NSObject {
    
	int year;
	int month;	//1 to 12 inclusive
	int day;	//1 to [self monthLength] inclusive
    
    NSString *reminder;
}

- (id) initWithMonth: (int) m day: (int) d year: (int) y;
- (int) monthLength;    //Return the number of days in the Date's month.

//These four methods are "getters".

@property (nonatomic, assign) int year;
@property (nonatomic, strong) NSString *reminder;

- (int) month;
- (int) day;

//These three methods are "setters".
- (void) setYear: (int) y;
- (void) setMonth: (int) m;
- (void) setDay: (int) d;

- (void) next;			//Advance the Date one day into the future.
- (void) next: (int) distance;	//Advance the Date many days into the future.
- (void) prev;          // Reverse the Date one day into the past.
- (void) prev: (int) distance;  // Reverse the Date many days into the past.

- (int) yearLength;		//Return the number of months in a year.


@end