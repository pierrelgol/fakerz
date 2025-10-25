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
const fakerz = @import("fakerz");

comptime {
    std.testing.refAllDecls(fakerz);
}

pub fn make2dSlice(allocator: std.mem.Allocator, height: usize, width: usize) ![][]u8 {
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

pub fn free2dSlice(allocator: std.mem.Allocator, mem: [][]u8) void {
    allocator.free(mem[0].ptr[0 .. mem.len * mem[0].len]);
    allocator.free(mem);
}

pub fn memsetSlice(mem: [][]u8, value: u8) void {
    for (0..mem.len) |i| {
        for (0..mem[0].len) |j| {
            mem[i][j] = value;
        }
    }
}

pub fn print2dSlice(mem: [][]u8) void {
    for (0..mem.len) |i| {
        for (0..mem[0].len) |j| {
            if (j == mem[0].len -| 1)
                std.debug.print("{c}", .{mem[i][j]})
            else
                std.debug.print("{c},", .{mem[i][j]});
        }
        std.debug.print("\n", .{});
    }
}

fn printSeparator(title: []const u8) void {
    std.debug.print("\n", .{});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\n{s}\n", .{title});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\n", .{});
}

fn printBuffer(label: []const u8, buffer: []const u8) void {
    std.debug.print("{s}: ", .{label});
    for (buffer) |c| {
        std.debug.print("{c}", .{c});
    }
    std.debug.print("\n", .{});
}

fn testByteGeneration(rand: std.Random) void {
    printSeparator("Byte Generation Tests");

    std.debug.print("Vowels: ", .{});
    for (0..20) |_| {
        std.debug.print("{c} ", .{fakerz.text.byte.vowel(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Consonants: ", .{});
    for (0..20) |_| {
        std.debug.print("{c} ", .{fakerz.text.byte.consonant(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Digits: ", .{});
    for (0..20) |_| {
        std.debug.print("{c} ", .{fakerz.text.byte.digit(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Hex: ", .{});
    for (0..20) |_| {
        std.debug.print("{c} ", .{fakerz.text.byte.hex(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Brackets: ", .{});
    for (0..10) |_| {
        std.debug.print("{c}{c} ", .{
            fakerz.text.byte.bracketOpen(rand),
            fakerz.text.byte.bracketClose(rand),
        });
    }
    std.debug.print("\n", .{});
}

fn testStringFills(rand: std.Random) void {
    printSeparator("String Fill Tests");

    var buffer: [40]u8 = undefined;

    fakerz.text.string.upper(rand, &buffer);
    printBuffer("Upper", &buffer);

    fakerz.text.string.lower(rand, &buffer);
    printBuffer("Lower", &buffer);

    fakerz.text.string.alpha(rand, &buffer);
    printBuffer("Alpha", &buffer);

    fakerz.text.string.vowel(rand, &buffer);
    printBuffer("Vowel", &buffer);

    fakerz.text.string.consonant(rand, &buffer);
    printBuffer("Consonant", &buffer);

    fakerz.text.string.identifier(rand, &buffer);
    printBuffer("Identifier", &buffer);

    fakerz.text.string.base32(rand, &buffer);
    printBuffer("Base32", &buffer);

    fakerz.text.string.binary(rand, &buffer);
    printBuffer("Binary", &buffer);
}

fn testParameterizedFills(rand: std.Random) void {
    printSeparator("Parameterized Fill Tests");

    var buffer: [40]u8 = undefined;

    fakerz.text.string.pattern(rand, &buffer, "Aa#");
    printBuffer("Pattern 'Aa#'", &buffer);

    fakerz.text.string.repeat(rand, &buffer, '*');
    printBuffer("Repeat '*'", &buffer);

    const charset = "!@#$%^&*";
    fakerz.text.string.fromCharset(rand, &buffer, charset);
    printBuffer("From charset '!@#$%^&*'", &buffer);

    for (&buffer, 0..) |*c, i| c.* = @intCast('A' + (i % 26));
    printBuffer("Before shuffle", &buffer);
    fakerz.text.string.shuffle(rand, &buffer);
    printBuffer("After shuffle", &buffer);

    fakerz.text.string.delta(rand, &buffer, 'A', 10);
    printBuffer("Delta from 'A' range 10", &buffer);
}

fn testKindEnum(rand: std.Random) void {
    printSeparator("Kind Enum Tests");

    var buffer: [40]u8 = undefined;

    const kinds = [_]fakerz.text.string.Kind{
        .vowelLower,
        .consonantUpper,
        .digit,
        .hex,
        .bracket,
        .symbol,
        .mathSymbol,
        .arrowSymbol,
    };

    for (kinds) |kind| {
        fakerz.text.string.fill(rand, &buffer, kind);
        printBuffer(@tagName(kind), &buffer);
    }
}

fn testHigherOrderFunctions(rand: std.Random) void {
    printSeparator("Higher-Order Function Tests");

    var buffer: [40]u8 = undefined;
    var result: [40]u8 = undefined;

    // Fill with lowercase
    fakerz.text.string.lower(rand, &buffer);
    printBuffer("Original lowercase", &buffer);

    // Manual uppercase transformation
    for (&buffer) |*c| {
        c.* = fakerz.text.byte.toUpper(c.*);
    }
    printBuffer("After manual toUpper", &buffer);

    // Fill and demonstrate toggle
    fakerz.text.string.alpha(rand, &buffer);
    printBuffer("Alpha source", &buffer);
    for (&buffer, 0..) |c, i| {
        result[i] = fakerz.text.byte.toggleCase(c);
    }
    printBuffer("After toggleCase", &result);

    // Mix two buffers
    fakerz.text.string.upper(rand, &buffer);
    var buffer2: [40]u8 = undefined;
    fakerz.text.string.digit(rand, &buffer2);
    printBuffer("Buffer 1", &buffer);
    printBuffer("Buffer 2", &buffer2);
    // Mix function that randomly picks from either buffer
    const mixFunc = struct {
        fn pick(r: std.Random, a: u8, b: u8) u8 {
            return if (r.boolean()) a else b;
        }
    }.pick;
    fakerz.text.string.zipFill(rand, &result, &buffer, &buffer2, mixFunc);
    printBuffer("Zipped result", &result);
}

fn test1DEffects(rand: std.Random) void {
    printSeparator("1D Effects Tests");

    var buffer: [60]u8 = undefined;

    fakerz.text.string.gradientHorizontal(&buffer, 'A', 'Z');
    printBuffer("Gradient A->Z", &buffer);

    fakerz.text.string.noise(rand, &buffer, 76);
    printBuffer("Noise intensity 76", &buffer);

    const options = "ABC";
    fakerz.text.string.randomSelect(rand, &buffer, options);
    printBuffer("Random select from 'ABC'", &buffer);

    @memset(&buffer, '.');
    fakerz.text.string.sparse(rand, &buffer, 'X', 0.2);
    printBuffer("20% sparse X on .", &buffer);
}

fn test2DGrids(rand: std.Random, allocator: std.mem.Allocator) !void {
    printSeparator("2D Grid Tests");

    const grid = try make2dSlice(allocator, 8, 8);
    defer free2dSlice(allocator, grid);

    // Fill 2D with alpha
    std.debug.print("\nFill2D with alpha:\n", .{});
    fakerz.text.string.fill2D(rand, grid, fakerz.text.byte.alpha);
    print2dSlice(grid);

    // Border
    std.debug.print("\nBorder with '*' on '.':\n", .{});
    memsetSlice(grid, '.');
    fakerz.text.string.border(grid, '*');
    print2dSlice(grid);

    // Diagonal
    std.debug.print("\nDiagonal '/' on '.':\n", .{});
    memsetSlice(grid, '.');
    fakerz.text.string.diagonalConstant(grid, '/');
    print2dSlice(grid);

    // Gradient vertical
    std.debug.print("\nVertical gradient A->Z:\n", .{});
    fakerz.text.string.gradientVertical(grid, 'A', 'Z');
    print2dSlice(grid);

    // Mirror horizontal
    std.debug.print("\nMirror horizontal:\n", .{});
    fakerz.text.string.fill2D(rand, grid, fakerz.text.byte.alpha);
    std.debug.print("Before:\n", .{});
    print2dSlice(grid);
    fakerz.text.string.mirrorHorizontal(grid);
    std.debug.print("After:\n", .{});
    print2dSlice(grid);

    // Transpose
    const square_grid = try make2dSlice(allocator, 6, 6);
    defer free2dSlice(allocator, square_grid);

    std.debug.print("\nTranspose:\n", .{});
    fakerz.text.string.fill2D(rand, square_grid, fakerz.text.byte.alpha);
    std.debug.print("Before:\n", .{});
    print2dSlice(square_grid);
    fakerz.text.string.transpose(square_grid);
    std.debug.print("After:\n", .{});
    print2dSlice(square_grid);

    // Noise 2D
    std.debug.print("\nNoise2D with intensity 76:\n", .{});
    memsetSlice(grid, '.');
    fakerz.text.string.noise2D(rand, grid, 76);
    print2dSlice(grid);

    // Sparse 2D
    std.debug.print("\nSparse2D 20% 'X' on '.':\n", .{});
    memsetSlice(grid, '.');
    fakerz.text.string.sparse2D(rand, grid, 'X', 0.2);
    print2dSlice(grid);
}

fn testBitManipulation(rand: std.Random) void {
    printSeparator("Bit Manipulation Tests");

    std.debug.print("Even bytes: ", .{});
    for (0..10) |_| {
        std.debug.print("0x{X:0>2} ", .{fakerz.text.byte.evenByte(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Odd bytes: ", .{});
    for (0..10) |_| {
        std.debug.print("0x{X:0>2} ", .{fakerz.text.byte.oddByte(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Powers of 2: ", .{});
    for (0..10) |_| {
        std.debug.print("0x{X:0>2} ", .{fakerz.text.byte.powerOfTwo(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Prime bytes: ", .{});
    for (0..10) |_| {
        std.debug.print("0x{X:0>2} ", .{fakerz.text.byte.primeByte(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Mirrored nibbles: ", .{});
    for (0..10) |_| {
        std.debug.print("0x{X:0>2} ", .{fakerz.text.byte.mirroredNibble(rand)});
    }
    std.debug.print("\n", .{});

    std.debug.print("Alternating bits: ", .{});
    for (0..10) |_| {
        std.debug.print("0b{b:0>8} ", .{fakerz.text.byte.alternating(rand)});
    }
    std.debug.print("\n", .{});
}

fn testBitSetOperations(rand: std.Random) void {
    printSeparator("BitSet Operations Tests");

    var bitset = std.bit_set.IntegerBitSet(256).initEmpty();

    // Mark some characters as used
    bitset.set('A');
    bitset.set('B');
    bitset.set('C');
    bitset.set('X');
    bitset.set('Y');
    bitset.set('Z');

    std.debug.print("Marked as used: A, B, C, X, Y, Z\n", .{});
    std.debug.print("Total available in bitset: {}\n", .{fakerz.text.byte.countAvailableInBitSet(bitset)});

    std.debug.print("\nUnique from charset 'ABCDEFGHIJ': ", .{});
    var local_bitset = bitset;
    for (0..5) |_| {
        const ch = fakerz.text.byte.uniqueFromCharset(rand, "ABCDEFGHIJ", &local_bitset);
        std.debug.print("{c} ", .{ch});
    }
    std.debug.print("\n", .{});
}

pub fn main() !void {
    var gpai: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpai.deinit();

    const allocator = gpai.allocator();

    var prng = std.Random.DefaultPrng.init(12345);
    const rand = prng.random();

    std.debug.print("\n", .{});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\nFAKERZ LIBRARY - Visual Check Tests\n", .{});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\n", .{});

    testByteGeneration(rand);
    testStringFills(rand);
    testParameterizedFills(rand);
    testKindEnum(rand);
    testHigherOrderFunctions(rand);
    test1DEffects(rand);
    try test2DGrids(rand, allocator);
    testBitManipulation(rand);
    testBitSetOperations(rand);

    std.debug.print("\n", .{});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\nAll visual tests completed!\n", .{});
    for (0..60) |_| std.debug.print("=", .{});
    std.debug.print("\n\n", .{});
}
