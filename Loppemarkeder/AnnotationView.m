//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "AnnotationView.h"
#import "MarketPlace.h"
#import "MyCLController.h"

@implementation AnnotationView

@synthesize price,backgroundImage,background;
@synthesize endCoordinate;
@synthesize startCoordinate;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
		if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
			self.frame= CGRectMake(0, 0,55, 15);
			self.enabled=NO;
			self.opaque=NO;
			self.selected = NO;
			
			MarketPlace *station = [self annotation];
			self.endCoordinate = station.coordinate;

			self.backgroundImage = nil;			
			UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
			bgImage.image =  station.logo;
			bgImage.frame = CGRectMake(0,0,48,48);
			self.backgroundImage = bgImage;
			
			
			[self addSubview:backgroundImage];
			[self addSubview:price];

			// Set up the Left callout
			UIButton *myDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
			myDetailButton.frame = CGRectMake(0, 0, 58, 41);
			myDetailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			myDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			
			// Set the image for the button
			[myDetailButton setImage:[UIImage imageNamed:@"rute_icon.png"] forState:UIControlStateNormal];
			[myDetailButton addTarget:self action:@selector(navigate:) forControlEvents:UIControlEventTouchUpInside];
			// Set the button as the callout view
			self.leftCalloutAccessoryView = myDetailButton;
	}
	
	
    return self;
}

- (void)drawRect:(CGRect)rect
{
	if(background){
		self.backgroundImage.backgroundColor = [UIColor blueColor];
	}
	else {
		self.backgroundColor = [UIColor clearColor];
	}	
}

- (void) navigate:(id)sender
{
	self.startCoordinate = [MyCLController sharedInstance].theLocation.coordinate;

	NSString *theUrl = [[NSString stringWithFormat:@"maps:maps.google.com/maps?f=d&saddr=%f,%f&daddr=%f,%f",startCoordinate.latitude,startCoordinate.longitude,endCoordinate.latitude,endCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString:theUrl];
	UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];	
}



@end
