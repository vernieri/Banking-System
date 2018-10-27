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
