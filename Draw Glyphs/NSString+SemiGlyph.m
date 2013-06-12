//
//  NSString+SemiGlyph.m
//  ScaleItUp
//
//  Created by Caylan Larson on 6/11/13.
//  Copyright (c) 2013 Caylan Larson. All rights reserved.
//

#import "NSString+SemiGlyph.h"

@implementation NSString (SemiGlyph)

-(void)drawGlyphsAtPoint:(NSPoint)aPoint withAttributes:attributes
{
    [self drawGlyphsAtPoint:aPoint withAttributes:attributes referenceString:self];
}

-(void)drawGlyphsAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary*)attributes referenceString:(NSString*)referenceString
{
    NSRect aRect = [self rectOfGlyphsAtPoint:aPoint withAttributes:attributes];
    
    NSInteger yShift = [referenceString yShiftForGlyphsWithAttributes:attributes];
    NSInteger yDeviceShift = [referenceString yDeviceShiftForGlyphsWithAttributes:attributes];
    NSInteger xDeviceShift = [referenceString xDeviceShiftForGlyphsWithAttributes:attributes];

    aRect.origin.y -= yDeviceShift;
    
    if(yDeviceShift<=0)
        aRect.origin.y += yShift;
    
    aRect.origin.x -= xDeviceShift;
    
    [self drawAtPoint:aRect.origin withAttributes:attributes];
}

-(NSRect)rectOfGlyphsAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary *)attributes
{
    NSRect aRect = [self boundingRectWithSize:NSZeroSize
                                      options:NSStringDrawingUsesDeviceMetrics
                                   attributes:attributes];
    return CGRectMake(aPoint.x, aPoint.y, aRect.size.width, aRect.size.height);
}

-(NSSize)sizeOfGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect aRect = [self rectOfGlyphsAtPoint:NSZeroPoint withAttributes:attributes ];
    return aRect.size;
}

-(NSInteger)widthOfGlyphsWithAttributes:(NSDictionary *)attributes
{
    NSSize aSize = [self sizeOfGlyphsWithAttributes:attributes];
    return aSize.width;
}

-(NSInteger)heightOfGlyphsWithAttributes:(NSDictionary *)attributes
{
    NSSize aSize = [self sizeOfGlyphsWithAttributes:attributes];
    return aSize.height;
}

-(NSString*)widestGlyphWithAttributes:(NSDictionary *)attributes
{
    NSInteger width, curWidth;
    width = curWidth = 0;
    NSString *widestGlyph, *oneGlyph = nil;
    
    for(int i=0; i<[self length]; i++){
        oneGlyph = [self substringWithRange:NSMakeRange(i, 1)];
        curWidth = [oneGlyph widthOfGlyphsWithAttributes:attributes];
        
        if(curWidth > width)
        {
            width = curWidth;
            widestGlyph = oneGlyph;
        }
    }
    
    return widestGlyph;
}

-(NSString*)tallestGlyphWithAttributes:(NSDictionary *)attributes
{
    NSInteger height, curHeight;
    height = curHeight = 0;
    NSString *tallestGlyph, *oneGlyph = nil;
    
    for(int i=1; i<([self length]); i++){
        oneGlyph = [self substringWithRange:NSMakeRange(i, 1)];
        curHeight = [oneGlyph heightOfGlyphsWithAttributes:attributes];
        if(curHeight > height)
        {
            height = curHeight;
            tallestGlyph = oneGlyph;
        }
    }
    
    return tallestGlyph;
}

-(NSString*)shortestGlyphWithAttributes:(NSDictionary *)attributes
{
    NSString *withoutPunctuation = [self stringWithoutPunctuation];
    NSInteger height, curHeight;
    height = curHeight = 0;
    NSString *shortestGlyph, *oneGlyph = nil;
    
    for(int i=0; i<[withoutPunctuation length]; i++){
        oneGlyph = [withoutPunctuation substringWithRange:NSMakeRange(i, 1)];
        curHeight = [oneGlyph heightOfGlyphsWithAttributes:attributes];
        
        if(curHeight < height || height == 0)
        {
            height = curHeight;
            shortestGlyph = oneGlyph;
        }
    }
    
    return shortestGlyph;
}

-(NSInteger)xDeviceShiftForGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect rect = [self boundingRectWithSize:NSZeroSize options:NSStringDrawingUsesDeviceMetrics attributes:attributes];
    return rect.origin.x;
}

-(NSInteger)yDeviceShiftForGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect rect = [self boundingRectWithSize:NSZeroSize options:NSStringDrawingUsesDeviceMetrics attributes:attributes];
    return rect.origin.y;
}

-(NSInteger)yShiftForGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect rect = [self boundingRectWithSize:NSZeroSize options:0 attributes:attributes];
    return rect.origin.y;
}

-(NSString*)stringWithoutPunctuation
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet punctuationCharacterSet]] componentsJoinedByString:@""];
}

@end
