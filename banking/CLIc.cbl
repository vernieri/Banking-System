      ******************************************************************
      * Author: Vernieri
      * Date: September 21, 2018
      * Purpose: Banking C.R.U.D
      * Tectonics: cobc
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    CLIENTE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.        DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
              SELECT CLIENTES ASSIGN TO DISK
              ORGANIZATION SEQUENTIAL
              ACCESS MODE SEQUENTIAL
              FILE STATUS ARQST.

       DATA DIVISION.
       FILE SECTION.
       FD CLIENTES LABEL RECORD STANDARD
                DATA RECORD IS REG-CLI
                VALUE OF FILE-ID IS "PRODUTOS.DAT".
          01 REG-CLI.
                02 CODIGO         PIC 9(04).
                02 NOME           PIC X(30).
                02 DATANASC       PIC 9(04).
                02 SALDO          PIC 9(05)V99.
                02 TOTAL          PIC 9(06)V99.

       WORKING-STORAGE SECTION.
          01 REG-CLI-E.
                02 CODIGO-E       PIC Z.ZZ9.
                02 NOME-E         PIC X(30).
                02 DATANASC-E       PIC Z.ZZ9.
                02 SALDO-E     PIC ZZ.ZZ9,99.
                02 TOTAL-E        PIC ZZZ.ZZ9,99.
          01 REG-CLI-W.
                02 CODIGO-W         PIC 9(04).
                02 NOME-W           PIC X(30).
                02 DATANASC-W         PIC 9(04).
                02 SALDO-W       PIC 9(05)V99.
                02 TOTAL-W          PIC 9(06)V99.
          01 DATA-SIS.
                02 ANO            PIC 9(04).
                02 MES            PIC 9(02).
                02 DIA            PIC 9(02).

         01 ARQST                   PIC X(02).
         01 WS-OPCAO                PIC X(01) VALUE SPACES.
         01 WS-SALVA                PIC X(01) VALUE SPACES.
         01 WS-ESPACO               PIC X(30) VALUE SPACES.
         01 WS-MENS1                PIC X(20) VALUE "FIM DE PROGRAMA".
         01 WS-FL                   PIC 9(01) VALUE ZEROS.

       SCREEN SECTION.
         01 TELA.
              02 BLANK SCREEN.
              02 LINE 2  COL 5  VALUE "  /  /  ".
              02 COL 29  VALUE "CONTROLE BANCARIO".
              02 LINE 4  COL 19 VALUE "CODIGO DA CONTA:".
              02 LINE 6  COL 19 VALUE "NOME DO OWNER:".
              02 LINE 8  COL 19 VALUE "IDADE:".
              02 LINE 10 COL 19 VALUE "SALDO:".
              02 LINE 12 COL 19 VALUE "SALDO TOTAL:".
              02 LINE 15 COL 25 VALUE "MENSAGEM:".
      
       PROCEDURE DIVISION.
       INICIO.
              PERFORM ABRE-ARQ.
              PERFORM PROCESSO UNTIL WS-OPCAO = "N".
              PERFORM FINALIZA.

       ABRE-ARQ.
              OPEN I-O CLIENTES.
              IF ARQST NOT = "00"
                     CLOSE CLIENTES
                     OPEN OUTPUT CLIENTES.

       PROCESSO.
              PERFORM IMP-TELA.
              PERFORM ENTRA-DADOS.
              PERFORM MOSTRA-DADOS.
              PERFORM CONTINUA  UNTIL WS-OPCAO = "S" OR "N".

       IMP-TELA.
              DISPLAY TELA.
              MOVE FUNCTION CURRENT-DATE TO DATA-SIS.
              DISPLAY DIA   AT 0205.
              DISPLAY MES   AT 0208.
              DISPLAY ANO   AT 0211.
      * ----------------------------- Inicialização das variáveis
              MOVE SPACE  TO     WS-OPCAO
                                 WS-SALVA
                                 NOME-E.
              MOVE ZEROS  TO     CODIGO-E
                                 DATANASC-E
                                 SALDO-E
                                 TOTAL-E
                                 WS-FL.
       ENTRA-DADOS.
              PERFORM IMP-TELA.
              PERFORM ENTRA-CODIGO UNTIL WS-FL = 1.
              DISPLAY WS-ESPACO AT 2030.
              MOVE   CODIGO-W   TO CODIGO-E.
              MOVE   NOME-W     TO NOME-E.
              MOVE   DATANASC-W   TO DATANASC-E.
              MOVE   SALDO-W TO SALDO-E.
              MOVE   TOTAL-W TO TOTAL-E.

       MOSTRA-DADOS.
           DISPLAY NOME-E     AT 0636.
           DISPLAY DATANASC-E AT 0831.
           DISPLAY SALDO-E    AT 1035.
           DISPLAY TOTAL-E    AT 1232.




       ENTRA-CODIGO.
              ACCEPT CODIGO-E   AT 0438 WITH PROMPT AUTO.
              MOVE   CODIGO-E   TO CODIGO-W.
              IF CODIGO-W = 9999
                 DISPLAY WS-MENS1 AT 1535
                 CLOSE CLIENTES
                 STOP RUN.
              CLOSE CLIENTES.
              PERFORM ABRE-ARQ.
              MOVE ZEROS TO WS-FL.
              PERFORM LER-REGISTRO UNTIL WS-FL >= 1.
              IF WS-FL = 2
                 DISPLAY "REGISTO NAO CADASTRADO" AT 2030.

       LER-REGISTRO.
              READ CLIENTES NEXT AT END MOVE 2 TO WS-FL.
              IF ARQST = "00"
                 IF CODIGO-W = CODIGO
                    MOVE REG-CLI TO REG-CLI-W
                    MOVE 1 TO WS-FL.

       CONTINUA.
              DISPLAY "CONTINUA (S/N)? [ ]" AT 1430.
              ACCEPT WS-OPCAO AT 1447 WITH PROMPT AUTO.
              IF WS-OPCAO = "S" OR = "N"
                     DISPLAY WS-ESPACO AT 1430
                     DISPLAY WS-ESPACO AT 1535
              ELSE
                     DISPLAY WS-ESPACO AT 1535
                     DISPLAY "DIGITE S OU N" AT 1535.

       FINALIZA.
              DISPLAY WS-MENS1 AT 1535.
              CLOSE CLIENTES.
              STOP RUN.
      
