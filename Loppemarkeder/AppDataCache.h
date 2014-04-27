#import <Foundation/Foundation.h>

@interface AppDataCache : NSObject

@property (nonatomic,strong) NSArray *marketList;
@property (nonatomic, assign) BOOL reload;

+ (AppDataCache *)shared;

@end
