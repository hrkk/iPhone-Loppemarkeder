//
//  Utilities.h
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <Foundation/Foundation.h>


@interface Utilities : NSObject{
	
	
}

+(NSArray*)sortArrayByDistance:(NSArray*)nonSortedArr;
+(NSArray*)sortArrayByDate:(NSArray*)nonSortedArr;
+(NSArray*)sortArrayByName:(NSArray*)nonSortedArr;
+(NSMutableArray*) loadFromJson:(NSArray*)allMarkets;

@end
