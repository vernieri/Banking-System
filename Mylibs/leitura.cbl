      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    LEITURA.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.        DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
              SELECT ACCOUNTS ASSIGN TO DISK
              ORGANIZATION SEQUENTIAL
              ACCESS MODE SEQUENTIAL
              FILE STATUS ARQST.

       DATA DIVISION.
       FILE SECTION.
       FD ACCOUNTS LABEL RECORD STANDARD
           DATA RECORD IS REG-ACC
           VALUE OF FILE-ID IS "ACCOUNT.DAT".

       01 REG-ACC.
           02 CODIGO       PIC 9(06).
           02 NOME         PIC X(30).
           02 EMAIL        PIC A(30).
           02 PROFISSAO    PIC X(20).
           02 SALARIO      PIC 9(05).
           02 DEPARTAMENTO PIC X(10).

       WORKING-STORAGE SECTION.
       01 REG-ACC-W.
           02 W-CODIGO       PIC 9(06).
           02 W-NOME         PIC X(30).
           02 W-EMAIL        PIC A(30).
           02 W-PROFISSAO    PIC X(20).
           02 W-SALARIO      PIC 9(05).
           02 W-DEPARTAMENTO PIC X(10).

       01 DATA-SIS.
           02 ANO            PIC 9(04).
           02 MES            PIC 9(02).
           02 DIA            PIC 9(02).

       01 ARQST              PIC 9(02).
       01 FLAG.
           02 OP             PIC X(01) VALUE SPACE.
           02 SALVA          PIC X(01) VALUE SPACE.
           02 ERR            PIC X(06) VALUE "ERRO!".
           02 WS-FL             PIC 9(01) VALUE ZERO.

       SCREEN SECTION.
       01 TELA-LEITURA.
           02 BLANK SCREEN.
           02 LINE 2  COL 5  VALUE "  /  /  ".
           02 LINE 2  COL 29  VALUE "PESQUISA FUNCIONARIO".
           02 LINE 4  COL 10 VALUE "CODIGO:".
           02 LINE 7  COL 10 VALUE "NOME:".
           02 LINE 8  COL 10 VALUE "EMAIL:".
           02 LINE 9 COL 10 VALUE "PROFISSAO:".
           02 LINE 10 COL 10 VALUE "SALARIO:".
           02 LINE 11 COL 10 VALUE "DEPARTAMENTO:".
           02 LINE 13 COL 10 VALUE "PROXIMO?<S/N>".

       PROCEDURE DIVISION.
       INICIO.
           PERFORM ABRE-ARQ.
           PERFORM PROCESSO.
           PERFORM FINALIZA.

       ABRE-ARQ.
           OPEN I-O ACCOUNTS.
           IF ARQST NOT = "00"
               CLOSE ACCOUNTS
               OPEN OUTPUT ACCOUNTS.

       PROCESSO.
           DISPLAY TELA-LEITURA.
           PERFORM ENTRA-CODIGO.


       ENTRA-CODIGO.
           ACCEPT W-CODIGO AT 0438 WITH PROMPT AUTO.
           IF W-CODIGO = 9999
              CLOSE ACCOUNTS
              STOP RUN.
           CLOSE ACCOUNTS.
           PERFORM ABRE-ARQ.
           MOVE ZEROS TO WS-FL.
           PERFORM LER-REGISTRO UNTIL WS-FL >= 1.
           IF WS-FL = 2
              DISPLAY "REGISTO NAO CADASTRADO" AT 2030.

       LER-REGISTRO.
           READ ACCOUNTS NEXT AT END MOVE 2 TO WS-FL.
           IF ARQST = "00"
              IF W-CODIGO = CODIGO
                 MOVE REG-ACC TO REG-ACC-W
                 MOVE 1 TO WS-FL.

           PERFORM PRINTA.

       PRINTA.
           DISPLAY W-NOME AT 0740.
           DISPLAY W-EMAIL AT 0840.
           DISPLAY W-PROFISSAO AT 0940.
           DISPLAY W-SALARIO AT 1040.
           DISPLAY W-DEPARTAMENTO AT 1140.
           ACCEPT OP AT 1340.
           IF OP = "S" or "s"
               perform PROCESSO.

       FINALIZA.
           CLOSE ACCOUNTS.
           STOP RUN.
      
