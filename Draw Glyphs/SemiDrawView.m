//
//  SemiDrawView.m
//  Draw Glyphs
//
//  Created by Caylan Larson on 6/11/13.
//  Copyright (c) 2013 Caylan Larson. All rights reserved.
//

#import "SemiDrawView.h"
#import "NSString+SemiGlyph.h"

@implementation SemiDrawView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSPoint origin = CGPointMake(15, 10);
    
    // Setup String
    NSString *string = @"Semi";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSFont fontWithName:@"Helvetica" size:120], NSFontAttributeName,
                                        [NSColor blackColor], NSForegroundColorAttributeName, nil];
    
    NSDictionary *attributes2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSFont fontWithName:@"Courier" size:50], NSFontAttributeName,
                                [NSColor blackColor], NSForegroundColorAttributeName, nil];

    NSDictionary *attributes3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSFont fontWithName:@"Adobe Hebrew" size:50], NSFontAttributeName,
                                 [NSColor blackColor], NSForegroundColorAttributeName, nil];
    
    // Draw Simple Rect
    NSSize simpleSize = [string sizeWithAttributes:attributes];
    NSRect simpleRect = CGRectMake(origin.x, origin.y, simpleSize.width, simpleSize.height);
    NSBezierPath *simplePath = [NSBezierPath bezierPathWithRect:simpleRect];
    [[NSColor purpleColor] set];
    [simplePath fill];

    // Draw Simple String
    [string drawAtPoint:origin withAttributes:attributes];
    
    //---- 1
    
    // Draw Glyph Rect
    origin = CGPointMake(15, 170);
    NSRect glyphRect = [string rectOfGlyphsAtPoint:origin withAttributes:attributes];
    NSBezierPath *glyphPath = [NSBezierPath bezierPathWithRect:glyphRect];
    [[NSColor greenColor] set];
    [glyphPath fill];
    // Draw Glyph String
    [string drawGlyphsAtPoint:origin withAttributes:attributes];
    
    // --- 2
    
    // Draw Glyph Rect
    origin = CGPointMake(310, 170);
    glyphRect = [@"kgf" rectOfGlyphsAtPoint:origin withAttributes:attributes2];
    glyphPath = [NSBezierPath bezierPathWithRect:glyphRect];
    [[NSColor greenColor] set];
    [glyphPath fill];
    // Draw Glyph String
    [@"kgf" drawGlyphsAtPoint:origin withAttributes:attributes2];
    
    // --- 3
    
    // Draw Glyph Rect
    origin = CGPointMake(420, 170);
    glyphRect = [@"KGf" rectOfGlyphsAtPoint:origin withAttributes:attributes3];
    glyphPath = [NSBezierPath bezierPathWithRect:glyphRect];
    [[NSColor greenColor] set];
    [glyphPath fill];
    // Draw Glyph String
    [@"KGf" drawGlyphsAtPoint:origin withAttributes:attributes3];
    
    // Draw Glyph Rect
    origin = CGPointMake(370, 70);
    glyphRect = [@"kg" rectOfGlyphsAtPoint:origin withAttributes:attributes3];
    glyphPath = [NSBezierPath bezierPathWithRect:glyphRect];
    [[NSColor greenColor] set];
    [glyphPath fill];
    // Draw Glyph String
    [@"kg" drawGlyphsAtPoint:origin withAttributes:attributes3];
}

@end
