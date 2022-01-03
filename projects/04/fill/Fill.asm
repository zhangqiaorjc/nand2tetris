// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
// R0 = pixel iterator
// R1 = fill value
// R2 => RAM[R2] = R1
(KBDLOOP)         // Keyborad listening loop
        @KBD
        D = M     // Read keyboard value to D
        @CLEARSC  // Clear screen if no key pressed
        D; JEQ
        @DARKSC   // Darken screen if some key pressed
        0; JMP
(CLEARSC)         // Set screen to white
        @1        // R1 will contain the value to set screen pixels to
        M = 0     // R1=0
        @PRELUDE
        0; JMP
(DARKSC)          // Set screen to black
        @1
        M = -1    // R1=-1
        @PRELUDE
        0; JMP
(PRELUDE)
        @8191     // Store 8191 in R0, 8192 = 256 * 32
        D = A
        @0
        M = D
        @PRTLOOP
        0; JMP
(PRTLOOP)
        @SCREEN   // Set whole screen to value in R1
        D = A     // Set RAM[SCREEN + R0]
        @0
        A = D + M
        D = A
        @2
        M = D     // R2=SCREEN+R0
        @1
        D = M
        @2
        A = M     // A = R2
        M = D     // Set RAM[R2] = R1
        @0        // Decrement R0
        M = M - 1
        D = M     // If R0 <= 0, exit screen loop
        @KBDLOOP
        D; JLE
        @PRTLOOP
        0; JMP
