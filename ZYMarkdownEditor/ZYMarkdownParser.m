//
//  ZYMarkdownParser.h
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "ZYMarkdownParser.h"
#import "YYText.h"

#define rgb(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define regexp(reg, option) [NSRegularExpression regularExpressionWithPattern : reg options : option error : NULL]
@implementation ZYMarkdownParser {
    
    UIFont *_textFont;
    NSMutableArray *_headerFonts;
    
    YYTextBorder *_border;
    
    NSRegularExpression *_regexEscape;
    NSRegularExpression *_regexHeader;
    NSRegularExpression *_regexH1;
    NSRegularExpression *_regexH2;
    NSRegularExpression *_regexBreakline;
    NSRegularExpression *_regexEmphasis;
    NSRegularExpression *_regexStrong;
    NSRegularExpression *_regexStrongEmphasis;
    NSRegularExpression *_regexUnderline;
    NSRegularExpression *_regexStrikethrough;
    NSRegularExpression *_regexInlineCode;
    NSRegularExpression *_regexCodeBlock;
    NSRegularExpression *_regexCodeLines;
    NSRegularExpression *_regexNotEmptyLine;
    NSRegularExpression *_regexLink;
    NSRegularExpression *_regexLinkRefer;       
    NSRegularExpression *_regexList;
    NSRegularExpression *_regexReference;
   
 
}

- (void)createRegex {
    
    _regexEscape = regexp(@"(\\\\\\\\|\\\\\\`|\\\\\\*|\\\\\\_|\\\\\\(|\\\\\\)|\\\\\\[|\\\\\\]|\\\\#|\\\\\\+|\\\\\\-|\\\\\\!)", 0);
    _regexHeader = regexp(@"^((\\#{1,6}+\\s+[^#].*))$", NSRegularExpressionAnchorsMatchLines);
    _regexH1 = regexp(@"^[^=\\n][^\\n]*\\n=+$", NSRegularExpressionAnchorsMatchLines);
    _regexH2 = regexp(@"^[^-\\n][^\\n]*\\n-+$", NSRegularExpressionAnchorsMatchLines);
    
    _regexBreakline = regexp(@"^[ \\t]*([*-])[ \\t]*((\\1)[ \\t]*){2,}[ \\t]*$", NSRegularExpressionAnchorsMatchLines);
    _regexUnderline = regexp(@"(?<!_)__(?=[^ \\t_])(.+?)(?<=[^ \\t_])\\__(?!_)", 0);
    _regexStrikethrough = regexp(@"(?<!~)~~(?=[^ \\t~])(.+?)(?<=[^ \\t~])\\~~(?!~)", 0);
    
    _regexEmphasis = regexp(@"((?<!\\*)\\*(?=[^ \\t*])(.+?)(?<=[^ \\t*])\\*(?!\\*)|(?<!_)_(?=[^ \\t_])(.+?)(?<=[^ \\t_])_(?!_))", 0);
    _regexStrong = regexp(@"(?<!\\*)\\*{2}(?=[^ \\t*])(.+?)(?<=[^ \\t*])\\*{2}(?!\\*)", 0);
    _regexStrongEmphasis =  regexp(@"((?<!\\*)\\*{3}(?=[^ \\t*])(.+?)(?<=[^ \\t*])\\*{3}(?!\\*)|(?<!_)_{3}(?=[^ \\t_])(.+?)(?<=[^ \\t_])_{3}(?!_))", 0);
    
    _regexInlineCode = regexp(@"(?<!`)(`{1,3})([^`\n]+?)\\1(?!`)", 0);
    _regexLink = regexp(@"!?\\[([^\\[\\]]+)\\](\\(([^\\(\\)]+)\\)|\\[([^\\[\\]]+)\\])", 0);
    _regexLinkRefer = regexp(@"^[ \\t]*\\[[^\\[\\]]\\]:", NSRegularExpressionAnchorsMatchLines);
    _regexList = regexp(@"^[ \\t]*([*+-]|\\d+[.])[ \\t]+", NSRegularExpressionAnchorsMatchLines);
    _regexReference = regexp(@"^[ \\t]*>[ \\t>]*[^#].*", NSRegularExpressionAnchorsMatchLines);
    _regexCodeBlock = regexp(@"(^\\s*$\\n)((( {4}|\\t).*(\\n|\\z))|(^\\s*$\\n))+", NSRegularExpressionAnchorsMatchLines);
    _regexCodeLines = regexp(@"```([\\s\\S]*?)```[\\s]?",NSRegularExpressionAnchorsMatchLines);
    _regexNotEmptyLine = regexp(@"^[ \\t]*[^ \\t]+[ \\t]*$", NSRegularExpressionAnchorsMatchLines);
    
    
#undef regexp
}



- (instancetype)init {
    self = [super init];
     [self createRegex];
    self.fontSize = 27;
    _headerFontSize = 36;
    _textFontName = @"PingFangSC-Regular";
    [self updateFonts];
   
    return self;
}

- (void)setFontSize:(CGFloat)fontSize {
    if (fontSize < 1.0) fontSize = 12;
    _fontSize = fontSize;
    [self updateFonts];
}

- (void)setHeaderFontSize:(CGFloat)headerFontSize {
    if (headerFontSize < 1.0) headerFontSize = 20;
    _headerFontSize = headerFontSize;
    [self updateFonts];
    
    
}


- (void)setTextFontName:(NSString *)textFontName {
    
    _textFontName = textFontName;
    [self updateFonts];
    
}


- (void)updateFonts {
    
    _textFont = [UIFont fontWithName:self.textFontName size: self.fontSize];
    
    _headerFonts = [NSMutableArray new];
    for (int i = 0; i < 6; i++) {
        CGFloat size = _headerFontSize - (_headerFontSize - _fontSize) / 5.0 * i;
        [_headerFonts addObject:[UIFont fontWithName:@"PingFangSC-Regular" size: size]];
    }
    
    
}

- (void)setColorWithAtomTheme {
    
    
    _border = [YYTextBorder new];
    _border.lineStyle = YYTextLineStyleSingle;
    _border.fillColor = [UIColor colorWithWhite:0.820 alpha:0.130];
    _border.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.280];
    _border.insets = UIEdgeInsetsMake(-1, 0, -1, 0);
    _border.cornerRadius = 2;
    _border.strokeWidth = YYTextCGFloatFromPixel(1);
    
    
    _textColor              = rgb(155, 162, 177);
    _controlTextColor       = rgb(214, 85, 82);
    _headerTextColor        = rgb(214, 85, 82);
    _inlineCodeColor        = rgb(136, 186, 81);
    _codeBlockColor         = rgb(136, 186, 81);
    _linkTextColor          = rgb(184, 93, 213);
    _emphasisTextColor      = rgb(197, 136, 83);
    _underlineColor         = rgb(184, 93, 213);
    _linkNameTextColor      = rgb(76, 158, 235);
    _linkReferNameColor     = rgb(76, 158, 235);
    _referenceColor         = [UIColor whiteColor];
    _imageLinkTextColor     = _linkReferColor   = _linkTextColor;
    _H1color                = _H2Color     = _headerTextColor;
    _listColor              = _controlTextColor;
    _strikeThroughColor     = _controlTextColor;
    _breakLineColor         = _controlTextColor;
    _strongEmphasisColor    = _emphasisTextColor;
    _strongColor            = _emphasisTextColor;

}


- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)range {
    
    
    
    
    if (text.length == 0) return NO;
    [text yy_removeAttributesInRange:NSMakeRange(0, text.length)];
    text.yy_font = [UIFont fontWithName:self.textFontName size:self.fontSize];
    text.yy_color = _textColor;
    
    NSMutableString *str = text.string.mutableCopy;
    [_regexEscape replaceMatchesInString:str options:kNilOptions range:NSMakeRange(0, str.length) withTemplate:@"@@"];
    
    
        
        
        [_regexHeader enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange r = result.range;
            NSUInteger whiteLen = [self lenghOfBeginWhiteInString:str withRange:r];
            NSUInteger sharpLen = [self lenghOfBeginChar:'#' inString:str withRange:NSMakeRange(r.location + whiteLen, r.length - whiteLen)];
            if (sharpLen > 6) sharpLen = 6;
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location, whiteLen + sharpLen)];
            [text yy_setColor:_headerTextColor range:NSMakeRange(r.location + whiteLen + sharpLen, r.length - whiteLen - sharpLen)];
            [text yy_setFont:_headerFonts[sharpLen - 1] range:result.range];
            
        }];
        
        [_regexH1 enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange r = result.range;
            NSRange linebreak = [str rangeOfString:@"\n" options:0 range:result.range locale:nil];
            if (linebreak.location != NSNotFound) {
                [text yy_setColor:_headerTextColor range:NSMakeRange(r.location, linebreak.location - r.location)];
                [text yy_setFont:_headerFonts[0] range:NSMakeRange(r.location, linebreak.location - r.location + 1)];
                [text yy_setColor:_controlTextColor range:NSMakeRange(linebreak.location + linebreak.length, r.location + r.length - linebreak.location - linebreak.length)];
            }
        }];
        
        [_regexH2 enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange r = result.range;
            NSRange linebreak = [str rangeOfString:@"\n" options:0 range:result.range locale:nil];
            if (linebreak.location != NSNotFound) {
                [text yy_setColor:_headerTextColor range:NSMakeRange(r.location, linebreak.location - r.location)];
                [text yy_setFont:_headerFonts[1] range:NSMakeRange(r.location, linebreak.location - r.location + 1)];
                [text yy_setColor:_controlTextColor range:NSMakeRange(linebreak.location + linebreak.length, r.location + r.length - linebreak.location - linebreak.length)];
            }
        }];
        
        [_regexBreakline enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            [text yy_setColor:_breakLineColor range:result.range];
        }];
        
        [_regexEmphasis enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange r = result.range;
            [text yy_setColor:_emphasisTextColor range:r];
            [text yy_setFont:_textFont range:NSMakeRange(r.location + 1, r.length - 2)];
        }];
        
        [_regexStrong enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location, 2)];
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location + r.length - 2, 2)];
            [text yy_setColor:_strongColor range:NSMakeRange(r.location + 2, r.length - 4)];
            [text yy_setFont:_textFont range:NSMakeRange(r.location + 2, r.length - 4)];
        }];
        
        [_regexStrongEmphasis enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location, 3)];
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location + r.length - 3, 3)];
            [text yy_setFont:_textFont range:NSMakeRange(r.location + 3, r.length - 6)];
            [text yy_setColor:_strongEmphasisColor range:NSMakeRange(r.location + 3, r.length - 6)];
        }];
        
        [_regexUnderline enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_controlTextColor range:r];
            [text yy_setTextUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@1 color:_underlineColor] range:NSMakeRange(r.location + 2, r.length - 4)];
            [text yy_setColor:_underlineColor range:NSMakeRange(r.location + 2, r.length - 4)];
        }];
        
        [_regexStrikethrough enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location, 2)];
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location + r.length - 2, 2)];
            [text yy_setTextStrikethrough:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@1 color:_strikeThroughColor] range:NSMakeRange(r.location + 2, r.length - 4)];
            
        }];
        
        //``
        [_regexInlineCode enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            NSUInteger len = [self lenghOfBeginChar:'`' inString:str withRange:r];
            [text yy_setColor:_inlineCodeColor range:NSMakeRange(r.location, len)];
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location + r.length - len, len)];
            [text yy_setColor:_inlineCodeColor range:NSMakeRange(r.location + len, r.length - 2 * len)];
            [text yy_setColor:_controlTextColor range:NSMakeRange(r.location, 1)];
            [text yy_setTextBorder:_border.copy range:r];
        }];
        
        
        [_regexCodeLines enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSRange r = result.range;
            [text yy_setColor:_codeBlockColor range:r];
            [text yy_setFont:_textFont range:r];
        }];
        
        [_regexLink enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            NSString *linkStr = [str substringWithRange:r];
            NSRange nameRange = [self rangeOfBeginChar:'[' endChar:']' inString:linkStr];
            if ([linkStr characterAtIndex:0] == '!') {
                
                [text yy_setColor:_imageLinkTextColor range:r];
                [text yy_setColor:_linkNameTextColor range:NSMakeRange(nameRange.location + r.location, nameRange.length)];
            }
            else {
                [text yy_setColor:_linkTextColor range:r];
                [text yy_setColor:_linkNameTextColor range:NSMakeRange(nameRange.location + r.location, nameRange.length)];
            }
           
        }];
        
        [_regexLinkRefer enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_controlTextColor range:r];
            NSString *linkStr = [str substringWithRange:r];
            NSRange nameRange = [self rangeOfBeginChar:'[' endChar:']' inString:linkStr];
            [text yy_setColor:_linkReferNameColor range:NSMakeRange(nameRange.location + r.location, nameRange.length)];
        }];
        
        [_regexList enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            [text yy_setColor:_listColor range:r];
        }];
        
        [_regexReference enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange r = result.range;
            
            [text yy_setColor:_referenceColor range:r];
            [text yy_setColor:_controlTextColor range:NSMakeRange(0, 1)];
        }];
        
        [_regexCodeBlock enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange r = result.range;
            NSRange firstLineRange = [_regexNotEmptyLine rangeOfFirstMatchInString:str options:kNilOptions range:r];
            NSUInteger lenStart = (firstLineRange.location != NSNotFound) ? firstLineRange.location - r.location : 0;
            NSUInteger lenEnd = [self lenghOfEndWhiteInString:str withRange:r];
            if (lenStart + lenEnd < r.length) {
                NSRange codeR = NSMakeRange(r.location + lenStart, r.length - lenStart - lenEnd);
                [text yy_setColor:_codeBlockColor range:codeR];
                [text yy_setFont:_textFont range:codeR];
                YYTextBorder *border = [YYTextBorder new];
                border.lineStyle = YYTextLineStyleSingle;
                border.fillColor = [UIColor colorWithWhite:0.184 alpha:0.090];
                border.strokeColor = [UIColor colorWithWhite:0.200 alpha:0.300];
                border.insets = UIEdgeInsetsMake(-1, 0, -1, 0);
                border.cornerRadius = 3;
                border.strokeWidth = YYTextCGFloatFromPixel(2);
                [text yy_setTextBlockBorder:_border.copy range:codeR];
            }
        }];
        
    

    return YES;
    
}


- (NSUInteger)lenghOfBeginWhiteInString:(NSString *)str withRange:(NSRange)range{
    for (NSUInteger i = 0; i < range.length; i++) {
        unichar c = [str characterAtIndex:i + range.location];
        if (c != ' ' && c != '\t' && c != '\n') return i;
    }
    return str.length;
}

- (NSUInteger)lenghOfEndWhiteInString:(NSString *)str withRange:(NSRange)range{
    for (NSInteger i = range.length - 1; i >= 0; i--) {
        unichar c = [str characterAtIndex:i + range.location];
        if (c != ' ' && c != '\t' && c != '\n') return range.length - i;
    }
    return str.length;
}

- (NSUInteger)lenghOfBeginChar:(unichar)c inString:(NSString *)str withRange:(NSRange)range{
    for (NSUInteger i = 0; i < range.length; i++) {
        if ([str characterAtIndex:i + range.location] != c) return i;
    }
    return str.length;
}


- (NSRange )rangeOfBeginChar:(unichar)begin endChar:(unichar)end inString:(NSString *)string {
    
    NSUInteger locate = 0, length = 0;
    BOOL hadFoundLocate = NO;
    for (NSUInteger i = 0; i<string.length; i++) {
        if ([string characterAtIndex:i] == begin) {
            locate = i + 1;
            length++;
            i++;
            hadFoundLocate = YES;
        }else if ([string characterAtIndex:i] != end && [string characterAtIndex:i] != begin && hadFoundLocate) {
            length ++;
        }else if([string characterAtIndex:i] == end){
            break;
        }
    }
    
    
    return NSMakeRange(locate, length);
    
    
}

@end
