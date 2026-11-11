# Release Notes

## Master

## 1.1.0-everdeep.1 (Sun-Fox-Studios fork)

* A `Library` can now be shared between threads. Faces, glyphs, outlines, strokers and cache managers can be created and disposed on any thread, also while the library itself is disposed. Before, the unsynchronized child lists could get a `null` entry, so disposing the library threw a `NullReferenceException`.
* Creating and destroying faces is serialized per library, as FreeType requires.
* Disposing an object frees its native object only once, even when two threads dispose it at the same time.
* A glyph destroyed by `Glyph.Stroke` or `Glyph.StrokeBorder` (with `destroy`) is no longer kept by its library forever.
* Removing a disposed object from its library takes constant time instead of a search through all live objects.

## Current (wizards-1.1.0)

* Library has been significantly rewritten internally to use a new FFI layer. This should probably fix a bunch of bugs (many APIs were previously outright broken), and makes the library more maintainable towards the future.
* Added `RenderMode.Sdf`.

## wizards-1.0.2

* Use `libfreetype.so.6` on FreeBSD.
* General repo cleanup to use modern practices, update to .NET 7.

## wizards-1.0.1

* Stop using `/usr/X11/lib/libfreetype.6.dylib` on macOS.

## wizards-1.0.0

This is the first release. Changes over base `SharpFont`:

* .NET Core 3 support
