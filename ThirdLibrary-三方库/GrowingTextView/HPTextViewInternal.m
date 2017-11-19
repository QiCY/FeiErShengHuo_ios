//
//  HPTextViewInternal.m
//
//  Created by Hans Pinckaers on 29-06-10.
//
//	MIT License
//
//	Copyright (c) 2011 Hans Pinckaers
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import "HPTextViewInternal.h"
#import "MMTextAttachment.h"


@implementation HPTextViewInternal

-(void)setText:(NSString *)text
{
    BOOL originalValue = self.scrollEnabled;
    //If one of GrowingTextView's superviews is a scrollView, and self.scrollEnabled == NO,
    //setting the text programatically will cause UIKit to search upwards until it finds a scrollView with scrollEnabled==yes
    //then scroll it erratically. Setting scrollEnabled temporarily to YES prevents this.
    [self setScrollEnabled:YES];
    [super setText:text];
    [self setScrollEnabled:originalValue];
}

- (void)setScrollable:(BOOL)isScrollable
{
    [super setScrollEnabled:isScrollable];
}

-(void)setContentOffset:(CGPoint)s
{
	if(self.tracking || self.decelerating){
		//initiated by user...
        
        UIEdgeInsets insets = self.contentInset;
        insets.bottom = 0;
        insets.top = 0;
        self.contentInset = insets;
        
	} else {

		float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
		if(s.y < bottomOffset && self.scrollEnabled){            
            UIEdgeInsets insets = self.contentInset;
            insets.bottom = 8;
            insets.top = 0;
            self.contentInset = insets;            
        }
	}
    
    // Fix "overscrolling" bug
    if (s.y > self.contentSize.height - self.frame.size.height && !self.decelerating && !self.tracking && !self.dragging)
        s = CGPointMake(s.x, self.contentSize.height - self.frame.size.height);
    
	[super setContentOffset:s];
}

-(void)setContentInset:(UIEdgeInsets)s
{
	UIEdgeInsets insets = s;
	
	if(s.bottom>8) insets.bottom = 0;
	insets.top = 0;

	[super setContentInset:insets];
}

-(void)setContentSize:(CGSize)contentSize
{
    // is this an iOS5 bug? Need testing!
    if(self.contentSize.height > contentSize.height)
    {
        UIEdgeInsets insets = self.contentInset;
        insets.bottom = 0;
        insets.top = 0;
        self.contentInset = insets;
    }
    
    [super setContentSize:contentSize];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.displayPlaceHolder && self.placeholder && self.placeholderColor)
    {
        if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = self.textAlignment;
            [self.placeholder drawInRect:CGRectMake(5, 8 + self.contentInset.top, self.frame.size.width-self.contentInset.left, self.frame.size.height- self.contentInset.top) withAttributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.placeholderColor, NSParagraphStyleAttributeName:paragraphStyle}];
        }
        else {
            [self.placeholderColor set];
            [self.placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withFont:self.font];
        }
    }
}

-(void)setPlaceholder:(NSString *)placeholder
{
	_placeholder = placeholder;
	
	[self setNeedsDisplay];
}

- (NSString *)faceStr
{
    __block NSString *faceStr = @"";
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        if (attrs[@"NSAttachment"]) {
            MMTextAttachment *mta = attrs[@"NSAttachment"];
            
            faceStr = [faceStr stringByAppendingString:mta.faceStr];
            
        } else {
            
            faceStr = [faceStr stringByAppendingString:[self.attributedText attributedSubstringFromRange:range].string];
        }
        
    }];
    
    return faceStr;
}


- (void)backFace
{
    if (self.attributedText.length == 0) {
        return;
    }
    
    if (self.selectedRange.length == 0) {
        
        if (self.selectedRange.location == 0) {
            return;
        }
        
        int length = 1;
        NSDictionary *dic = [self.attributedText attributesAtIndex:self.selectedRange.location-1 effectiveRange:nil];
        UIFont *font = dic[@"NSFont"];
        
        if ([font.familyName isEqualToString:@"Apple Color Emoji"]) {
            length = 2;
        }
        
        [self backFaceWithRange:NSMakeRange(self.selectedRange.location - length, length)];
    } else {
        [self backFaceWithRange:self.selectedRange];
    }
}

- (void)backFaceWithRange:(NSRange)range
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText replaceCharactersInRange:range withString:@""];
    
    self.attributedText = attributedText;
    
    if (self.attributedText.length == 0) {
        return;
    }
    
    self.selectedRange = NSMakeRange(range.location, 0);
    
}

- (void)insertFaceWithImageName:(NSString *)imageName des:(NSString *)des
{
    NSInteger currentLoc = self.selectedRange.location;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    MMTextAttachment* textAttachment = [[ MMTextAttachment alloc ] initWithData:nil ofType:nil];
    textAttachment.faceStr = des;
    
    UIImage *emImage =  [UIImage imageNamed:imageName];
    textAttachment.image = emImage ;
    
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [attributedText insertAttributedString:textAttachmentString atIndex:currentLoc];
    
    [attributedText addAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15.f] forKey:NSFontAttributeName] range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttributes:[NSDictionary dictionaryWithObject:GLOBAL_BIG_FONT_COLOR forKey:NSForegroundColorAttributeName] range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
    
    self.selectedRange = NSMakeRange(currentLoc+1,0);
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self refreshPlaceholderView];
    [self performSelector:@selector(resizeText) withObject:nil afterDelay:.05];
}

- (void)refreshPlaceholderView
{
    if (_placeholder) {
        if (self.text.length || self.attributedText.length) {
            _placeholder = nil;
        }
    }
}

- (void)resizeText
{
    [self.delegate textViewDidChange:self];
}

@end
