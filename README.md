# CIS-343-LanguageCreation
This program allows for users to create drawings using the SDL2 library and a custom command-based language called "zoomjoystrong." It was created using Bison and Flex parsing features.

The following are valid commands to use with the program:

**line x y u v;**
```
Creates a line from a point to another point.
```
**point  x  y;**
```
Creates a point at a specific location.
```
**circle  x  y  r;**
```
Creates a circle at a point;
```
**rectangle  x  y  w  h;**
```
Creates a rectangle at a point.
```
**set_color  r  g  b;**
```
Sets the color for the current drawing based on RGB values.
```
**END**
```
Waits 5 seconds and then exits the program.
```
