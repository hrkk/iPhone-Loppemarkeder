//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "MarketPlace.h"
#import "MyCLController.h"

@implementation MarketPlace

@synthesize  name,address1, address2, city, zip, logo, coordinate;
@synthesize distance;
@synthesize title,subtitle,currentLocation;
@synthesize nykreditBranch;
@synthesize openingHours;
@synthesize imageName;
@synthesize hasATM;
@synthesize phoneNumber;
@synthesize webLink;
@synthesize atmId;
@synthesize isBank;

- (id) initWithMPXDictionary:(NSDictionary *)dict
{
	if (self = [super init]) {		
		
		self.name = [dict  objectForKey:@"text"];
		self.atmId = [[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.id"];

		NSRange bankrange =[[[[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.type"] lowercaseString] rangeOfString:@"bank"];

		if (bankrange.location == NSNotFound) {
			self.isBank = NO;
		}
		else {
			self.isBank = YES;
		}


		if(self.name == nil || [self.name length]==0) {
			self.name = [[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.name"];

		}
		self.name = [self.name capitalizedString];
		self.address1 = [[[dict objectForKey:@"geoData"] objectForKey:@"address"] lowercaseString];
		if(self.name != nil && [self.name length]!=0)
			self.address1 = [self.address1 capitalizedString];
		
		self.address2 = [[dict objectForKey:@"fields"] objectForKey:@"Icon"];
		self.city = [[dict objectForKey:@"geoData"] objectForKey:@"city"];
		self.zip = [[dict objectForKey:@"geoData"] objectForKey:@"postalCode"];

		id data =[[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.tel.number"];
		if([data isKindOfClass:[NSArray class]]) {
			self.phoneNumber = [[data objectForKey:0] stringValue];
		}
		else
			self.phoneNumber = [data stringValue];
		if(self.phoneNumber == nil || [self.phoneNumber length] == 0)
			self.phoneNumber = @"";//@"22 33 44 55";
		CGFloat latitude = [[[dict objectForKey:@"geoData"] objectForKey:@"latitude"] floatValue];
		CGFloat longitude = [[[dict objectForKey:@"geoData"] objectForKey:@"longitude"] floatValue];
		self.logo = [UIImage imageNamed:[[dict objectForKey:@""] objectForKey:@"image"]];
		self.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		
		self.coordinate = currentLocation.coordinate;
		
		data =[[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.works.24h"];
		if([data isKindOfClass:[NSArray class]]) 
			self.openingHours = @" 24H";
		
		else{
			
		NSString *open = [[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.works.24h"];
		if([open caseInsensitiveCompare:@"ja"]== 0)
			self.openingHours = @" 24H";
		else if([open caseInsensitiveCompare:@"nej"]== 0)
				self.openingHours = @" 24H";
		else {
			self.openingHours = open;
		}
		
		if (self.openingHours == nil || [self.openingHours length] <1) {
			self.openingHours = @" 24H";
		}
		}
		
			//		([[[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.works.24h"] boolValue]? @" 24 H" : @"begrænset");
		self.title = name;
		self.hasATM = [[[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.has.atm"] boolValue];
		
		NSDictionary *image = [[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.image"];
		@try {
			NSArray *path = [[[image objectForKey:@"url"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]pathComponents];
			self.imageName = [path lastObject];

		}
		@catch (NSException * e) {
			//self.imageName = @"pbs.png";
			self.imageName = @"pbs_small.png";
			
			//pbs_small.png
		}
		self.webLink = [[dict objectForKey:@"fields"] objectForKey:@"nykredit.bank.url"];
		if(self.webLink == nil || [self.webLink length]<1)
			self.webLink = @"";
		
		
		NSRange range = [[self.name  lowercaseString] rangeOfString:@"nykredit"];
		NSRange range1 = [[self.name  lowercaseString] rangeOfString:@"forstæder"];

		if (range.location!=NSNotFound || range1.location != NSNotFound) {
			nykreditBranch=YES;
		}

	}
	return self;
}	

- (id) initWithDictionary:(NSDictionary *) dict{
	
	if (self = [super init]) {
		self.atmId = [dict objectForKey:@"atmId"]; 
		self.name = [dict objectForKey:@"name"];
		self.address1 = [dict objectForKey:@"address"];
		self.address2 = [dict objectForKey:@"Icon"];
		self.city = [dict objectForKey:@"city"];
		self.zip = [dict objectForKey:@"zip"];

		self.hasATM = [[dict objectForKey:@"hasATM"] boolValue];; 
		self.phoneNumber = [dict objectForKey:@"phoneNumber"];
		CGFloat latitude = [[dict objectForKey:@"latitude"] floatValue];
		CGFloat longitude = [[dict objectForKey:@"longitude"] floatValue];
      
		self.logo = [UIImage imageNamed:[dict objectForKey:@"image"]];
		self.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		
		self.coordinate = currentLocation.coordinate;
		
		self.title = name;
		NSRange range = [[self.name  lowercaseString] rangeOfString:@"nykredit"];
		NSRange range1 = [[self.name  lowercaseString] rangeOfString:@"forstæder"];
		if (range.location!=NSNotFound || range1.location != NSNotFound) {
			nykreditBranch=YES;
		}
		self.openingHours = [dict objectForKey:@"hours"];
		
		self.webLink = [dict objectForKey:@"webLink"];
        self.imageName =[dict objectForKey:@"image"];
		self.isBank = [[dict objectForKey:@"isBank"] boolValue];
		
	}
	return self;
}	

- (NSString *)title {
	return [NSString stringWithFormat:@"%@ (%.1f km)",self.name,self.distance/1000];
}

- (NSString *)subtitle {
	if(hasATM)
		return [NSString stringWithFormat:@"Hæveautomat (%@) ",self.openingHours];
	else
		return [NSString stringWithFormat:@"Bankfilial (%@) ",self.openingHours];
	
}

- (NSDictionary *)automatAsDictionary
{
	NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
	
	// Add values if they are not nil
	if( self.name )			[tmpDict setObject:self.name forKey:@"name"];
	if( self.imageName )	[tmpDict setObject:self.imageName forKey:@"image"];
	if( self.address1 )		[tmpDict setObject:self.address1 forKey:@"address"];
	if( self.address2 )		[tmpDict setObject:self.address2 forKey:@"address2"];
	if( self.zip )			[tmpDict setObject:self.zip forKey:@"zip"];
	if( self.city )			[tmpDict setObject:self.city forKey:@"city"];
	if( self.phoneNumber )	[tmpDict setObject:self.phoneNumber forKey:@"phoneNumber"];
	if( self.webLink )		[tmpDict setObject:self.webLink forKey:@"webLink"];
	if( self.atmId )		[tmpDict setObject:self.atmId forKey:@"atmId"];
	if( self.openingHours )	[tmpDict setObject:self.openingHours forKey:@"hours"];

	// These properties are never nil, but might still have an zero value. 
	// And for lat/lng a value of 0,0 should be considered an invalid position.
	[tmpDict setObject:[NSNumber numberWithFloat:self.coordinate.latitude] forKey:@"latitude"];
	[tmpDict setObject:[NSNumber numberWithFloat:self.coordinate.longitude] forKey:@"longitude"];
	[tmpDict setObject:[NSNumber numberWithBool:self.hasATM] forKey:@"hasATM"];
	[tmpDict setObject:[NSNumber numberWithBool:self.isBank] forKey:@"isBank"];
									  
	return [NSDictionary dictionaryWithDictionary:tmpDict];
}

- (bool)automatContainsSearchString:(NSString *)searchString
{
	NSRange range = [[name lowercaseString] rangeOfString:searchString];
	if(range.location != NSNotFound )
		return YES;
	range = [[zip lowercaseString] rangeOfString:searchString];
	if(range.location != NSNotFound )
		return YES;
	range = [[city lowercaseString] rangeOfString:searchString];
	if(range.location != NSNotFound )
		return YES;
	range = [[address1 lowercaseString] rangeOfString:searchString];
	if(range.location != NSNotFound )
		return YES;
	return NO;
}

-(CGFloat) getDistance
{
	CLLocation *cur = [MyCLController sharedInstance].theLocation;
	return [cur distanceFromLocation:self.currentLocation];
}

@end
