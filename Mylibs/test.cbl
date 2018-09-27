      ******************************************************************
      * Author: Vernieri
      * Date: September 27, 2018
      * Purpose: Just a Test
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
               SELECT TESTES ASSIGN TO DISK
               ORGANIZATION SEQUENTIAL
               ACCESS MODE SEQUENTIAL
               FILE STATUS ARQST.

       DATA DIVISION.
       FILE SECTION.
       FD TESTES LABEL RECORD STANDARD
           DATA RECORD IS REG-TEST
           VALUE OF FILE-ID IS "ARQ.DAT".
           01 REG-TEST.
               02 CODIGO   PIC 9(04).
               02 NOME     PIC X(30).


       WORKING-STORAGE SECTION.
       01 REG-TEST-E.
           02 CODIGO-E     PIC Z.ZZ9.
           02 NOME-E       PIC X(30).

       01 REG-TEST-W.
           02 CODIGO-W     PIC 9(04).
           02 NOME-W       PIC X(30).

       01 DATA-SIS.
           02 ANO          PIC 9(04).
           02 MES          PIC 9(02).
           02 DIA          PIC 9(02).

       SCREEN SECTION.
       01 TELA.
           02 BLANK SCREEN.
           02 LINE 2 COL 5 VALUE "  /  /  ".
           02 COL 29 VALUE "TESTE MEU".
           02 LINE 4 COL 19 VALUE "CODIGO: ".
           02 LINE 6 COL 19 VALUE "NOME: ".

       01 ARQST                   PIC X(02).
       01 WS-OPCAO                PIC X(01) VALUE SPACES.
       01 WS-SALVA                PIC X(01) VALUE SPACES.
       01 WS-ESPACO               PIC X(30) VALUE SPACES.
       01 WS-MENS1                PIC X(20) VALUE "FIM DE PROGRAMA".
       01 WS-FL                   PIC 9(01) VALUE ZEROS.

       PROCEDURE DIVISION.
       INICIO.
           PERFORM ABRE-ARQ.
           PERFORM PROCESSO UNTIL WS-OPCAO = "N".
           PERFORM FINALIZA.

       ABRE-ARQ.
           OPEN I-O TESTES.
           IF ARQST NOT = "00"
               CLOSE TESTES
               OPEN OUTPUT TESTES.

       PROCESSO.
           PERFORM IMP-TELA.
           PERFORM ENTRA-DADOS.
           PERFORM GRAVAR UNTIL WS-SALVA = "S" OR "N".
           IF WS-SALVA = "S"
               PERFORM GRAVA-REG
           ELSE
               DISPLAY "REISTRO NAO GRAVADO" AT 2030.
           PERFORM CONTINUA UNTIL WS-OPCAO = "S" OR "N".

       IMP-TELA.
           DISPLAY TELA.
           MOVE FUNCTION CURRENT-DATE TO DATA-SIS.
           DISPLAY DIA AT 0205.
           DISPLAY MES AT 0208.
           DISPLAY ANO AT 0211.
      *-------------------------------

           MOVE SPACE TO   WS-OPCAO
                           WS-SALVA
                           NOME-E.
           MOVE ZEROS TO   CODIGO-E
                           WS-FL.

       ENTRA-DADOS.
           PERFORM ENTRA-CODIGO UNTIL WS-FL = 1.
           DISPLAY WS-ESPACO AT 2030.
           ACCEPT NOME-E AT 0636 WITH PROMPT AUTO.
           MOVE CODIGO-E TO CODIGO-W.
           MOVE NOME-E TO NOME-W.

       ENTRA-CODIGO.
           ACCEPT CODIGO-E AT 0438 WITH PROMPT AUTO.
           MOVE CODIGO-E TO CODIGO-W.
           IF CODIGO-W = 9999
               DISPLAY WS-MENS1 AT 1535
               CLOSE TESTES
               STOP RUN.
           CLOSE TESTES.
           PERFORM ABRE-ARQ.
           MOVE ZEROS TO WS-FL.
           PERFORM LER-REGISTRO UNTIL WS-FL >= 1.
           IF WS-FL = 2
               DISPLAY "REGISTRO JA CADASTRADO" AT 2030.

       LER-REGISTRO.
           READ TESTES NEXT AT END MOVE 1 TO WS-FL.
           IF ARQST = "00"
               IF CODIGO-W = CODIGO
                   MOVE 2 TO WS-FL.

       GRAVAR.
           DISPLAY "SALVAR <S/N>? [  ]" AT 1430.
           ACCEPT WS-SALVA AT 1445 WITH PROMPT AUTO.

       GRAVA-REG.
           CLOSE TESTES.
           OPEN EXTEND TESTES.
           MOVE REG-TEST-W TO REG-TEST.
           WRITE REG-TEST.
           IF ARQST NOT = "00"
               DISPLAY "ERRO DE GRAVACAO" AT 1535.
               STOP " ".
           CLOSE TESTES.
           PERFORM ABRE-ARQ.

       CONTINUA.
           DISPLAY "CONTINUA <S/N>? [  ]".
           ACCEPT WS-OPCAO AT 1447 WITH PROMPT AUTO.
           IF WS-OPCAO = "S" OR = "N"
               DISPLAY WS-ESPACO AT 1430
               DISPLAY WS-ESPACO AT 1535
           ELSE
               DISPLAY WS-ESPACO AT 1535
               DISPLAY "DIGITE S OU N" AT 1535.

       FINALIZA.
           DISPLAY WS-MENS1 AT 1535.
           CLOSE TESTES.
           STOP RUN.
