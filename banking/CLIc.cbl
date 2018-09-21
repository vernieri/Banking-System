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
              02 COL 29  VALUE "CONTROLE DE MERCADORIAS".
              02 LINE 4  COL 19 VALUE "CODIGO DO PRODUTO:".
              02 LINE 6  COL 19 VALUE "NOME DO PRODUTO:".
              02 LINE 8  COL 19 VALUE "QUANTIDADE:".
              02 LINE 10 COL 19 VALUE "CUSTO UNITARIO:".
              02 LINE 12 COL 19 VALUE "CUSTO TOTAL:".
              02 LINE 15 COL 25 VALUE "MENSAGEM:".
      
