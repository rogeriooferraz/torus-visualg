// Based on the classic ASCII donut animation by Andy Sloane.

// Copyright (c) 2026 Rogerio O. Ferraz <rogerio.o.ferraz@gmail.com>

// MIT License

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

algoritmo "torus"

// Optimized for the Design Liquido VisuAlg CLI on Linux.

// Optimizations:
//
// - 120 x 40 terminal canvas.
// - No limpatela during animation.
// - Hidden terminal cursor.
// - Entire frame written with one escreva().
// - Fixed integer geometry loops.
// - Trigonometric recurrence.
// - Reduced sampling density.
// - Rotation-speed multiplier to compensate for lower CLI FPS.
//
// Variable table:
//
// Name | Meaning
// -----|----------------------------------------------------
// a    | axial rotation angle
// b    | elevation rotation angle
// c    | character/display buffer
// d    | depth buffer (z-buffer)
// f    | pi
// g    | axial rotation increment
// h    | elevation rotation increment
// i    | poloidal loop counter
// j    | toroidal loop counter
// k    | cosine of poloidal angle
// l    | sine of poloidal angle
// m    | sine of toroidal angle
// n    | cosine of toroidal angle
// o    | cosine of axial rotation
// p    | sine of axial rotation
// q    | cosine of elevation rotation
// r    | sine of elevation rotation
// s    | radial distance from main axis
// t    | tube Y offset
// u    | inverse depth
// v    | projected intermediate Y coordinate
// w    | projected screen X coordinate
// x    | projected screen Y coordinate
// y    | brightness/shading index
// z    | ASCII shading ramp
// aa   | row index
// ab   | column index
// ac   | complete output frame
// ad   | sine of poloidal step
// ae   | cosine of poloidal step
// af   | sine of toroidal step
// ag   | cosine of toroidal step
// ah   | temporary trigonometric value
// ai   | ANSI cursor-home sequence
// aj   | ANSI hide-cursor sequence
// ak   | rotation speed multiplier
//
// Note: variable "e" is intentionally skipped because "e"
// is the VisuAlg logical AND operator.
//
// Canvas:
//
// Width:  120 columns
// Height: 40 rows
//
// Sampling:
//
// Poloidal step: 0.12 radians
// Toroidal step: 0.04 radians
//
// Approximate samples per frame:
//
// 53 x 158 = 8374

var

   a, b: real

   c: vetor[0..39, 0..118] de caractere
   d: vetor[0..39, 0..118] de real

   f, g, h: real

   i, j: inteiro

   k, l, m, n: real
   o, p, q, r: real

   s, t, u, v: real

   w, x, y: inteiro

   z: caractere

   aa, ab: inteiro

   ac: caractere

   ad, ae: real
   af, ag: real
   ah: real

   ai, aj: caractere

   ak: real

inicio

   f <- 3.141592653589793

   // Initial rotation.

   a <- 1
   b <- 1

   // Original animation rotation increments.
   //
   // 11 axial turns per 6280 frames.
   // 5 elevation turns per 6280 frames.

   g <- (2 * f * 11) / 6280
   h <- (2 * f * 5) / 6280

   // Rotation speed compensation.
   //
   // The JavaScript version targets roughly 20 FPS.
   // VisuAlg renders fewer frames per second, so each
   // rendered frame advances the rotation farther.
   //
   // Try values between 4 and 10 if desired.

   ak <- 6

   // ASCII brightness ramp.
   //
   // More levels give smoother transitions between
   // shadow, midtone, and highlight.

   z <- ".,-~:;=+!*#$%@"

   // Sampling-step trigonometry.

   ad <- sen(0.12)
   ae <- cos(0.12)

   af <- sen(0.04)
   ag <- cos(0.04)

   // ANSI terminal sequences.
   //
   // ESC[H     = cursor home
   // ESC[?25l  = hide cursor

   ai <- carac(27) + "[H"
   aj <- carac(27) + "[?25l"

   // Clear screen once and hide cursor.

   limpatela
   escreva(aj)

   enquanto (1 = 1) faca

      // Global torus rotation trigonometry.

      o <- cos(a)
      p <- sen(a)

      q <- cos(b)
      r <- sen(b)

      // Clear buffers.

      para aa de 0 ate 39 faca

         para ab de 0 ate 118 faca
            c[aa, ab] <- " "
            d[aa, ab] <- 0
         fimpara

      fimpara

      // Initial poloidal values.

      k <- 1
      l <- 0

      para i de 0 ate 52 faca

         // Initial toroidal values.

         m <- 0
         n <- 1

         para j de 0 ate 157 faca

            // Torus geometry.

            s <- 22 + 4.2 * k
            t <- 4.2 * l

            // Perspective depth.

            u <- 1 / (m * s * p + t * o + 28)

            // Intermediate rotated coordinate.

            v <- m * s * o - t * p

            // Projection.

            w <- int(60 + 18 * u * (n * s * q - v * r))
            x <- int(20 + 8 * u * (n * s * r + v * q))

            // Lighting.
            //
            // Shift the signed light value into the middle
            // of the ramp instead of collapsing every dark
            // surface to the first character. This preserves
            // detail in shadows and gives the tube more depth.

            y <- int(6 + 4.5 * ((l * p - m * k * o) * q - m * k * p - l * o - n * k * r))

            se (y < 0) entao
               y <- 0
            fimse

            se (y > 13) entao
               y <- 13
            fimse

            // Bounds and z-buffer.

            se (x >= 0) e (x < 40) e (w >= 0) e (w < 119) entao

               se (u > d[x, w]) entao
                  d[x, w] <- u
                  c[x, w] <- copia(z, y + 1, 1)
               fimse

            fimse

            // Advance toroidal sin/cos.

            ah <- m * ag + n * af
            n <- n * ag - m * af
            m <- ah

         fimpara

         // Advance poloidal sin/cos.

         ah <- l * ae + k * ad
         k <- k * ae - l * ad
         l <- ah

      fimpara

      // Assemble complete terminal frame.

      ac <- ai

      para aa de 0 ate 39 faca

         para ab de 0 ate 118 faca
            ac <- ac + c[aa, ab]
         fimpara

         ac <- ac + carac(10)

      fimpara

      // Single terminal write.

      escreva(ac)

      // Advance global torus rotation.
      //
      // Both increments use the same multiplier so the
      // original 11:5 rotation relationship is preserved.

      a <- a + g * ak
      b <- b + h * ak

   fimenquanto

fimalgoritmo
