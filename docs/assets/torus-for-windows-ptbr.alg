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

                                                                                         algoritmo "torus-for-windows-ptbr"
                                                                                                          var
                                                                               a,                         b:                        real
                                                                       c:           vetor[0..39,          0..118]          de          caractere
                                                                 d:               vetor[0..39,               0..118]              de              real
                                                            f,                             g,                            h:                            real
                                                       i,                                               j:                                               inteiro
                                                   k,                          l,                         m,                         n:                         real
                                               o,                            p,                           q,                           r:                           real
                                            s,                             t,                             u,                             v:                            real
                                        w,                                         x,                                         y:                                        inteiro
                                      z:                                                                                                                                caractere
                                   aa,                                                                  ab:                                                                  inteiro
                                ac:                                                                                                                                           caractere
                              ad,                                                                         ae:                                                                        real
                            af,                                                                           ag:                                                                          real
                          ah:                                                                                                                                                            real
                        ak:                                                                                                                                                                real
                                                                                                        inicio
                    f                                                                              <-                                                                             3.141592653589793
                  a                                                                                        <-                                                                                       1
                 b                                                                                         <-                                                                                        1
               g                      <-                     (2                     *                     f                     *                     11)                     /                     6280
              h                      <-                      (2                      *                      f                     *                     5)                     /                     6280
             ak                                                                                            <-                                                                                            4
            z                                                                                  <-                     ".,-~:;=+!*#$%@"
          ad                                                                            <-                                   sen(0.12)
         ae                                                                        <-                                             cos(0.12)
        af                                                                      <-                                                   sen(0.04)
        ag                                                                   <-                                                         cos(0.04)
       enquanto                                                           (1                                                               =                               1)                               faca
      o                                                                 <-                                                                   cos(a)
     p                                                                <-                                                                       sen(a)
     q                                                               <-                                                                         cos(b)
    r                                                              <-                                                                             sen(b)
    para                   aa                  de                  0                                                                               ate                            39                           faca
   para                   ab                  de                  0                                                                                 ate                           118                           faca
   c[aa,                                                        ab]                                                                                 <-                                                           " "
   d[aa,                                                                                                                                             ab]                             <-                            0
  fimpara
                                                                                                                                                                                                              fimpara
  k                                                                                                                                                   <-                                                            1
  l                                                                                                                                                   <-                                                            0
  para                   i                  de                  0                                                                                     ate                           52                           faca
  m                                                                                                                                                   <-                                                            0
  n                                                                                                                                                   <-                                                            1
  para                   j                  de                  0                                                                                     ate                           157                          faca
   s                             <-                             22                                                                                   +                   4.2                   *                   k
   t                                                             <-                                                                                 4.2                              *                             l
   u          <-         1         /         (m         *         s                                                                                 *        p        +        t        *        o       +       28)
    v               <-               m              *              s                                                                               *            o            -            t           *           p
    w         <-         int(60         +        18        *        u                                                                             *      (n      *      s      *      q      -      v     *     r))
     x        <-        int(20        +       8       *       u       *                                                                         (n       *       s       *       r       +       v      *      q))
     y   <-   int(6   +   4.5   *   ((l   *   p   -   m   *   k   *   o)                                                                       *   q   -   m   *   k   *   p   -   l   *   o   -   n  *  k  *  r))
      se                                (y                               <                                                                   0)                                                             entao
       y                                                                                                                                   <-                                                                  0
        fimse
        se                                   (y                                  >                                                   13)                                                                  entao
         y                                                                         <-                                             13
                                                                                                                                                                                                        fimse
            se         (x         >=         0)         e         (x        <        40)        e                     (w          >=          0)          e         (w         <         119)         entao
             se                                   (u                                   >                                  d[x,                                  w])                                  entao
              d[x,                                                            w]                                                           <-                                                           u
               c[x,                        w]                        <-                       copia(z,                       y                       +                       1,                       1)
                                                                                                         fimse
                                                                                                         fimse
                    ah                     <-                     m                    *                    ag                    +                    n                    *                    af
                      n                    <-                    n                    *                    ag                    -                    m                    *                   af
                        m                                                                                 <-                                                                                 ah
                                                                                                        fimpara
                            ah                   <-                   l                  *                  ae                  +                  k                  *                  ad
                              k                  <-                  k                  *                  ae                  -                  l                  *                 ad
                                l                                                                         <-                                                                         ah
                                                                                                        fimpara
                                                                                                       limpatela
                                        para                    aa                    de                    0                   ate                   39                   faca
                                            ac                                                             <-                                                            ""
                                               para                 ab                 de                 0                 ate                 118                 faca
                                                   ac                    <-                    ac                    +                   c[aa,                   ab]
                                                                                                        fimpara
                                                                                                     escreval(ac)
                                                                                                        fimpara
                                                                       a           <-           a           +           g          *          ak
                                                                               b        <-        b        +        h        *        ak
                                                                                                      fimenquanto
                                                                                                          fimalgoritmo

// -----------------------------------------------------------------------------
// Tabela de mapeamento entre a versão ofuscada e a versão legível
// -----------------------------------------------------------------------------
// Variável | Nome legível      | Significado
// ---------|-------------------|--------------------------------------------------------------
// a        | angleAxial        | ângulo axial global do toro
// b        | angleElevation    | ângulo global de inclinação / elevação
// c        | charBuffer        | buffer de caracteres da tela
// d        | depthBuffer       | z-buffer / buffer de profundidade
// f        | piValue           | valor de pi
// g        | axialStep         | incremento do giro axial por quadro
// h        | elevationStep     | incremento da inclinação por quadro
// i        | tubeIndex         | contador do laço do tubo
// j        | ringIndex         | contador do laço do anel principal
// k        | cosTube           | cosseno do ângulo do tubo
// l        | sinTube           | seno do ângulo do tubo
// m        | sinRing           | seno do ângulo do anel principal
// n        | cosRing           | cosseno do ângulo do anel principal
// o        | cosAxial          | cosseno do ângulo axial global
// p        | sinAxial          | seno do ângulo axial global
// q        | cosElevation      | cosseno do ângulo global de inclinação
// r        | sinElevation      | seno do ângulo global de inclinação
// s        | ringDistance      | distância do eixo principal até o centro do tubo
// t        | tubeYOffset       | deslocamento Y local do tubo
// u        | inverseDepth      | profundidade inversa usada na projeção
// v        | rotatedY          | coordenada Y intermediária após a rotação
// w        | screenCol         | coluna projetada na tela
// x        | screenRow         | linha projetada na tela
// y        | shadeIndex        | índice de brilho na rampa ASCII
// z        | shadeRamp         | rampa ASCII de sombra para brilho
// aa       | rowIndex          | índice de linha para limpar e desenhar
// ab       | colIndex          | índice de coluna para limpar e desenhar
// ac       | outputRow         | linha completa montada para o escreval
// ad       | sinTubeStep       | seno do passo angular do tubo
// ae       | cosTubeStep       | cosseno do passo angular do tubo
// af       | sinRingStep       | seno do passo angular do anel principal
// ag       | cosRingStep       | cosseno do passo angular do anel principal
// ah       | tempTrig          | valor temporário para a recorrência trigonométrica
// ak       | speedMultiplier   | multiplicador de velocidade da animação
// -----------------------------------------------------------------------------
// Observação: a variável "e" foi pulada porque "e" já é operador lógico do
// VisuAlg.
// -----------------------------------------------------------------------------
