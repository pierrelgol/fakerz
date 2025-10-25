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
const byte = @import("byte.zig");
const testing = std.testing;

comptime {
    std.testing.refAllDecls(@This());
}

/// Enumeration of all available byte generation strategies
pub const Kind = enum {
    random,
    ascii,
    printable,
    visible,
    alphaLower,
    alphaUpper,
    alpha,
    digit,
    hex,
    octal,
    binary,
    alphaNumeric,
    whitespace,
    punctuation,
    control,
    urlSafe,
    latin1Printable,
    bracket,
    quote,
    symbol,
    vowel,
    vowelLower,
    vowelUpper,
    consonant,
    consonantLower,
    consonantUpper,
    identifierChar,
    base32,
    urlPathSafe,
    asciiLower,
    asciiUpper,
    asciiSymbol,
    asciiGraph,
    asciiExtended,
    printableExtended,
    printablePunctuation,
    nonAlphaNumeric,
    spaceLike,
    spaceOrTab,
    endOfLine,
    numberSeparator,
    bit,
    bitmask,
    powerOfTwo,
    powerOfTen,
    alternating,
    mirroredNibble,
    mixedNibble,
    mirroredBit,
    reversedBits,
    evenByte,
    oddByte,
    primeByte,
    mathSymbol,
    arrowSymbol,
    logicalOperator,
    comparisonOperator,
    bitwiseOperator,
    operatorSymbol,
    equationSymbol,
    signSymbol,
    escapeChar,
    controlAscii,
    controlVisible,
    bracketOpen,
    bracketClose,
    alphaTitle,
    romanDigit,
    punctuationHeavy,
    byteEdge,
    byteCenter,
    nullByte,
    oneByte,
    maxByte,
    minByte,
    booleanByte,
};

/// Generate a single byte using the specified kind
pub fn generateByte(rand: std.Random, kind: Kind) u8 {
    return switch (kind) {
        .random => byte.random(rand),
        .ascii => byte.ascii(rand),
        .printable => byte.printable(rand),
        .visible => byte.visible(rand),
        .alphaLower => byte.alphaLower(rand),
        .alphaUpper => byte.alphaUpper(rand),
        .alpha => byte.alpha(rand),
        .digit => byte.digit(rand),
        .hex => byte.hex(rand),
        .octal => byte.octal(rand),
        .binary => byte.binary(rand),
        .alphaNumeric => byte.alphaNumeric(rand),
        .whitespace => byte.whitespace(rand),
        .punctuation => byte.punctuation(rand),
        .control => byte.control(rand),
        .urlSafe => byte.urlSafe(rand),
        .latin1Printable => byte.latin1Printable(rand),
        .bracket => byte.bracket(rand),
        .quote => byte.quote(rand),
        .symbol => byte.symbol(rand),
        .vowel => byte.vowel(rand),
        .vowelLower => byte.vowelLower(rand),
        .vowelUpper => byte.vowelUpper(rand),
        .consonant => byte.consonant(rand),
        .consonantLower => byte.consonantLower(rand),
        .consonantUpper => byte.consonantUpper(rand),
        .identifierChar => byte.identifierChar(rand),
        .base32 => byte.base32(rand),
        .urlPathSafe => byte.urlPathSafe(rand),
        .asciiLower => byte.asciiLower(rand),
        .asciiUpper => byte.asciiUpper(rand),
        .asciiSymbol => byte.asciiSymbol(rand),
        .asciiGraph => byte.asciiGraph(rand),
        .asciiExtended => byte.asciiExtended(rand),
        .printableExtended => byte.printableExtended(rand),
        .printablePunctuation => byte.printablePunctuation(rand),
        .nonAlphaNumeric => byte.nonAlphaNumeric(rand),
        .spaceLike => byte.spaceLike(rand),
        .spaceOrTab => byte.spaceOrTab(rand),
        .endOfLine => byte.endOfLine(rand),
        .numberSeparator => byte.numberSeparator(rand),
        .bit => byte.bit(rand),
        .bitmask => byte.bitmask(rand),
        .powerOfTwo => byte.powerOfTwo(rand),
        .powerOfTen => byte.powerOfTen(rand),
        .alternating => byte.alternating(rand),
        .mirroredNibble => byte.mirroredNibble(rand),
        .mixedNibble => byte.mixedNibble(rand),
        .mirroredBit => byte.mirroredBit(rand),
        .reversedBits => byte.reversedBits(rand),
        .evenByte => byte.evenByte(rand),
        .oddByte => byte.oddByte(rand),
        .primeByte => byte.primeByte(rand),
        .mathSymbol => byte.mathSymbol(rand),
        .arrowSymbol => byte.arrowSymbol(rand),
        .logicalOperator => byte.logicalOperator(rand),
        .comparisonOperator => byte.comparisonOperator(rand),
        .bitwiseOperator => byte.bitwiseOperator(rand),
        .operatorSymbol => byte.operatorSymbol(rand),
        .equationSymbol => byte.equationSymbol(rand),
        .signSymbol => byte.signSymbol(rand),
        .escapeChar => byte.escapeChar(rand),
        .controlAscii => byte.controlAscii(rand),
        .controlVisible => byte.controlVisible(rand),
        .bracketOpen => byte.bracketOpen(rand),
        .bracketClose => byte.bracketClose(rand),
        .alphaTitle => byte.alphaTitle(rand),
        .romanDigit => byte.romanDigit(rand),
        .punctuationHeavy => byte.punctuationHeavy(rand),
        .byteEdge => byte.byteEdge(rand),
        .byteCenter => byte.byteCenter(rand),
        .nullByte => byte.nullByte(),
        .oneByte => byte.oneByte(),
        .maxByte => byte.maxByte(),
        .minByte => byte.minByte(),
        .booleanByte => byte.booleanByte(rand),
    };
}

/// Fill buffer using the specified kind
pub fn fill(rand: std.Random, buf: []u8, kind: Kind) void {
    for (buf) |*b| {
        b.* = generateByte(rand, kind);
    }
}

/// Fill buffer with random uppercase letters (A-Z)
pub fn upper(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.alphaUpper(rand);
}

/// Fill buffer with random lowercase letters (a-z)
pub fn lower(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.alphaLower(rand);
}

/// Fill buffer with random digits (0-9)
pub fn digit(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.digit(rand);
}

/// Fill buffer with random letters (mixed case)
pub fn alpha(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.alpha(rand);
}

/// Fill buffer with random alphanumeric characters
pub fn alnum(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.alphaNumeric(rand);
}

/// Fill buffer with random hexadecimal characters (0-9a-f)
pub fn hex(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.hex(rand);
}

/// Fill buffer with random ASCII characters (0-127)
pub fn ascii(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.ascii(rand);
}

/// Fill buffer with random printable ASCII characters (32-126)
pub fn printable(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.printable(rand);
}

/// Fill buffer with random visible characters (33-126, excludes space)
pub fn visible(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.visible(rand);
}

/// Fill buffer with random URL-safe characters
pub fn urlSafe(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.urlSafe(rand);
}

/// Fill buffer with random whitespace characters
pub fn whitespace(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.whitespace(rand);
}

/// Fill buffer with random punctuation characters
pub fn punctuation(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.punctuation(rand);
}

/// Fill buffer with random binary digit characters ('0' or '1')
pub fn binary(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.binary(rand);
}

/// Fill buffer with random octal digit characters ('0'-'7')
pub fn octal(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.octal(rand);
}

/// Fill buffer with random base32 characters (A-Z, 2-7)
pub fn base32(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.base32(rand);
}

/// Fill buffer with random Latin-1 printable characters (160-255)
pub fn latin1Printable(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.latin1Printable(rand);
}

/// Fill buffer with random vowels (mixed case)
pub fn vowel(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.vowel(rand);
}

/// Fill buffer with random consonants (mixed case)
pub fn consonant(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.consonant(rand);
}

/// Fill buffer with random identifier characters (a-z, A-Z, 0-9, _)
pub fn identifier(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.identifierChar(rand);
}

/// Fill buffer with random control characters (0-31, 127)
pub fn control(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.control(rand);
}

/// Fill buffer with random non-alphanumeric characters
pub fn nonAlphaNumeric(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.nonAlphaNumeric(rand);
}

/// Fill buffer with random symbol characters
pub fn symbol(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.symbol(rand);
}

/// Fill buffer with random bracket characters
pub fn bracket(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.bracket(rand);
}

/// Fill buffer with random quote characters
pub fn quote(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.quote(rand);
}

/// Fill buffer with random space-like characters
pub fn spaceLike(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.spaceLike(rand);
}

/// Fill buffer with alternating bit pattern bytes
pub fn alternating(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.alternating(rand);
}

/// Fill buffer with random bitmask bytes
pub fn bitmask(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.bitmask(rand);
}

/// Fill buffer with mirrored nibble bytes
pub fn mirroredNibble(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.mirroredNibble(rand);
}

/// Fill buffer with mixed nibble bytes
pub fn mixedNibble(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.mixedNibble(rand);
}

/// Fill buffer with even bytes
pub fn evenByte(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.evenByte(rand);
}

/// Fill buffer with odd bytes
pub fn oddByte(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.oddByte(rand);
}

/// Fill buffer with prime number bytes
pub fn primeByte(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.primeByte(rand);
}

/// Fill buffer with bytes having specified parity
pub fn byteWithParity(rand: std.Random, buf: []u8, parity: bool) void {
    for (buf) |*b| b.* = byte.byteWithParity(rand, parity);
}

/// Fill buffer with ASCII extended characters (128-255)
pub fn asciiExtended(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.asciiExtended(rand);
}

/// Fill buffer with ASCII graphic characters (33-126)
pub fn asciiGraph(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.asciiGraph(rand);
}

/// Fill buffer with printable extended characters (160-255)
pub fn printableExtended(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.printableExtended(rand);
}

/// Fill buffer with control visible characters
pub fn controlVisible(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.controlVisible(rand);
}

/// Fill buffer with completely random bytes
pub fn randomBytes(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.random(rand);
}

/// Fill buffer with random bit values (0 or 1)
pub fn randomBits(rand: std.Random, buf: []u8) void {
    for (buf) |*b| b.* = byte.bit(rand);
}

/// Fill buffer with bytes within delta range of base value
pub fn delta(rand: std.Random, buf: []u8, base: u8, range: u8) void {
    for (buf) |*b| b.* = byte.delta(rand, base, range);
}

/// Fill buffer with weighted random bytes
pub fn weighted(rand: std.Random, buf: []u8, bias: u8) void {
    for (buf) |*b| b.* = byte.weighted(rand, bias);
}

/// Shuffle the contents of the buffer in place
pub fn shuffle(rand: std.Random, buf: []u8) void {
    if (buf.len < 2) return;
    var i: usize = buf.len;
    while (i > 1) {
        i -= 1;
        const j = rand.intRangeLessThan(usize, 0, i + 1);
        const temp = buf[i];
        buf[i] = buf[j];
        buf[j] = temp;
    }
}

/// Fill buffer with repeated value
pub fn repeat(rand: std.Random, buf: []u8, val: u8) void {
    _ = rand;
    for (buf) |*b| b.* = val;
}

/// Fill buffer by repeating pattern
pub fn pattern(rand: std.Random, buf: []u8, pat: []const u8) void {
    _ = rand;
    if (pat.len == 0) return;
    for (buf, 0..) |*b, i| {
        b.* = pat[i % pat.len];
    }
}

/// Fill buffer with bytes from charset
pub fn fromCharset(rand: std.Random, buf: []u8, cs: []const u8) void {
    for (buf) |*b| b.* = byte.charset(rand, cs);
}

/// Fill buffer with bytes in specified range (inclusive)
pub fn fillRange(rand: std.Random, buf: []u8, min: u8, max: u8) void {
    for (buf) |*b| b.* = byte.rangeInclusive(rand, min, max);
}

/// Fill buffer with constant value
pub fn fillConstant(buf: []u8, val: u8) void {
    for (buf) |*b| b.* = val;
}

/// Fill buffer with sequential values starting from start with step
pub fn fillSequence(buf: []u8, start: u8, step: u8) void {
    var current = start;
    for (buf) |*b| {
        b.* = current;
        current = if (current <= 255 - step) current + step else current;
    }
}

/// Map function over buffer in place
pub fn mapInPlace(rand: std.Random, buf: []u8, func: *const fn (std.Random, u8) u8) void {
    for (buf) |*b| {
        b.* = func(rand, b.*);
    }
}

/// Map function from source to output buffer
pub fn mapTo(rand: std.Random, out: []u8, src: []const u8, func: *const fn (std.Random, u8) u8) void {
    const len = if (out.len < src.len) out.len else src.len;
    for (out[0..len], src[0..len]) |*o, s| {
        o.* = func(rand, s);
    }
}

/// Map string transformation function
pub fn mapString(rand: std.Random, out: []u8, src: []const u8, func: *const fn (std.Random, u8) u8) void {
    mapTo(rand, out, src, func);
}

/// Combine two buffers using a mixing function
pub fn zipFill(rand: std.Random, out: []u8, a: []const u8, b: []const u8, mix_func: *const fn (std.Random, u8, u8) u8) void {
    const len = if (out.len < a.len) out.len else a.len;
    const min_len = if (len < b.len) len else b.len;
    for (out[0..min_len], a[0..min_len], b[0..min_len]) |*o, av, bv| {
        o.* = mix_func(rand, av, bv);
    }
}

/// Mix two buffers with weight
pub fn mix(rand: std.Random, out: []u8, weight: f32, a: []const u8, b: []const u8) void {
    const len = if (out.len < a.len) out.len else a.len;
    const min_len = if (len < b.len) len else b.len;
    for (out[0..min_len], a[0..min_len], b[0..min_len]) |*o, av, bv| {
        if (rand.float(f32) < weight) {
            o.* = av;
        } else {
            o.* = bv;
        }
    }
}

/// Fill 2D grid using generator function
pub fn fill2D(rand: std.Random, grid: [][]u8, func: *const fn (std.Random) u8) void {
    for (grid) |row| {
        for (row) |*cell| {
            cell.* = func(rand);
        }
    }
}

/// Map function over 2D grid with row/col indices
pub fn map2D(rand: std.Random, out: [][]u8, func: *const fn (std.Random, usize, usize) u8) void {
    for (out, 0..) |row, r| {
        for (row, 0..) |*cell, c| {
            cell.* = func(rand, r, c);
        }
    }
}

/// Fill 2D grid by repeating 2D pattern
pub fn pattern2D(rand: std.Random, grid: [][]u8, pat: [][]const u8) void {
    _ = rand;
    if (pat.len == 0) return;
    for (grid, 0..) |row, r| {
        const pat_row = pat[r % pat.len];
        if (pat_row.len == 0) continue;
        for (row, 0..) |*cell, c| {
            cell.* = pat_row[c % pat_row.len];
        }
    }
}

/// Shuffle 2D grid (flatten, shuffle, unflatten)
/// Buffer must be at least as large as the total number of cells in the grid
pub fn shuffle2D(rand: std.Random, grid: [][]u8, buffer: []u8) void {
    if (grid.len == 0) return;

    // Calculate total cells
    var count: usize = 0;
    for (grid) |row| count += row.len;
    if (count == 0) return;

    // Ensure buffer is large enough
    if (buffer.len < count) return;

    // Flatten grid into buffer
    var idx: usize = 0;
    for (grid) |row| {
        for (row) |cell| {
            buffer[idx] = cell;
            idx += 1;
        }
    }

    // Shuffle the flattened buffer
    shuffle(rand, buffer[0..count]);

    // Unflatten buffer back to grid
    idx = 0;
    for (grid) |row| {
        for (row) |*cell| {
            cell.* = buffer[idx];
            idx += 1;
        }
    }
}

/// Mirror grid horizontally
pub fn mirrorHorizontal(grid: [][]u8) void {
    for (grid) |row| {
        if (row.len < 2) continue;
        var left: usize = 0;
        var right: usize = row.len - 1;
        while (left < right) {
            const temp = row[left];
            row[left] = row[right];
            row[right] = temp;
            left += 1;
            right -= 1;
        }
    }
}

/// Mirror grid vertically
pub fn mirrorVertical(grid: [][]u8) void {
    if (grid.len < 2) return;
    var top: usize = 0;
    var bottom: usize = grid.len - 1;
    while (top < bottom) {
        const temp = grid[top];
        grid[top] = grid[bottom];
        grid[bottom] = temp;
        top += 1;
        bottom -= 1;
    }
}

/// Transpose grid (swap rows and columns) - only works for square grids
pub fn transpose(grid: [][]u8) void {
    const size = grid.len;
    for (0..size) |i| {
        for (i + 1..size) |j| {
            if (i < grid.len and j < grid[i].len and j < grid.len and i < grid[j].len) {
                const temp = grid[i][j];
                grid[i][j] = grid[j][i];
                grid[j][i] = temp;
            }
        }
    }
}

/// Fill border of grid with value
pub fn border(grid: [][]u8, val: u8) void {
    if (grid.len == 0) return;
    const height = grid.len;
    for (grid[0]) |*cell| cell.* = val;
    if (height > 1) {
        for (grid[height - 1]) |*cell| cell.* = val;
    }
    for (grid[1 .. height - 1]) |row| {
        if (row.len > 0) {
            row[0] = val;
            if (row.len > 1) row[row.len - 1] = val;
        }
    }
}

/// Fill diagonal with generator function
pub fn diagonal(rand: std.Random, grid: [][]u8, func: *const fn (std.Random) u8) void {
    const size = if (grid.len < grid[0].len) grid.len else grid[0].len;
    for (0..size) |i| {
        if (i < grid.len and i < grid[i].len) {
            grid[i][i] = func(rand);
        }
    }
}

/// Fill diagonal with constant value
pub fn diagonalConstant(grid: [][]u8, val: u8) void {
    const size = if (grid.len == 0) 0 else (if (grid.len < grid[0].len) grid.len else grid[0].len);
    for (0..size) |i| {
        if (i < grid.len and i < grid[i].len) {
            grid[i][i] = val;
        }
    }
}

/// Fill grid with vertical gradient
pub fn gradientVertical(grid: [][]u8, start: u8, end: u8) void {
    if (grid.len == 0) return;
    const height = grid.len;
    for (grid, 0..) |row, i| {
        const t = if (height > 1) @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(height - 1)) else 0.0;
        const val = @as(u8, @intFromFloat(@as(f32, @floatFromInt(start)) * (1.0 - t) + @as(f32, @floatFromInt(end)) * t));
        for (row) |*cell| cell.* = val;
    }
}

/// Add noise to 2D grid
pub fn noise2D(rand: std.Random, grid: [][]u8, intensity: u8) void {
    for (grid) |row| {
        for (row) |*cell| {
            const delta_val = rand.intRangeLessThan(i16, -@as(i16, intensity), @as(i16, intensity) + 1);
            const new_val = @as(i16, cell.*) + delta_val;
            cell.* = if (new_val < 0) 0 else if (new_val > 255) 255 else @intCast(new_val);
        }
    }
}

/// Randomly select from source grid to output
pub fn randomSelect2D(rand: std.Random, out: [][]u8, src: [][]const u8) void {
    if (src.len == 0) return;
    for (out) |row| {
        for (row) |*cell| {
            const r = rand.intRangeLessThan(usize, 0, src.len);
            if (src[r].len > 0) {
                const c = rand.intRangeLessThan(usize, 0, src[r].len);
                cell.* = src[r][c];
            }
        }
    }
}

/// Combine two 2D grids using mixing function
pub fn zipFill2D(rand: std.Random, out: [][]u8, a: [][]const u8, b: [][]const u8, mix_func: *const fn (std.Random, u8, u8) u8) void {
    const min_rows = if (out.len < a.len) out.len else a.len;
    const min_rows2 = if (min_rows < b.len) min_rows else b.len;
    for (0..min_rows2) |r| {
        const min_cols = if (out[r].len < a[r].len) out[r].len else a[r].len;
        const min_cols2 = if (min_cols < b[r].len) min_cols else b[r].len;
        for (0..min_cols2) |c| {
            out[r][c] = mix_func(rand, a[r][c], b[r][c]);
        }
    }
}

/// Mix two 2D grids with weight
pub fn mix2D(rand: std.Random, out: [][]u8, weight: f32, a: [][]const u8, b: [][]const u8) void {
    const min_rows = if (out.len < a.len) out.len else a.len;
    const min_rows2 = if (min_rows < b.len) min_rows else b.len;
    for (0..min_rows2) |r| {
        const min_cols = if (out[r].len < a[r].len) out[r].len else a[r].len;
        const min_cols2 = if (min_cols < b[r].len) min_cols else b[r].len;
        for (0..min_cols2) |c| {
            if (rand.float(f32) < weight) {
                out[r][c] = a[r][c];
            } else {
                out[r][c] = b[r][c];
            }
        }
    }
}

/// Transform 2D grid using function
pub fn transform2D(rand: std.Random, out: [][]u8, func: *const fn (std.Random, u8) u8) void {
    for (out) |row| {
        for (row) |*cell| {
            cell.* = func(rand, cell.*);
        }
    }
}

/// Fill 2D grid using mask
pub fn fillMask2D(rand: std.Random, grid: [][]u8, mask: [][]const bool) void {
    const min_rows = if (grid.len < mask.len) grid.len else mask.len;
    for (0..min_rows) |r| {
        const min_cols = if (grid[r].len < mask[r].len) grid[r].len else mask[r].len;
        for (0..min_cols) |c| {
            if (mask[r][c]) {
                grid[r][c] = byte.random(rand);
            }
        }
    }
}

/// Fill grid with range patterns
pub fn gridPattern(rand: std.Random, grid: [][]u8, ranges: [][]const struct { min: u8, max: u8 }) void {
    if (ranges.len == 0) return;
    for (grid, 0..) |row, r| {
        const range_row = ranges[r % ranges.len];
        if (range_row.len == 0) continue;
        for (row, 0..) |*cell, c| {
            const range = range_row[c % range_row.len];
            cell.* = byte.rangeInclusive(rand, range.min, range.max);
        }
    }
}

/// Sparsely fill 2D grid based on density
pub fn sparse2D(rand: std.Random, grid: [][]u8, fill_val: u8, density: f32) void {
    for (grid) |row| {
        for (row) |*cell| {
            if (rand.float(f32) < density) {
                cell.* = fill_val;
            } else {
                cell.* = 0;
            }
        }
    }
}

/// Fill buffer with horizontal gradient
pub fn gradientHorizontal(buf: []u8, start: u8, end: u8) void {
    if (buf.len == 0) return;
    for (buf, 0..) |*b, i| {
        const t = if (buf.len > 1) @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(buf.len - 1)) else 0.0;
        b.* = @as(u8, @intFromFloat(@as(f32, @floatFromInt(start)) * (1.0 - t) + @as(f32, @floatFromInt(end)) * t));
    }
}

/// Add noise to buffer
pub fn noise(rand: std.Random, buf: []u8, intensity: u8) void {
    for (buf) |*b| {
        const delta_val = rand.intRangeLessThan(i16, -@as(i16, intensity), @as(i16, intensity) + 1);
        const new_val = @as(i16, b.*) + delta_val;
        b.* = if (new_val < 0) 0 else if (new_val > 255) 255 else @intCast(new_val);
    }
}

/// Random index within length
pub fn randomIndex(rand: std.Random, len: usize) usize {
    if (len == 0) return 0;
    return rand.intRangeLessThan(usize, 0, len);
}

/// Randomly select from source to output
pub fn randomSelect(rand: std.Random, out: []u8, src: []const u8) void {
    if (src.len == 0) return;
    for (out) |*b| {
        const idx = rand.intRangeLessThan(usize, 0, src.len);
        b.* = src[idx];
    }
}

/// Fill buffer using mask
pub fn fillMask(rand: std.Random, buf: []u8, mask: []const bool) void {
    const min_len = if (buf.len < mask.len) buf.len else mask.len;
    for (0..min_len) |i| {
        if (mask[i]) {
            buf[i] = byte.random(rand);
        }
    }
}

/// Fill buffer with range pattern
pub fn rangePattern(rand: std.Random, buf: []u8, ranges: []const struct { min: u8, max: u8 }) void {
    if (ranges.len == 0) return;
    for (buf, 0..) |*b, i| {
        const range = ranges[i % ranges.len];
        b.* = byte.rangeInclusive(rand, range.min, range.max);
    }
}

/// Sparsely fill buffer based on density
pub fn sparse(rand: std.Random, buf: []u8, fill_val: u8, density: f32) void {
    for (buf) |*b| {
        if (rand.float(f32) < density) {
            b.* = fill_val;
        } else {
            b.* = 0;
        }
    }
}

fn make2dSlice(allocator: std.mem.Allocator, height: usize, width: usize) ![][]u8 {
    var slice = try allocator.alloc(u8, height * width);
    var result: [][]u8 = try allocator.alloc([]u8, height);
    var start: usize = 0;
    var end: usize = width;
    for (0..height) |h| {
        result[h] = slice[start..end];
        start = end;
        end += width;
    }
    return result;
}

fn free2dSlice(allocator: std.mem.Allocator, mem: [][]u8) void {
    allocator.free(mem[0].ptr[0 .. mem.len * mem[0].len]);
    allocator.free(mem);
}

test "Kind enum - generateByte" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const r = generateByte(rand, .random);
    _ = r;

    const a = generateByte(rand, .alpha);
    try testing.expect(byte.isAlpha(a));

    const d = generateByte(rand, .digit);
    try testing.expect(byte.isDigit(d));

    const v = generateByte(rand, .vowel);
    try testing.expect(byte.isVowel(v));
}

test "Kind enum - fill" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [20]u8 = undefined;
    fill(rand, &buf, .alpha);
    for (buf) |b| {
        try testing.expect(byte.isAlpha(b));
    }

    fill(rand, &buf, .digit);
    for (buf) |b| {
        try testing.expect(byte.isDigit(b));
    }

    fill(rand, &buf, .punctuation);
    for (buf) |b| {
        try testing.expect(byte.isPunctuation(b));
    }
}

test "extended buffer fills - binary, octal, base32" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [20]u8 = undefined;

    binary(rand, &buf);
    for (buf) |b| {
        try testing.expect(b == '0' or b == '1');
    }

    octal(rand, &buf);
    for (buf) |b| {
        try testing.expect(b >= '0' and b <= '7');
    }

    base32(rand, &buf);
    for (buf) |b| {
        const valid = (b >= 'A' and b <= 'Z') or (b >= '2' and b <= '7');
        try testing.expect(valid);
    }
}

test "extended buffer fills - vowel, consonant, identifier" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [20]u8 = undefined;

    vowel(rand, &buf);
    for (buf) |b| {
        try testing.expect(byte.isVowel(b));
    }

    consonant(rand, &buf);
    for (buf) |b| {
        try testing.expect(byte.isConsonant(b));
    }

    identifier(rand, &buf);
    for (buf) |b| {
        try testing.expect(byte.isAlphaNumeric(b) or b == '_');
    }
}

test "parameterized fills - shuffle" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [10]u8 = undefined;
    for (&buf, 0..) |*b, i| {
        b.* = @intCast(i);
    }

    const original = buf;
    shuffle(rand, &buf);

    var found: [10]bool = [_]bool{false} ** 10;
    for (buf) |b| {
        found[b] = true;
    }
    for (found) |f| {
        try testing.expect(f);
    }

    var different = false;
    for (buf, original) |b1, b2| {
        if (b1 != b2) {
            different = true;
            break;
        }
    }
    try testing.expect(different or buf.len < 2);
}

test "parameterized fills - repeat and pattern" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [10]u8 = undefined;

    repeat(rand, &buf, 'X');
    for (buf) |b| {
        try testing.expectEqual(@as(u8, 'X'), b);
    }

    const pat = "abc";
    pattern(rand, &buf, pat);
    for (buf, 0..) |b, i| {
        try testing.expectEqual(pat[i % pat.len], b);
    }
}

test "parameterized fills - fromCharset and fillRange" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [20]u8 = undefined;

    const charset = "xyz";
    fromCharset(rand, &buf, charset);
    for (buf) |b| {
        try testing.expect(b == 'x' or b == 'y' or b == 'z');
    }

    fillRange(rand, &buf, 100, 110);
    for (buf) |b| {
        try testing.expect(b >= 100 and b <= 110);
    }
}

test "parameterized fills - fillConstant and fillSequence" {
    var buf: [10]u8 = undefined;

    fillConstant(&buf, 42);
    for (buf) |b| {
        try testing.expectEqual(@as(u8, 42), b);
    }

    fillSequence(&buf, 10, 5);
    try testing.expectEqual(@as(u8, 10), buf[0]);
    try testing.expectEqual(@as(u8, 15), buf[1]);
    try testing.expectEqual(@as(u8, 20), buf[2]);
}

test "higher-order - mapInPlace" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [10]u8 = "hello world"[0..10].*;

    const toUpperFunc = struct {
        fn func(r: std.Random, b: u8) u8 {
            _ = r;
            return byte.toUpper(b);
        }
    }.func;

    mapInPlace(rand, &buf, toUpperFunc);
    try testing.expectEqual(@as(u8, 'H'), buf[0]);
    try testing.expectEqual(@as(u8, 'E'), buf[1]);
}

test "higher-order - mapTo and zipFill" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const src = "abcde";
    var out: [5]u8 = undefined;

    const toUpperFunc = struct {
        fn func(r: std.Random, b: u8) u8 {
            _ = r;
            return byte.toUpper(b);
        }
    }.func;

    mapTo(rand, &out, src, toUpperFunc);
    try testing.expectEqualStrings("ABCDE", &out);

    const a = "hello";
    const b = "world";
    var result: [5]u8 = undefined;

    const xorFunc = struct {
        fn func(r: std.Random, x: u8, y: u8) u8 {
            _ = r;
            return x ^ y;
        }
    }.func;

    zipFill(rand, &result, a, b, xorFunc);
    for (result, 0..) |r, i| {
        try testing.expectEqual(a[i] ^ b[i], r);
    }
}

test "higher-order - mix" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const a = "AAAAA";
    const b = "BBBBB";
    var out: [5]u8 = undefined;

    mix(rand, &out, 0.5, a, b);

    var has_a = false;
    var has_b = false;
    for (out) |c| {
        if (c == 'A') has_a = true;
        if (c == 'B') has_b = true;
    }

    try testing.expect(has_a or has_b);
}

test "2D grid - fill2D and map2D" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 4, 4);
    defer free2dSlice(allocator, grid);

    const fillFunc = struct {
        fn func(r: std.Random) u8 {
            return byte.digit(r);
        }
    }.func;

    fill2D(rand, grid, fillFunc);
    for (grid) |row| {
        for (row) |cell| {
            try testing.expect(byte.isDigit(cell));
        }
    }

    const mapFunc = struct {
        fn func(r: std.Random, row: usize, col: usize) u8 {
            _ = r;
            return @intCast((row * 4 + col) % 256);
        }
    }.func;

    map2D(rand, grid, mapFunc);
    for (grid, 0..) |row, r| {
        for (row, 0..) |cell, c| {
            try testing.expectEqual(@as(u8, @intCast((r * 4 + c) % 256)), cell);
        }
    }
}

test "2D grid - pattern2D" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 4, 4);
    defer free2dSlice(allocator, grid);

    var pattern_storage: [2][2]u8 = undefined;
    pattern_storage[0] = [_]u8{ 'A', 'B' };
    pattern_storage[1] = [_]u8{ 'C', 'D' };

    var pattern_rows: [2][]const u8 = undefined;
    pattern_rows[0] = &pattern_storage[0];
    pattern_rows[1] = &pattern_storage[1];
    const pat: [][]const u8 = &pattern_rows;

    pattern2D(rand, grid, pat);

    try testing.expectEqual(@as(u8, 'A'), grid[0][0]);
    try testing.expectEqual(@as(u8, 'B'), grid[0][1]);
    try testing.expectEqual(@as(u8, 'A'), grid[0][2]);
    try testing.expectEqual(@as(u8, 'C'), grid[1][0]);
}

test "2D grid - mirrorHorizontal and mirrorVertical" {
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 3, 3);
    defer free2dSlice(allocator, grid);

    for (0..3) |i| {
        for (0..3) |j| {
            grid[i][j] = @intCast(i * 3 + j);
        }
    }

    mirrorHorizontal(grid);
    try testing.expectEqual(@as(u8, 2), grid[0][0]);
    try testing.expectEqual(@as(u8, 1), grid[0][1]);
    try testing.expectEqual(@as(u8, 0), grid[0][2]);

    for (0..3) |i| {
        for (0..3) |j| {
            grid[i][j] = @intCast(i * 3 + j);
        }
    }

    mirrorVertical(grid);
    try testing.expectEqual(@as(u8, 6), grid[0][0]);
    try testing.expectEqual(@as(u8, 0), grid[2][0]);
}

test "2D grid - transpose" {
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 3, 3);
    defer free2dSlice(allocator, grid);

    for (0..3) |i| {
        for (0..3) |j| {
            grid[i][j] = @intCast(i * 10 + j);
        }
    }

    transpose(grid);
    try testing.expectEqual(@as(u8, 0), grid[0][0]);
    try testing.expectEqual(@as(u8, 10), grid[0][1]);
    try testing.expectEqual(@as(u8, 20), grid[0][2]);
}

test "2D grid - border and diagonal" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 4, 4);
    defer free2dSlice(allocator, grid);

    for (grid) |row| {
        for (row) |*cell| {
            cell.* = 0;
        }
    }

    border(grid, 'X');

    try testing.expectEqual(@as(u8, 'X'), grid[0][0]);
    try testing.expectEqual(@as(u8, 'X'), grid[0][3]);
    try testing.expectEqual(@as(u8, 'X'), grid[3][0]);
    try testing.expectEqual(@as(u8, 'X'), grid[3][3]);

    try testing.expectEqual(@as(u8, 0), grid[1][1]);

    diagonalConstant(grid, 'D');
    try testing.expectEqual(@as(u8, 'D'), grid[0][0]);
    try testing.expectEqual(@as(u8, 'D'), grid[1][1]);
    try testing.expectEqual(@as(u8, 'D'), grid[2][2]);
    try testing.expectEqual(@as(u8, 'D'), grid[3][3]);

    const diagFunc = struct {
        fn func(r: std.Random) u8 {
            return byte.digit(r);
        }
    }.func;

    diagonal(rand, grid, diagFunc);
    for (0..4) |i| {
        try testing.expect(byte.isDigit(grid[i][i]));
    }
}

test "2D grid - gradientVertical" {
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 5, 3);
    defer free2dSlice(allocator, grid);

    gradientVertical(grid, 0, 100);
    try testing.expectEqual(@as(u8, 0), grid[0][0]);
    try testing.expectEqual(@as(u8, 100), grid[4][0]);

    try testing.expectEqual(grid[0][0], grid[0][1]);
    try testing.expectEqual(grid[0][0], grid[0][2]);
}

test "2D grid - sparse2D" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();
    const allocator = std.testing.allocator_instance.allocator();

    const grid = try make2dSlice(allocator, 10, 10);
    defer free2dSlice(allocator, grid);

    sparse2D(rand, grid, 'X', 0.3);
    var count: usize = 0;
    for (grid) |row| {
        for (row) |cell| {
            if (cell == 'X') count += 1;
        }
    }

    try testing.expect(count > 10 and count < 50);
}

test "1D effects - gradientHorizontal" {
    var buf: [10]u8 = undefined;
    gradientHorizontal(&buf, 0, 90);

    try testing.expectEqual(@as(u8, 0), buf[0]);
    try testing.expectEqual(@as(u8, 90), buf[9]);

    for (buf[0 .. buf.len - 1], buf[1..buf.len]) |a, b| {
        try testing.expect(a <= b);
    }
}

test "1D effects - noise" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [20]u8 = undefined;
    fillConstant(&buf, 128);

    noise(rand, &buf, 10);

    for (buf) |b| {
        try testing.expect(b >= 118 and b <= 138);
    }
}

test "1D effects - randomSelect" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    const src = "ABC";
    var out: [20]u8 = undefined;

    randomSelect(rand, &out, src);
    for (out) |b| {
        try testing.expect(b == 'A' or b == 'B' or b == 'C');
    }
}

test "1D effects - fillMask" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [10]u8 = undefined;
    fillConstant(&buf, 0);

    const mask = [_]bool{ true, false, true, false, true, false, true, false, true, false };

    fillMask(rand, &buf, &mask);
    try testing.expectEqual(@as(u8, 0), buf[1]);
    try testing.expectEqual(@as(u8, 0), buf[3]);
    try testing.expect(buf[0] != 0);
    try testing.expect(buf[2] != 0);
}

test "1D effects - sparse" {
    var prng = std.Random.DefaultPrng.init(42);
    const rand = prng.random();

    var buf: [100]u8 = undefined;
    sparse(rand, &buf, 'X', 0.25);

    var count: usize = 0;
    for (buf) |b| {
        if (b == 'X') count += 1;
    }

    try testing.expect(count > 10 and count < 40);
}
