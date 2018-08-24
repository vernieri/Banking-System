       IDENTIFICATION DIVISION.
       PROGRAM-ID.  EQUACAO-DO-SEGUNDO-GRAU.
       ENVIRONMENT DIVISION.
      *Please Use OpenCobol and Report Bugs
       CONFIGURATION SECTION.
           SPECIAL-NAMES.
               DECIMAL-POINT IS COMMA.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 AREA-TRABALHO.
           02 WS-VAL-A          PIC -ZZ9,9.
           02 WS-VAL-B          PIC -ZZ9,9.
           02 WS-VAL-C          PIC -ZZ9,9.
           02 WS-VAL-DELTA      PIC -ZZ9,9.
           02 WS-VAL-X1         PIC -ZZ9,9.
           02 WS-VAL-X2         PIC -ZZ9,9.
           02 WS-A              PIC S9(03)V9.
           02 WS-B              PIC S9(03)V9.
           02 WS-C              PIC S9(03)V9.
           02 WS-DELTA          PIC S9(03)V9.
           02 WS-X1             PIC S9(03)V9.
           02 WS-X2             PIC S9(03)V9.
           02 VALOR             PIC S9(03)V9.
           02 WS-CONTINUA       PIC X(01) VALUE SPACE.
           02 WS-FL             PIC 9(01) VALUE ZEROS.
       01 MENSAGEMS-DE-TELA.
           02 MENSA1            PIC X(30) VALUE
                "NUMERO NAO PODE SER ZERO".
           02 MENSA2            PIC X(30) VALUE
                "SO EXISTE UMA RAIZ REAL".
           02 MENSA3            PIC X(30) VALUE
                "NAO EXISTEM RAIZES REAIS".
           02 MENSA4            PIC X(30) VALUE
                "F I M   D O   P R O G R A M A".
           02 MENSA5            PIC X(30) VALUE SPACE.
       01 DATA-DO-SISTEMA.
           02 ANO               PIC 9(02) VALUE ZEROS.
           02 MES               PIC 9(02) VALUE ZEROS.
           02 DIA               PIC 9(02) VALUE ZEROS.

       SCREEN SECTION.
       01 TELA01.
           02 BLANK SCREEN.
           02 LINE 02 COLUMN 05 PIC 9(02)/ USING DIA.
           02 LINE 02 COLUMN 08 PIC 9(02)/ USING MES.
           02 LINE 02 COLUMN 11 PIC 9(02)  USING ANO.
           02 LINE 02 COLUMN 28 VALUE
                "CALCULO DA EQUACAO DO 2o. GRAU".
           02 LINE 10 COLUMN 21 VALUE "Valor de A :".
           02 LINE 11 COLUMN 21 VALUE "Valor de B :".
           02 LINE 12 COLUMN 21 VALUE "Valor de C :".
           02 LINE 13 COLUMN 21 VALUE "Delta .....:".
           02 LINE 14 COLUMN 21 VALUE "Valor de X1:".
           02 LINE 15 COLUMN 21 VALUE "Valor de X2:".
           02 LINE 18 COLUMN 21 VALUE "Mensagem ..:".
           02 LINE 20 COLUMN 20 VALUE "CONTINUA (S/N):".

       PROCEDURE DIVISION.
       INICIO.
           PERFORM IMP-TELA.
           PERFORM PROCESSO UNTIL WS-CONTINUA = 'N'.
           PERFORM SAIDA.
           STOP RUN.

       IMP-TELA.
           ACCEPT  DATA-DO-SISTEMA FROM DATE.
           DISPLAY TELA01      AT    0101.

       PROCESSO.
           MOVE    ZEROS       TO    WS-VAL-A
                                     WS-VAL-B
                                     WS-VAL-C
                                     WS-DELTA
                                     WS-X1
                                     WS-X2
                                     WS-FL.
           MOVE    SPACE       TO    WS-CONTINUA.
           PERFORM ENTRA-A     UNTIL WS-FL = 1.
           PERFORM ENTRA-BC.
           PERFORM CALCULA.
           PERFORM RESULTADO.
           PERFORM CONTINUA    UNTIL WS-CONTINUA = "S" OR "N".

       ENTRA-A.
           ACCEPT  WS-VAL-A   AT 1034 WITH PROMPT AUTO.
           MOVE WS-VAL-A TO WS-A.
           IF WS-A = 0
                   DISPLAY    MENSA1  AT  1834
           ELSE
                   DISPLAY    MENSA5  AT  1834
                   MOVE 1     TO WS-FL.

       ENTRA-BC.
           ACCEPT  WS-VAL-B   AT 1134 WITH PROMPT AUTO.
           ACCEPT  WS-VAL-C   AT 1234 WITH PROMPT AUTO.

       CALCULA.
           MOVE    WS-VAL-A   TO  WS-A.
           MOVE    WS-VAL-B   TO  WS-B.
           MOVE    WS-VAL-C   TO  WS-C.
           COMPUTE WS-DELTA = (WS-B ** 2) - (4 * WS-A * WS-C).
           IF WS-DELTA > 0 THEN
                  COMPUTE VALOR = FUNCTION SQRT(WS-DELTA)
                  COMPUTE WS-X1 = (- WS-B + VALOR) / (2 * WS-A)
                  COMPUTE WS-X2 = (- WS-B - VALOR) / (2 * WS-A)
           ELSE
                  IF WS-DELTA = 0 THEN
                         DISPLAY    MENSA2  AT  1834
                         COMPUTE WS-X1 = - WS-B / (2 * WS-A)
                         MOVE   ZEROS  TO WS-X2

                  ELSE
                         DISPLAY    MENSA3  AT  1834
                         MOVE   ZEROS  TO WS-X1
                         MOVE   ZEROS  TO WS-X2.

       RESULTADO.
           MOVE    WS-DELTA   TO  WS-VAL-DELTA.
           MOVE    WS-X1      TO  WS-VAL-X1.
           MOVE    WS-X2      TO  WS-VAL-X2.
           DISPLAY WS-VAL-DELTA  AT  1334.
           DISPLAY WS-VAL-X1     AT  1434.
           DISPLAY WS-VAL-X2     AT  1534.

       CONTINUA.
           ACCEPT  WS-CONTINUA   AT  2036 WITH PROMPT AUTO.

       SAIDA.
           DISPLAY  MENSA4.
