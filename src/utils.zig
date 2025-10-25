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
const testing = std.testing;

pub fn min(a: usize, b: usize) usize {
    return if (a < b) a else b;
}

pub fn max(a: usize, b: usize) usize {
    return if (a > b) a else b;
}

pub fn clamp(val: usize, low: usize, high: usize) usize {
    if (val < low) return low;
    if (val > high) return high;
    return val;
}

test "min" {
    try testing.expectEqual(1, min(1, 2));
    try testing.expectEqual(1, min(2, 1));
    try testing.expectEqual(5, min(5, 5));
}

test "max" {
    try testing.expectEqual(2, max(1, 2));
    try testing.expectEqual(2, max(2, 1));
    try testing.expectEqual(5, max(5, 5));
}

test "clamp" {
    try testing.expectEqual(5, clamp(3, 5, 10));
    try testing.expectEqual(7, clamp(7, 5, 10));
    try testing.expectEqual(10, clamp(15, 5, 10));
}
