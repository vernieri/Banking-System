      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    CREATE.
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
           02 FL             PIC 9(01) VALUE ZERO.

       SCREEN SECTION.
       01 TELA-CADASTRO.
           02 BLANK SCREEN.
           02 LINE 2  COL 5  VALUE "  /  /  ".
           02 LINE 2  COL 29  VALUE "CADASTRO FUNCIONARIO".
           02 LINE 4  COL 10 VALUE "CODIGO:".
           02 LINE 6  COL 10 VALUE "NOME:".
           02 LINE 8  COL 10 VALUE "EMAIL:".
           02 LINE 10 COL 10 VALUE "PROFISSAO:".
           02 LINE 12 COL 10 VALUE "SALARIO:".
           02 LINE 14 COL 10 VALUE "DEPARTAMENTO:".
           02 LINE 16 COL 10 VALUE "SALVAR<S/N> ?".

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
           PERFORM IMP-TELA.
           PERFORM ENTRA-DADOS.


       IMP-TELA.
           DISPLAY TELA-CADASTRO.
           MOVE FUNCTION CURRENT-DATE TO DATA-SIS.
           DISPLAY DIA   AT 0205.
           DISPLAY MES   AT 0208.
           DISPLAY ANO   AT 0211.

           MOVE ZEROS TO W-CODIGO.
           MOVE SPACES TO W-NOME.
           MOVE SPACES TO W-EMAIL.
           MOVE SPACES TO W-PROFISSAO.
           MOVE ZEROS TO W-SALARIO.
           MOVE SPACES TO W-DEPARTAMENTO.

           MOVE SPACES TO OP.
           MOVE SPACES TO SALVA.
           MOVE ZERO TO FL.

       ENTRA-DADOS.
           ACCEPT W-CODIGO AT 0440.
           ACCEPT W-NOME AT 0640.
           ACCEPT W-EMAIL AT 0840.
           ACCEPT W-PROFISSAO AT 1040.
           ACCEPT W-SALARIO AT 1240.
           ACCEPT W-DEPARTAMENTO AT 1440.
           ACCEPT SALVA AT 1640 auto PROMPT.
           IF SALVA = "S" OR "s"
              perform gravar.

       GRAVAR.
           CLOSE ACCOUNTS.
           OPEN EXTEND ACCOUNTS.
           MOVE REG-ACC-W TO REG-ACC.
           WRITE REG-ACC.
           IF ARQST NOT = "00"
               DISPLAY "ERRO DE GRAVACAO" AT 2020.
               STOP " ".
           CLOSE ACCOUNTS.
           PERFORM ABRE-ARQ.


       FINALIZA.

           CLOSE ACCOUNTS.
           STOP RUN.
