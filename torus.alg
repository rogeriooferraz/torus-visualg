                                                                                                 algoritmo               "torus"
                                                                                                               var
                                                                                 a,                            b:                           real
                                                                          c:            vetor[0..39,           0..118]           de           caractere
                                                                     d:               vetor[0..39,               0..118]               de               real
                                                                f,                             g,                             h:                             real
                                                            i,                                               j:                                               inteiro
                                                        k,                          l,                         m,                         n:                         real
                                                    o,                            p,                           q,                           r:                           real
                                                 s,                             t,                             u,                             v:                            real
                                              w,                                        x,                                        y:                                        inteiro
                                           z:                                                                                                                                caractere
                                        aa,                                                                  ab:                                                                  inteiro
                                      ac:                                                                                                                                         caractere
                                    ad,                                                                        ae:                                                                       real
                                 af,                                                              ag:                                                                                       real
                               ah:                                                                                                                                                            real
                              ai,                                                       aj:                                                                                               caractere
                            ak:                                                                                                                                                                  real
                                                                                                                                                                                                 inicio
                        f                                                  <-                                                                                                           3.141592653589793
                       a                                                         <-                                                                                                                      1
                     b                                                         <-                                                                                                                          1
                    g             <-             (2             *             f                                                                                *             11)            /            6280
                   h             <-             (2             *             f                                                                                    *            5)            /            6280
                  ak                                                        <-                                                                                                                                6
                z                                                  <-                                                                                                                            ".,-~:;=+!*#$%@"
               ad                                                    <-                                                                                                                                  sen(0.12)
              ae                                                    <-                                                                                                                                    cos(0.12)
             af                                                    <-                                                                                                                                      sen(0.04)
             ag                                                   <-                                                                                                                                       cos(0.04)
            ai                         <-                         carac(27)                                                                                                             +                        "[H"
           aj                        <-                        carac(27)                                                                                                               +                       "[?25l"
                                                                                                                                                                                                              limpatela
          escreva(aj)
         enquanto                         (1                         =                                                                                                                    1)                        faca
         o                                                      <-                                                                                                                                                cos(a)
        p                                                      <-                                                                                                                                                  sen(a)
        q                                                      <-                                                                                                                                                  cos(b)
       r                                                      <-                                                                                                                                                    sen(b)
       para                 aa                 de                0                                                                                                               ate                39                faca
       para                 ab                de                0                                                                                                               ate                118                faca
       c[aa,                                   ab]                                                                                                                                 <-                                  " "
       d[aa,                                   ab]                                                                                                                                  <-                                   0
       fimpara
                                                                                                                                                                                                                    fimpara
       k                                                        <-                                                                                                                                                       1
       l                                                        <-                                                                                                                                                       0
       para                 i                 de                 0                                                                                                               ate                52                faca
       m                                                        <-                                                                                                                                                       0
       n                                                        <-                                                                                                                                                       1
       para                 j                 de                0                                                                                                               ate                157                faca
        s                  <-                  22                  +                                                                                                              4.2                 *                 k
        t                           <-                           4.2                                                                                                                        *                           l
         u       <-       1       /       (m       *       s       *                                                                                                  p       +       t       *       o       +      28)
         v           <-           m           *           s          *                                                                                                     o          -          t          *          p
          w      <-      int(60      +      18      *      u      *      (n                                                                                               *     s     *     q     -     v     *     r))
          x      <-      int(20      +      8      *      u      *      (n                                                                                               *      s     *     r     +     v     *     q))
           y   <-   int(6   +   4.5   *   ((l   *  p  -  m  *  k  *  o)  *  q                                                                                         -  m  *  k  *  p  -  l  *  o  -  n  *  k  *  r))
            se                          (y                          <                                                                                                               0)                          entao
             y                                                       <-                                                                                                                                            0
                                                                                                                                                                                                               fimse
              se                          (y                          >                                                                                                           13)                         entao
               y                                                        <-                                                                                                                                      13
                fimse
                  se      (x     >=     0)     e     (x     <     40)     e                                                                              (w     >=     0)     e     (w     <     119)     entao
                   se                    (u                    >                                                                                           d[x,                    w])                   entao
                    d[x,                                     w]                                                                                                       <-                                    u
                     c[x,              w]              <-              copia(z,                                                                               y              +             1,             1)
                                                                                                                                                                                                     fimse
                        fimse
                          ah              <-              m              *             ag                                                                  +             n             *             af
                            n              <-              n              *              ag                                                             -              m             *             af
                              m                                                            <-                                                                                                    ah
                               fimpara
                                 ah                <-               l               *               ae                                        +               k               *               ad
                                    k                  <-                  k                  *                  ae                  -                 l                 *                 ad
                                      l                                                                        <-                                                                        ah
                                                                                                             fimpara
                                           ac                                                                   <-                                                                  ai
                                              para                    aa                   de                   0                   ate                   39                   faca
                                                 para                  ab                  de                  0                  ate                  118                  faca
                                                    ac                      <-                     ac                     +                     c[aa,                     ab]
                                                                                                             fimpara
                                                            ac                       <-                      ac                      +                      carac(10)
                                                                                                             fimpara
                                                                                                           escreva(ac)
                                                                          a            <-            a           +           g           *           ak
                                                                                 b         <-         b         +         h         *         ak
                                                                                                           fimenquanto
                                                                                                          fimalgoritmo
