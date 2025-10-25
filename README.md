# fakerz

A simple Zig library for generating fake data for testing. If you've ever needed random strings, test data, or placeholder values in your Zig projects, this is for you.

## Quick Start

Add fakerz to your project:

```bash
zig fetch --save git+https://github.com/pierrelgol/fakerz#main
```

Then in your `build.zig`, add it as a dependency:

```zig
const fakerz_dep = b.dependency("fakerz", .{
    .target = target,
    .optimize = optimize,
});

const fakerz = fakerz_dep.module("fakerz");
exe.root_module.addImport("fakerz", fakerz);
```

## Example

```zig
const std = @import("std");
const fakerz = @import("fakerz");

pub fn main() !void {
    var prng = std.Random.DefaultPrng.init(12345);
    const rand = prng.random();

    // Generate a random string of 20 letters
    var username: [20]u8 = undefined;
    fakerz.text.string.alpha(rand, &username);
    std.debug.print("Username: {s}\n", .{username});

    // Generate random digits for a fake ID
    var id: [10]u8 = undefined;
    fakerz.text.string.digit(rand, &id);
    std.debug.print("ID: {s}\n", .{id});

    // Generate random hex for a fake session token
    var token: [32]u8 = undefined;
    fakerz.text.string.hex(rand, &token);
    std.debug.print("Token: {s}\n", .{token});

    // Mix things up with alphanumeric
    var password: [16]u8 = undefined;
    fakerz.text.string.alnum(rand, &password);
    std.debug.print("Password: {s}\n", .{password});
}
```

## What can you do with it?

### Basic String Generation

Fill buffers with different types of characters:

- `alpha()` - Random letters (a-z, A-Z)
- `upper()` / `lower()` - Uppercase or lowercase only
- `digit()` - Numbers 0-9
- `alnum()` - Letters and numbers mixed
- `hex()` - Hexadecimal characters
- `ascii()` / `printable()` / `visible()` - Various ASCII ranges
- `identifier()` - Valid identifier characters (great for variable names)
- `vowel()` / `consonant()` - Just vowels or consonants

### Special Characters

- `punctuation()` - Punctuation marks
- `symbol()` - Various symbols
- `bracket()` / `quote()` - Brackets and quotes
- `whitespace()` - Spaces, tabs, newlines

### Advanced Patterns

```zig
// Repeat a pattern
var buf: [40]u8 = undefined;
fakerz.text.string.pattern(rand, &buf, "Aa#"); // Repeats "Aa#Aa#Aa#..."

// Fill from a custom character set
fakerz.text.string.fromCharset(rand, &buf, "!@#$%^&*");

// Shuffle existing data
fakerz.text.string.shuffle(rand, &buf);

// Create gradients (useful for test patterns)
fakerz.text.string.gradientHorizontal(&buf, 'A', 'Z'); // A...Z gradient
```

### 2D Grids

Need to generate test data for grids or matrices?

```zig
const allocator = std.heap.page_allocator;
var grid = try allocator.alloc([]u8, 10);
for (grid) |*row| {
    row.* = try allocator.alloc(u8, 10);
}
defer {
    for (grid) |row| allocator.free(row);
    allocator.free(grid);
}

// Fill with random letters
fakerz.text.string.fill2D(rand, grid, fakerz.text.byte.alpha);

// Add a border
fakerz.text.string.border(grid, '*');

// Create gradients
fakerz.text.string.gradientVertical(grid, 'A', 'Z');

// Shuffle the whole grid (requires a temporary buffer)
var buffer: [100]u8 = undefined;
fakerz.text.string.shuffle2D(rand, grid, &buffer);
```

### Kind Enum (Type-Safe Generation)

Use the `Kind` enum for more flexibility:

```zig
const kind = fakerz.text.string.Kind.alphaNumeric;
fakerz.text.string.fill(rand, &buf, kind);

// Or generate single bytes
const random_vowel = fakerz.text.string.generateByte(rand, .vowel);
```

## How it Works

All generation functions take `std.Random` as the first parameter, which means:
- You control the random seed (great for reproducible tests)
- No global state
- Easy to test and mock

Most functions fill buffers you provide, so you control memory allocation. No surprises.

## Building

```bash
# Build the project
zig build

# Run tests
zig build test

# Run the demo
zig build run
```

## License

This project is in early development (v0.0.0). Use at your own risk, but have fun!
