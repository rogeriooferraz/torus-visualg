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

algoritmo "readable-torus-for-windows-ptbr"

// Versão legível em VisuAlg da clássica animação ASCII de toro.
// Alvo: console gráfico clássico do VisuAlg no Windows.
// O código evita sequências ANSI de terminal e redesenha com limpatela.

var

   angleAxial, angleElevation: real

   charBuffer: vetor[0..39, 0..118] de caractere
   depthBuffer: vetor[0..39, 0..118] de real

   piValue: real
   axialStep, elevationStep: real
   speedMultiplier: real

   tubeIndex, ringIndex: inteiro

   cosTube, sinTube: real
   sinRing, cosRing: real

   cosAxial, sinAxial: real
   cosElevation, sinElevation: real

   ringDistance, tubeYOffset: real
   inverseDepth, rotatedY: real

   screenCol, screenRow: inteiro
   shadeIndex: inteiro

   shadeRamp: caractere

   rowIndex, colIndex: inteiro
   outputRow: caractere

   sinTubeStep, cosTubeStep: real
   sinRingStep, cosRingStep: real
   tempTrig: real

inicio

   piValue <- 3.141592653589793

   // Orientação inicial.
   angleAxial <- 1
   angleElevation <- 1

   // Relação original da animação:
   // 11 giros axiais para cada 5 giros de inclinação.
   axialStep <- (2 * piValue * 11) / 6280
   elevationStep <- (2 * piValue * 5) / 6280

   // O console gráfico do VisuAlg é mais lento que uma animação em navegador/terminal,
   // por isso cada quadro exibido avança mais a rotação.
   speedMultiplier <- 4

   // Da sombra ao brilho.
   shadeRamp <- ".,-~:;=+!*#$%@"

   // Passos fixos de amostragem para os laços do tubo e do anel.
   sinTubeStep <- sen(0.12)
   cosTubeStep <- cos(0.12)
   sinRingStep <- sen(0.04)
   cosRingStep <- cos(0.04)

   enquanto (1 = 1) faca

      // Calcula as duas rotações globais deste quadro.
      cosAxial <- cos(angleAxial)
      sinAxial <- sen(angleAxial)
      cosElevation <- cos(angleElevation)
      sinElevation <- sen(angleElevation)

      // Limpa o buffer de tela e o buffer de profundidade.
      para rowIndex de 0 ate 39 faca
         para colIndex de 0 ate 118 faca
            charBuffer[rowIndex, colIndex] <- " "
            depthBuffer[rowIndex, colIndex] <- 0
         fimpara
      fimpara

      // O laço do tubo começa no ângulo 0: cos=1, sen=0.
      cosTube <- 1
      sinTube <- 0

      para tubeIndex de 0 ate 52 faca

         // O laço do anel começa no ângulo 0: cos=1, sen=0.
         sinRing <- 0
         cosRing <- 1

         para ringIndex de 0 ate 157 faca

            // Geometria do toro: percorre o tubo e depois o anel.
            ringDistance <- 22 + 4.2 * cosTube
            tubeYOffset <- 4.2 * sinTube

            // Perspectiva: pontos mais próximos recebem inverseDepth maior.
            inverseDepth <- 1 / (sinRing * ringDistance * sinAxial + tubeYOffset * cosAxial + 28)

            // Rotaciona em torno do ângulo axial.
            rotatedY <- sinRing * ringDistance * cosAxial - tubeYOffset * sinAxial

            // Projeta o ponto 3D na tela de texto 120 x 40.
            screenCol <- int(60 + 18 * inverseDepth * (cosRing * ringDistance * cosElevation - rotatedY * sinElevation))
            screenRow <- int(20 + 8 * inverseDepth * (cosRing * ringDistance * sinElevation + rotatedY * cosElevation))

            // Iluminação: converte a direção da superfície em índice na rampa ASCII.
            shadeIndex <- int(6 + 4.5 * ((sinTube * sinAxial - sinRing * cosTube * cosAxial) * cosElevation - sinRing * cosTube * sinAxial - sinTube * cosAxial - cosRing * cosTube * sinElevation))

            se (shadeIndex < 0) entao
               shadeIndex <- 0
            fimse

            se (shadeIndex > 13) entao
               shadeIndex <- 13
            fimse

            // Mantém os pontos dentro do console e guarda apenas o mais próximo por célula.
            se (screenRow >= 0) e (screenRow < 40) e (screenCol >= 0) e (screenCol < 119) entao
               se (inverseDepth > depthBuffer[screenRow, screenCol]) entao
                  depthBuffer[screenRow, screenCol] <- inverseDepth
                  charBuffer[screenRow, screenCol] <- copia(shadeRamp, shadeIndex + 1, 1)
               fimse
            fimse

            // Avança sen/cos ao redor do anel sem chamar sen/cos novamente.
            tempTrig <- sinRing * cosRingStep + cosRing * sinRingStep
            cosRing <- cosRing * cosRingStep - sinRing * sinRingStep
            sinRing <- tempTrig

         fimpara

         // Avança sen/cos ao redor do tubo sem chamar sen/cos novamente.
         tempTrig <- sinTube * cosTubeStep + cosTube * sinTubeStep
         cosTube <- cosTube * cosTubeStep - sinTube * sinTubeStep
         sinTube <- tempTrig

      fimpara

      // Redesenha o console gráfico do VisuAlg, uma linha de texto por vez.
      limpatela

      para rowIndex de 0 ate 39 faca
         outputRow <- ""
         para colIndex de 0 ate 118 faca
            outputRow <- outputRow + charBuffer[rowIndex, colIndex]
         fimpara
         escreval(outputRow)
      fimpara

      // O movimento acontece aqui: avança os dois ângulos antes do próximo quadro.
      angleAxial <- angleAxial + axialStep * speedMultiplier
      angleElevation <- angleElevation + elevationStep * speedMultiplier

   fimenquanto

fimalgoritmo
