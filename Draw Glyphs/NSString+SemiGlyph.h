//
//  NSString+SemiGlyph.h
//  ScaleItUp
//
//  Created by Caylan Larson on 6/11/13.
//  Copyright (c) 2013 Caylan Larson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(SemiGlyph)

-(void)drawGlyphsAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary*)attributes;
-(void)drawGlyphsAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary*)attributes referenceString:(NSString*)referenceString;
-(NSRect)rectOfGlyphsAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary*)attributes;
-(NSSize)sizeOfGlyphsWithAttributes:(NSDictionary*)attributes;
-(NSInteger)widthOfGlyphsWithAttributes:(NSDictionary *)attributes;
-(NSInteger)heightOfGlyphsWithAttributes:(NSDictionary *)attributes;
-(NSString*)widestGlyphWithAttributes:(NSDictionary *)attributes;
-(NSString*)tallestGlyphWithAttributes:(NSDictionary *)attributes;
-(NSString*)shortestGlyphWithAttributes:(NSDictionary *)attributes;
-(NSString*)stringWithoutPunctuation;

@end
