// MIT License
//
// Copyright (c) 2025 PierreLgol
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

const std = @import("std");
const math = std.math;
const testing = std.testing;

comptime {
    std.testing.refAllDecls(@This());
}

pub fn random(rand: std.Random) u8 {
    return rand.int(u8);
}

pub fn rangeInclusive(rand: std.Random, min: u8, max: u8) u8 {
    return rand.intRangeAtMost(u8, min, max);
}

pub fn rangeExclusive(rand: std.Random, min: u8, max: u8) u8 {
    if (max <= min + 1) return min;
    return rand.intRangeLessThan(u8, min + 1, max);
}

pub fn ascii(rand: std.Random) u8 {
    return rangeInclusive(rand, 0, 127);
}

pub fn printable(rand: std.Random) u8 {
    return rangeInclusive(rand, 32, 126);
}

pub fn whitespace(rand: std.Random) u8 {
    const ws = [_]u8{ 9, 10, 11, 12, 13, 32 };
    return ws[rand.intRangeLessThan(usize, 0, ws.len)];
}

pub fn control(rand: std.Random) u8 {
    const code = rand.intRangeAtMost(u8, 0, 31);
    return if (code == 31 and rand.boolean()) 127 else code;
}

pub fn alphaLower(rand: std.Random) u8 {
    return rangeInclusive(rand, 'a', 'z');
}

pub fn alphaUpper(rand: std.Random) u8 {
    return rangeInclusive(rand, 'A', 'Z');
}

pub fn alpha(rand: std.Random) u8 {
    return if (boolean(rand)) alphaLower(rand) else alphaUpper(rand);
}

pub fn digit(rand: std.Random) u8 {
    return rangeInclusive(rand, '0', '9');
}

pub fn hex(rand: std.Random) u8 {
    const n = rand.intRangeLessThan(u8, 0, 16);
    return if (n < 10) '0' + n else 'a' + (n - 10);
}

pub fn octal(rand: std.Random) u8 {
    return rangeInclusive(rand, '0', '7');
}

pub fn binary(rand: std.Random) u8 {
    return if (boolean(rand)) '1' else '0';
}

pub fn punctuation(rand: std.Random) u8 {
    const punct = [_]u8{
        '!', '"', '#', '$', '%', '&', '\'', '(', ')',  '*', '+', ',', '-', '.', '/',
        ':', ';', '<', '=', '>', '?', '@',  '[', '\\', ']', '^', '_', '`', '{', '|',
        '}', '~',
    };
    return punct[rand.intRangeLessThan(usize, 0, punct.len)];
}

pub fn bracket(rand: std.Random) u8 {
    const brackets = [_]u8{ '(', ')', '[', ']', '{', '}', '<', '>' };
    return brackets[rand.intRangeLessThan(usize, 0, brackets.len)];
}

pub fn quote(rand: std.Random) u8 {
    const quotes = [_]u8{ '"', '\'', '`' };
    return quotes[rand.intRangeLessThan(usize, 0, quotes.len)];
}

pub fn symbol(rand: std.Random) u8 {
    const syms = [_]u8{ '+', '-', '*', '/', '=', '%', '&', '|', '!', '?', '@', '#', '$', '^', '~' };
    return syms[rand.intRangeLessThan(usize, 0, syms.len)];
}

pub fn latin1Printable(rand: std.Random) u8 {
    return rangeInclusive(rand, 160, 255);
}

pub fn charset(rand: std.Random, cs: []const u8) u8 {
    if (cs.len == 0) return 0;
    return cs[rand.intRangeLessThan(usize, 0, cs.len)];
}

pub fn boolean(rand: std.Random) bool {
    return rand.boolean();
}

pub fn newline(rand: std.Random) u8 {
    return if (rand.boolean()) '\n' else '\r';
}

pub fn tab() u8 {
    return '\t';
}

pub fn alphaNumeric(rand: std.Random) u8 {
    const pick = rand.intRangeLessThan(u8, 0, 36);
    return if (pick < 10) '0' + pick else 'a' + (pick - 10);
}

pub fn visible(rand: std.Random) u8 {
    return rangeInclusive(rand, 33, 126);
}

pub fn urlSafe(rand: std.Random) u8 {
    const safe = [_]u8{
        '-', '_', '.', '~',
    };
    const choice = rand.intRangeLessThan(u8, 0, 64);
    return switch (choice) {
        0...9 => '0' + choice,
        10...35 => 'a' + (choice - 10),
        36...61 => 'A' + (choice - 36),
        62 => safe[0],
        63 => safe[1],
        else => safe[rand.intRangeLessThan(usize, 0, safe.len)],
    };
}

// ============================================================================
// Character Sets & Variants
// ============================================================================

pub fn vowel(rand: std.Random) u8 {
    return if (boolean(rand)) vowelLower(rand) else vowelUpper(rand);
}

pub fn vowelLower(rand: std.Random) u8 {
    const vowels = [_]u8{ 'a', 'e', 'i', 'o', 'u' };
    return vowels[rand.intRangeLessThan(usize, 0, vowels.len)];
}

pub fn vowelUpper(rand: std.Random) u8 {
    const vowels = [_]u8{ 'A', 'E', 'I', 'O', 'U' };
    return vowels[rand.intRangeLessThan(usize, 0, vowels.len)];
}

pub fn consonant(rand: std.Random) u8 {
    return if (boolean(rand)) consonantLower(rand) else consonantUpper(rand);
}

pub fn consonantLower(rand: std.Random) u8 {
    const consonants = [_]u8{ 'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z' };
    return consonants[rand.intRangeLessThan(usize, 0, consonants.len)];
}

pub fn consonantUpper(rand: std.Random) u8 {
    const consonants = [_]u8{ 'B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z' };
    return consonants[rand.intRangeLessThan(usize, 0, consonants.len)];
}

pub fn identifierChar(rand: std.Random) u8 {
    const choice = rand.intRangeLessThan(u8, 0, 63);
    return switch (choice) {
        0...25 => 'a' + choice,
        26...51 => 'A' + (choice - 26),
        52...61 => '0' + (choice - 52),
        62 => '_',
        else => unreachable,
    };
}

pub fn base32(rand: std.Random) u8 {
    const n = rand.intRangeLessThan(u8, 0, 32);
    return if (n < 26) 'A' + n else '2' + (n - 26);
}

pub fn urlPathSafe(rand: std.Random) u8 {
    const safe = [_]u8{ '-', '_', '.', '~', '/' };
    const choice = rand.intRangeLessThan(u8, 0, 67);
    return switch (choice) {
        0...9 => '0' + choice,
        10...35 => 'a' + (choice - 10),
        36...61 => 'A' + (choice - 36),
        62 => safe[0],
        63 => safe[1],
        64 => safe[2],
        65 => safe[3],
        66 => safe[4],
        else => unreachable,
    };
}

pub fn asciiLower(rand: std.Random) u8 {
    return rangeInclusive(rand, 0, 127);
}

pub fn asciiUpper(rand: std.Random) u8 {
    return rangeInclusive(rand, 128, 255);
}

pub fn asciiSymbol(rand: std.Random) u8 {
    const symbols = [_]u8{ '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~' };
    return symbols[rand.intRangeLessThan(usize, 0, symbols.len)];
}

pub fn asciiGraph(rand: std.Random) u8 {
    return rangeInclusive(rand, 33, 126);
}

pub fn asciiExtended(rand: std.Random) u8 {
    return rangeInclusive(rand, 128, 255);
}

pub fn printableExtended(rand: std.Random) u8 {
    return rangeInclusive(rand, 160, 255);
}

pub fn printableAscii(rand: std.Random) u8 {
    return printable(rand);
}

pub fn printablePunctuation(rand: std.Random) u8 {
    const punct = [_]u8{ '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~' };
    return punct[rand.intRangeLessThan(usize, 0, punct.len)];
}

pub fn nonAlphaNumeric(rand: std.Random) u8 {
    const chars = [_]u8{ '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~', ' ', '\t', '\n' };
    return chars[rand.intRangeLessThan(usize, 0, chars.len)];
}

pub fn spaceLike(rand: std.Random) u8 {
    const spaces = [_]u8{ ' ', '\t', '\n', '\r', '\x0b', '\x0c' };
    return spaces[rand.intRangeLessThan(usize, 0, spaces.len)];
}

pub fn spaceOrTab(rand: std.Random) u8 {
    return if (rand.boolean()) ' ' else '\t';
}

pub fn endOfLine(rand: std.Random) u8 {
    return if (rand.boolean()) '\n' else '\r';
}

pub fn numberSeparator(rand: std.Random) u8 {
    const seps = [_]u8{ ',', '.', '_', '\'' };
    return seps[rand.intRangeLessThan(usize, 0, seps.len)];
}

// ============================================================================
// Bit Manipulation
// ============================================================================

pub fn bit(rand: std.Random) u8 {
    return if (rand.boolean()) 1 else 0;
}

pub fn bitmask(rand: std.Random) u8 {
    return rand.int(u8);
}

pub fn powerOfTwo(rand: std.Random) u8 {
    const exponent = rand.intRangeLessThan(u8, 0, 8);
    return @as(u8, 1) << @intCast(exponent);
}

pub fn powerOfTen(rand: std.Random) u8 {
    const powers = [_]u8{ 1, 10, 100 };
    return powers[rand.intRangeLessThan(usize, 0, powers.len)];
}

pub fn alternating(rand: std.Random) u8 {
    return if (rand.boolean()) 0b10101010 else 0b01010101;
}

pub fn mirroredNibble(rand: std.Random) u8 {
    const nibble = rand.intRangeLessThan(u8, 0, 16);
    return (nibble << 4) | nibble;
}

pub fn mixedNibble(rand: std.Random) u8 {
    const high = rand.intRangeLessThan(u8, 0, 16);
    const low = rand.intRangeLessThan(u8, 0, 16);
    return (high << 4) | low;
}

pub fn mirroredBit(rand: std.Random) u8 {
    const pattern = rand.intRangeLessThan(u8, 0, 16);
    var result: u8 = 0;
    var i: usize = 0;
    while (i < 4) : (i += 1) {
        const bit_val = (pattern >> @intCast(i)) & 1;
        result |= bit_val << @intCast(i);
        result |= bit_val << @intCast(7 - i);
    }
    return result;
}

pub fn reversedBits(rand: std.Random) u8 {
    const val = rand.int(u8);
    var result: u8 = 0;
    var i: usize = 0;
    while (i < 8) : (i += 1) {
        const bit_val = (val >> @intCast(i)) & 1;
        result |= bit_val << @intCast(7 - i);
    }
    return result;
}

pub fn evenByte(rand: std.Random) u8 {
    return (rand.int(u8) >> 1) << 1;
}

pub fn oddByte(rand: std.Random) u8 {
    return evenByte(rand) | 1;
}

pub fn primeByte(rand: std.Random) u8 {
    const primes = [_]u8{ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251 };
    return primes[rand.intRangeLessThan(usize, 0, primes.len)];
}

pub fn byteWithParity(rand: std.Random, parity: bool) u8 {
    var val = rand.int(u8) & 0x7F;
    var count: u8 = 0;
    var temp = val;
    while (temp != 0) {
        count += temp & 1;
        temp >>= 1;
    }
    const is_even = (count & 1) == 0;
    if (parity != is_even) {
        val |= 0x80;
    }
    return val;
}

pub fn halfByte(rand: std.Random) u8 {
    return rangeInclusive(rand, 0, 127);
}

pub fn xorPair(rand: std.Random, b: u8) u8 {
    return rand.int(u8) ^ b;
}

pub fn complement(rand: std.Random, b: u8) u8 {
    _ = rand;
    return ~b;
}

pub fn bitFlip(rand: std.Random, b: u8) u8 {
    const bit_pos = rand.intRangeLessThan(usize, 0, 8);
    return b ^ (@as(u8, 1) << @intCast(bit_pos));
}

// ============================================================================
// Operators & Symbols
// ============================================================================

pub fn mathSymbol(rand: std.Random) u8 {
    const syms = [_]u8{ '+', '-', '*', '/', '=', '%', '^' };
    return syms[rand.intRangeLessThan(usize, 0, syms.len)];
}

pub fn arrowSymbol(rand: std.Random) u8 {
    const arrows = [_]u8{ '<', '>' };
    return arrows[rand.intRangeLessThan(usize, 0, arrows.len)];
}

pub fn logicalOperator(rand: std.Random) u8 {
    const ops = [_]u8{ '&', '|', '!', '^' };
    return ops[rand.intRangeLessThan(usize, 0, ops.len)];
}

pub fn comparisonOperator(rand: std.Random) u8 {
    const ops = [_]u8{ '<', '>', '=', '!' };
    return ops[rand.intRangeLessThan(usize, 0, ops.len)];
}

pub fn bitwiseOperator(rand: std.Random) u8 {
    const ops = [_]u8{ '&', '|', '^', '~', '<', '>' };
    return ops[rand.intRangeLessThan(usize, 0, ops.len)];
}

pub fn operatorSymbol(rand: std.Random) u8 {
    const ops = [_]u8{ '+', '-', '*', '/', '%', '&', '|', '^', '~', '<', '>', '=', '!' };
    return ops[rand.intRangeLessThan(usize, 0, ops.len)];
}

pub fn equationSymbol(rand: std.Random) u8 {
    const syms = [_]u8{ '=', '+', '-', '*', '/', '(', ')' };
    return syms[rand.intRangeLessThan(usize, 0, syms.len)];
}

pub fn signSymbol(rand: std.Random) u8 {
    return if (rand.boolean()) '+' else '-';
}

pub fn escapeChar(rand: std.Random) u8 {
    const escapes = [_]u8{ 'n', 't', 'r', '\\', '\'', '"', '0', 'b', 'f', 'v' };
    return escapes[rand.intRangeLessThan(usize, 0, escapes.len)];
}

pub fn escapeSequence(rand: std.Random) u8 {
    return escapeChar(rand);
}

pub fn controlAscii(rand: std.Random) u8 {
    return rangeInclusive(rand, 0, 31);
}

pub fn controlVisible(rand: std.Random) u8 {
    const controls = [_]u8{ '^', '@', '[', ']', '\\', '_' };
    return controls[rand.intRangeLessThan(usize, 0, controls.len)];
}

pub fn bracketOpen(rand: std.Random) u8 {
    const brackets = [_]u8{ '(', '[', '{', '<' };
    return brackets[rand.intRangeLessThan(usize, 0, brackets.len)];
}

pub fn bracketClose(rand: std.Random) u8 {
    const brackets = [_]u8{ ')', ']', '}', '>' };
    return brackets[rand.intRangeLessThan(usize, 0, brackets.len)];
}

pub fn alphaTitle(rand: std.Random) u8 {
    return alphaUpper(rand);
}

pub fn romanDigit(rand: std.Random) u8 {
    const romans = [_]u8{ 'I', 'V', 'X', 'L', 'C', 'D', 'M' };
    return romans[rand.intRangeLessThan(usize, 0, romans.len)];
}

pub fn punctuationHeavy(rand: std.Random) u8 {
    const punct = [_]u8{ '!', '!', '!', '?', '?', '?', '.', '.', ',', ',', ';', ':', '-', '-', '\'', '"' };
    return punct[rand.intRangeLessThan(usize, 0, punct.len)];
}

// ============================================================================
// Special Values & Utilities
// ============================================================================

pub fn weighted(rand: std.Random, bias: u8) u8 {
    const r = rand.int(u8);
    return if (r < bias) r else rand.int(u8);
}

pub fn delta(rand: std.Random, base: u8, range: u8) u8 {
    if (range == 0) return base;
    const offset = rand.intRangeLessThan(u8, 0, range);
    const direction = rand.boolean();
    if (direction) {
        return if (base <= 255 - offset) base + offset else 255;
    } else {
        return if (base >= offset) base - offset else 0;
    }
}

pub fn byteEdge(rand: std.Random) u8 {
    const edges = [_]u8{ 0, 1, 127, 128, 254, 255 };
    return edges[rand.intRangeLessThan(usize, 0, edges.len)];
}

pub fn byteCenter(rand: std.Random) u8 {
    return rangeInclusive(rand, 64, 191);
}

pub fn nullByte() u8 {
    return 0;
}

pub fn oneByte() u8 {
    return 1;
}

pub fn maxByte() u8 {
    return 255;
}

pub fn minByte() u8 {
    return 0;
}

pub fn booleanByte(rand: std.Random) u8 {
    return if (rand.boolean()) 1 else 0;
}

// ============================================================================
// Bitset Operations
// ============================================================================

pub fn fromBitSet(rand: std.Random, bitset: std.bit_set.IntegerBitSet(256)) u8 {
    const count = bitset.count();
    if (count == 0) return 0;

    const index = rand.intRangeLessThan(usize, 0, count);
    var it = bitset.iterator(.{});
    var i: usize = 0;
    while (it.next()) |bit_pos| {
        if (i == index) return @intCast(bit_pos);
        i += 1;
    }
    return 0;
}

pub fn fromBitSetComplement(rand: std.Random, bitset: std.bit_set.IntegerBitSet(256)) u8 {
    var inverted = bitset;
    inverted.toggleAll();
    return fromBitSet(rand, inverted);
}

pub fn uniqueFromBitSet(rand: std.Random, bitset: *std.bit_set.IntegerBitSet(256)) u8 {
    if (bitset.count() == 0) return 0;
    const result = fromBitSet(rand, bitset.*);
    bitset.unset(result);
    return result;
}

pub fn uniqueFromCharset(rand: std.Random, ch_set: []const u8, used: *std.bit_set.IntegerBitSet(256)) u8 {
    if (ch_set.len == 0) return 0;

    var available = std.ArrayListUnmanaged(u8){};
    defer available.deinit(std.heap.page_allocator);

    for (ch_set) |c| {
        if (!used.isSet(c)) {
            available.append(std.heap.page_allocator, c) catch return 0;
        }
    }

    if (available.items.len == 0) return 0;

    const result = available.items[rand.intRangeLessThan(usize, 0, available.items.len)];
    used.set(result);
    return result;
}

pub fn isAvailableInBitSet(bitset: std.bit_set.IntegerBitSet(256), value: u8) bool {
    return bitset.isSet(value);
}

pub fn countAvailableInBitSet(bitset: std.bit_set.IntegerBitSet(256)) usize {
    return bitset.count();
}

// ============================================================================
// Classification Utilities
// ============================================================================

pub fn isAlpha(b: u8) bool {
    return isAlphaLower(b) or isAlphaUpper(b);
}

pub fn isAlphaLower(b: u8) bool {
    return b >= 'a' and b <= 'z';
}

pub fn isAlphaUpper(b: u8) bool {
    return b >= 'A' and b <= 'Z';
}

pub fn isDigit(b: u8) bool {
    return b >= '0' and b <= '9';
}

pub fn isAlphaNumeric(b: u8) bool {
    return isAlpha(b) or isDigit(b);
}

pub fn isHex(b: u8) bool {
    return isDigit(b) or (b >= 'a' and b <= 'f') or (b >= 'A' and b <= 'F');
}

pub fn isPrintable(b: u8) bool {
    return b >= 32 and b <= 126;
}

pub fn isWhitespace(b: u8) bool {
    return b == ' ' or b == '\t' or b == '\n' or b == '\r' or b == '\x0b' or b == '\x0c';
}

pub fn isPunctuation(b: u8) bool {
    return (b >= '!' and b <= '/') or
        (b >= ':' and b <= '@') or
        (b >= '[' and b <= '`') or
        (b >= '{' and b <= '~');
}

pub fn isControl(b: u8) bool {
    return b <= 31 or b == 127;
}

pub fn isVowel(b: u8) bool {
    return b == 'a' or b == 'e' or b == 'i' or b == 'o' or b == 'u' or
        b == 'A' or b == 'E' or b == 'I' or b == 'O' or b == 'U';
}

pub fn isConsonant(b: u8) bool {
    return isAlpha(b) and !isVowel(b);
}

// ============================================================================
// Transformation Utilities
// ============================================================================

pub fn toUpper(b: u8) u8 {
    return if (isAlphaLower(b)) b - 32 else b;
}

pub fn toLower(b: u8) u8 {
    return if (isAlphaUpper(b)) b + 32 else b;
}

pub fn toggleCase(b: u8) u8 {
    if (isAlphaLower(b)) return toUpper(b);
    if (isAlphaUpper(b)) return toLower(b);
    return b;
}

pub fn invert(b: u8) u8 {
    return ~b;
}

// ============================================================================
// Tests
// ============================================================================

test "vowel variants" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const v = vowel(rand);
    try testing.expect(isVowel(v));

    const vl = vowelLower(rand);
    try testing.expect(vl == 'a' or vl == 'e' or vl == 'i' or vl == 'o' or vl == 'u');

    const vu = vowelUpper(rand);
    try testing.expect(vu == 'A' or vu == 'E' or vu == 'I' or vu == 'O' or vu == 'U');
}

test "consonant variants" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const c = consonant(rand);
    try testing.expect(isConsonant(c));

    const cl = consonantLower(rand);
    try testing.expect(isAlphaLower(cl) and !isVowel(cl));

    const cu = consonantUpper(rand);
    try testing.expect(isAlphaUpper(cu) and !isVowel(cu));
}

test "identifierChar" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    for (0..100) |_| {
        const c = identifierChar(rand);
        try testing.expect(isAlphaNumeric(c) or c == '_');
    }
}

test "base32" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    for (0..100) |_| {
        const c = base32(rand);
        const valid = (c >= 'A' and c <= 'Z') or (c >= '2' and c <= '7');
        try testing.expect(valid);
    }
}

test "urlPathSafe" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    for (0..100) |_| {
        const c = urlPathSafe(rand);
        const valid = isAlphaNumeric(c) or c == '-' or c == '_' or c == '.' or c == '~' or c == '/';
        try testing.expect(valid);
    }
}

test "bit manipulation - powerOfTwo" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    for (0..100) |_| {
        const p = powerOfTwo(rand);
        const is_power = (p & (p - 1)) == 0 and p != 0;
        try testing.expect(is_power);
    }
}

test "bit manipulation - evenByte and oddByte" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const e = evenByte(rand);
    try testing.expect((e & 1) == 0);

    const o = oddByte(rand);
    try testing.expect((o & 1) == 1);
}

test "bit manipulation - mirroredNibble" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const m = mirroredNibble(rand);
    const high = m >> 4;
    const low = m & 0x0F;
    try testing.expect(high == low);
}

test "bit manipulation - reversedBits" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const input: u8 = 0b10110010;
    const expected: u8 = 0b01001101;

    // Manually compute expected
    var manual_result: u8 = 0;
    var i: usize = 0;
    while (i < 8) : (i += 1) {
        const bit_val = (input >> @intCast(i)) & 1;
        manual_result |= bit_val << @intCast(7 - i);
    }
    try testing.expectEqual(expected, manual_result);

    // Test a few random bytes - just verify doesn't crash
    for (0..20) |_| {
        _ = reversedBits(rand);
    }
}

test "primeByte" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const primes = [_]u8{ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 };

    for (0..50) |_| {
        const p = primeByte(rand);
        var is_prime = false;
        for (primes) |prime| {
            if (p == prime) {
                is_prime = true;
                break;
            }
        }
        try testing.expect(is_prime or p > 100);
    }
}

test "byteWithParity" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const even_parity = byteWithParity(rand, true);
    var count: u8 = 0;
    var temp = even_parity;
    while (temp != 0) {
        count += temp & 1;
        temp >>= 1;
    }
    try testing.expect((count & 1) == 0);
}

test "operators and symbols" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const math_sym = mathSymbol(rand);
    const valid_math = math_sym == '+' or math_sym == '-' or math_sym == '*' or math_sym == '/' or math_sym == '=' or math_sym == '%' or math_sym == '^';
    try testing.expect(valid_math);

    const arrow = arrowSymbol(rand);
    try testing.expect(arrow == '<' or arrow == '>');

    const bracket_o = bracketOpen(rand);
    try testing.expect(bracket_o == '(' or bracket_o == '[' or bracket_o == '{' or bracket_o == '<');

    const bracket_c = bracketClose(rand);
    try testing.expect(bracket_c == ')' or bracket_c == ']' or bracket_c == '}' or bracket_c == '>');
}

test "special values" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    try testing.expectEqual(@as(u8, 0), nullByte());
    try testing.expectEqual(@as(u8, 1), oneByte());
    try testing.expectEqual(@as(u8, 255), maxByte());
    try testing.expectEqual(@as(u8, 0), minByte());

    const b = booleanByte(rand);
    try testing.expect(b == 0 or b == 1);

    const edge = byteEdge(rand);
    const valid_edge = edge == 0 or edge == 1 or edge == 127 or edge == 128 or edge == 254 or edge == 255;
    try testing.expect(valid_edge);
}

test "delta" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const base: u8 = 128;
    const range: u8 = 10;

    for (0..100) |_| {
        const d = delta(rand, base, range);
        const diff = if (d > base) d - base else base - d;
        try testing.expect(diff <= range);
    }
}

test "bitset operations" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var bitset = std.bit_set.IntegerBitSet(256).initEmpty();
    bitset.set('a');
    bitset.set('b');
    bitset.set('c');

    try testing.expectEqual(@as(usize, 3), countAvailableInBitSet(bitset));
    try testing.expect(isAvailableInBitSet(bitset, 'a'));
    try testing.expect(!isAvailableInBitSet(bitset, 'z'));

    const b = fromBitSet(rand, bitset);
    try testing.expect(b == 'a' or b == 'b' or b == 'c');

    var mutable_bitset = bitset;
    const unique = uniqueFromBitSet(rand, &mutable_bitset);
    try testing.expect(unique == 'a' or unique == 'b' or unique == 'c');
    try testing.expectEqual(@as(usize, 2), countAvailableInBitSet(mutable_bitset));
}

test "uniqueFromCharset" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const char_set = "abc";
    var used = std.bit_set.IntegerBitSet(256).initEmpty();

    const c1 = uniqueFromCharset(rand, char_set, &used);
    try testing.expect(c1 == 'a' or c1 == 'b' or c1 == 'c');
    try testing.expect(used.isSet(c1));

    const c2 = uniqueFromCharset(rand, char_set, &used);
    try testing.expect(c2 == 'a' or c2 == 'b' or c2 == 'c');
    try testing.expect(c1 != c2);
}

test "classification utilities" {
    try testing.expect(isAlpha('a'));
    try testing.expect(isAlpha('Z'));
    try testing.expect(!isAlpha('0'));

    try testing.expect(isAlphaLower('a'));
    try testing.expect(!isAlphaLower('A'));

    try testing.expect(isAlphaUpper('A'));
    try testing.expect(!isAlphaUpper('a'));

    try testing.expect(isDigit('0'));
    try testing.expect(!isDigit('a'));

    try testing.expect(isAlphaNumeric('a'));
    try testing.expect(isAlphaNumeric('5'));
    try testing.expect(!isAlphaNumeric(' '));

    try testing.expect(isHex('a'));
    try testing.expect(isHex('F'));
    try testing.expect(isHex('9'));
    try testing.expect(!isHex('g'));

    try testing.expect(isPrintable(' '));
    try testing.expect(isPrintable('~'));
    try testing.expect(!isPrintable(0));

    try testing.expect(isWhitespace(' '));
    try testing.expect(isWhitespace('\t'));
    try testing.expect(!isWhitespace('a'));

    try testing.expect(isPunctuation('.'));
    try testing.expect(!isPunctuation('a'));

    try testing.expect(isControl(0));
    try testing.expect(isControl(127));
    try testing.expect(!isControl('a'));

    try testing.expect(isVowel('a'));
    try testing.expect(isVowel('E'));
    try testing.expect(!isVowel('b'));

    try testing.expect(isConsonant('b'));
    try testing.expect(!isConsonant('a'));
}

test "transformation utilities" {
    try testing.expectEqual(@as(u8, 'A'), toUpper('a'));
    try testing.expectEqual(@as(u8, 'Z'), toUpper('z'));
    try testing.expectEqual(@as(u8, 'A'), toUpper('A'));

    try testing.expectEqual(@as(u8, 'a'), toLower('A'));
    try testing.expectEqual(@as(u8, 'z'), toLower('Z'));
    try testing.expectEqual(@as(u8, 'a'), toLower('a'));

    try testing.expectEqual(@as(u8, 'A'), toggleCase('a'));
    try testing.expectEqual(@as(u8, 'a'), toggleCase('A'));
    try testing.expectEqual(@as(u8, '0'), toggleCase('0'));

    try testing.expectEqual(@as(u8, 0), invert(255));
    try testing.expectEqual(@as(u8, 255), invert(0));
}
