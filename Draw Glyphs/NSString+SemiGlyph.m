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
    
    NSInteger leadShift = [referenceString leadShiftForGlyphsWithAttributes:attributes];
    NSInteger descentShift = [referenceString descentShiftForGlyphsWithAttributes:attributes];
    
    //NSLog(@"descentShift:%ld leadShift:%ld", descentShift, leadShift);
    aRect.origin.y -= descentShift;
    
    if(descentShift<=0)
        aRect.origin.y += leadShift;
    
    aRect.origin.y -= 0;
    aRect.origin.x += round(leadShift/8.5);     // I don't know of an alternative to this secret sauce.
    
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

-(NSInteger)descentShiftForGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect descentRect = [self boundingRectWithSize:NSZeroSize options:NSStringDrawingUsesDeviceMetrics attributes:attributes];
    return descentRect.origin.y;  // Magic B (see below)
}

-(NSInteger)leadShiftForGlyphsWithAttributes:(NSDictionary*)attributes
{
    NSRect leadRect = [self boundingRectWithSize:NSZeroSize options:0 attributes:attributes];
    return leadRect.origin.y;  // Magic B (see below)
}

-(NSString*)stringWithoutPunctuation
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet punctuationCharacterSet]] componentsJoinedByString:@""];
}

@end
