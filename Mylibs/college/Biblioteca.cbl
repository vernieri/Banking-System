       IDENTIFICATION DIVISION.
       PROGRAM-ID. Biblioteca.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 Opcoes.
           02 opcMenu1  PIC 9 VALUE ZEROS.
           02 opcMenu2  PIC 9 VALUE ZEROS.
           02 opcMenu3  PIC 9 VALUE ZEROS.
           02 opcSair   PIC X.
           02 opcCad    PIC 9.
           02 opcMov    PIC 9.
           02 opcFim    PIC X.
           02 opcKey    PIC X.

       01 Data-do-Sistema.
           02 ds-ano   PIC 9(04) VALUE ZEROS.
           02 ds-mes   PIC 9(02) VALUE ZEROS.
           02 ds-dia   PIC 9(02) VALUE ZEROS.

       01 Mensagens.
           02 msg-ctz  PIC X(22) VALUE "Tem certeza? (S/N) [ ]".
           02 msg-opc  PIC X(26) VALUE "Digite opcao desejada: [ ]".
           02 msg-vol  PIC X(28) VALUE "Tecle algo para continuar...".
           02 msg-inv  PIC X(41) VALUE
                       "Opcao invalida, tecle algo para voltar...".

       SCREEN SECTION.

       01 Limpa-a-Tela.
           03 BLANK SCREEN.

       01 Cabecalho.
           02 LINE 02 COL 02  VALUE "Santos,   /  /  "
               FOREGROUND-COLOR 6.
           02 LINE 02 COL 62  VALUE "BIBLIOTECA CENTRAL"
               FOREGROUND-COLOR 6.

       01 Tela-Principal.
           03 LINE 04 COL 25 VALUE "M e n u   P r i n c i p a l"
               FOREGROUND-COLOR 11.
           03 LINE 09 COL 32 VALUE "[1]"
               FOREGROUND-COLOR 3.
           03 LINE 09 COL 36 VALUE "CADASTRO"
               FOREGROUND-COLOR 6.
           03 LINE 11 COL 32 VALUE "[2]"
               FOREGROUND-COLOR 3.
           03 LINE 11 COL 36 VALUE "MOVIMENTO"
               FOREGROUND-COLOR 6.
           03 LINE 13 COL 32 VALUE "[3]"
               FOREGROUND-COLOR 3.
           03 LINE 13 COL 36 VALUE "SOBRE"
               FOREGROUND-COLOR 6.
           03 LINE 15 COL 32 VALUE "[4]"
               FOREGROUND-COLOR 3.
           03 LINE 15 COL 36 VALUE "FIM"
               FOREGROUND-COLOR 6.

       01 Tela-Cadastro.
           03 LINE 04 COL 25 VALUE "C A D A S T R O"
               FOREGROUND-COLOR 11.
           03 LINE 09 COL 32 VALUE "[1]"
               FOREGROUND-COLOR 3.
           03 LINE 09 COL 36 VALUE "LIVROS"
               FOREGROUND-COLOR 6.
           03 LINE 11 COL 32 VALUE "[2]"
               FOREGROUND-COLOR 3.
           03 LINE 11 COL 36 VALUE "SOCIOS"
               FOREGROUND-COLOR 6.
           03 LINE 13 COL 32 VALUE "[3]"
               FOREGROUND-COLOR 3.
           03 LINE 13 COL 36 VALUE "RETORNO"
               FOREGROUND-COLOR 6.

       01 Tela-Movimento.
           03 LINE 04 COL 25 VALUE "M O V I M E N T O"
               FOREGROUND-COLOR 11.
           03 LINE 09 COL 32 VALUE "[1]"
               FOREGROUND-COLOR 3.
           03 LINE 09 COL 36 VALUE "EMPRESTIMO"
               FOREGROUND-COLOR 6.
           03 LINE 11 COL 32 VALUE "[2]"
               FOREGROUND-COLOR 3.
           03 LINE 11 COL 36 VALUE "DEVOLUCAO"
               FOREGROUND-COLOR 6.
           03 LINE 13 COL 32 VALUE "[3]"
               FOREGROUND-COLOR 3.
           03 LINE 13 COL 36 VALUE "RETORNO"
               FOREGROUND-COLOR 6.

       01 Tela-Opcao4-Fim.
           03 LINE 12 COL 23 VALUE "[ F I M   D E   P R O G R A M A ]"
               FOREGROUND-COLOR 14.

      
      PROCEDURE DIVISION.

       INICIO.
           PERFORM PROCESSO UNTIL opcMenu1 = 4.
           DISPLAY Limpa-a-Tela.
           DISPLAY Tela-Opcao4-Fim.
           STOP RUN.

       IMP-CABEC.
           DISPLAY Limpa-a-Tela.
           DISPLAY Cabecalho.
           MOVE FUNCTION CURRENT-DATE TO Data-do-Sistema.
           DISPLAY ds-DIA AT 0210 FOREGROUND-COLOR 6.
           DISPLAY ds-MES AT 0213 FOREGROUND-COLOR 6.
           DISPLAY ds-ANO AT 0216 FOREGROUND-COLOR 6.

       PROCESSO.
           PERFORM IMP-CABEC.
           DISPLAY Tela-Principal.
           DISPLAY msg-opc AT 2125 FOREGROUND-COLOR 11.
           MOVE ZEROS TO opcMenu1.
           ACCEPT opcMenu1 AT 2149 WITH PROMPT AUTO.
           EVALUATE opcMenu1
               WHEN 1
                   PERFORM IMP-CADASTRO UNTIL opcMenu2 = 3
               WHEN 2
                   PERFORM IMP-MOVIMENTO UNTIL opcMenu3 = 3
               WHEN 3
                   PERFORM IMP-SOBRE
           END-EVALUATE.

       IMP-CADASTRO.
           PERFORM IMP-CABEC.
           DISPLAY Tela-Cadastro.
           DISPLAY msg-opc AT 2125 FOREGROUND-COLOR 11.
           MOVE ZEROS TO opcMenu2.
           ACCEPT opcMenu2 AT 2149 WITH PROMPT AUTO.
           EVALUATE opcMenu2
               WHEN 1
                   CALL "Livros"
               WHEN 2
                   CALL "SOCIOS"
           END-EVALUATE.

       IMP-MOVIMENTO.
           PERFORM IMP-CABEC.
           DISPLAY Tela-Movimento.
           DISPLAY msg-opc AT 2125 FOREGROUND-COLOR 11.
           MOVE ZEROS TO opcMenu3.
           ACCEPT opcMenu3 AT 2149 WITH PROMPT AUTO.
           EVALUATE opcMenu3
               WHEN 1
                   CALL "Emprestimo"
               WHEN 2
                   CALL "Devolucao"
           END-EVALUATE.

       IMP-SOBRE.
