       Identification Division.
       Program-Id.  Socios.

       Environment Division.
       CONFIGURATION SECTION.
           Special-names.   decimal-point is comma.

       INPUT-OUTPUT SECTION.
       File-Control.
           Select BBSOCIOS assign to disk
           organization indexed
           access mode dynamic
           record key Numero
           alternate record key Nome with duplicates
           alternate record key Endereco with duplicates
           file status arqst.

       Data Division.
       File Section.
       FD  BBSOCIOS label record standard
           value of file-id is "bbsocios.dat".
       01 reg-socio.
           02 Numero       pic 9(06).
           02 Nome         pic x(30).
           02 Endereco     pic x(20).
           02 Cidade       pic x(20).
           02 Telefone     pic x(20).
           02 Livros       pic 9(01).


       Working-storage section.
       01 w-reg-socio.
           02 Numero-W       pic 9(06).
           02 Nome-W         pic x(30).
           02 Endereco-W     pic x(20).
           02 Cidade-W       pic x(20).
           02 Telefone-W    pic x(20).
           02 Livros-W       pic 9(01).

       01 e-reg-socio.
           02 Numero-E       pic ZZZZZ9.
           02 Telefone-E     pic XXXXXXXXXXX.

       01 data-sis.
           02 ano   pic 9(04).
           02 mes   pic 9(02).
           02 dia   pic 9(02).

       01 desmes.
           02 filler pic x(10) value "Janeiro".
           02 filler pic x(10) value "Fevereiro".
           02 filler pic x(10) value "Mar‡o".
           02 filler pic x(10) value "Abril".
           02 filler pic x(10) value "Maio".
           02 filler pic x(10) value "Junho".
           02 filler pic x(10) value "Julho".
           02 filler pic x(10) value "Agosto".
           02 filler pic x(10) value "Setembro".
           02 filler pic x(10) value "Outubro".
           02 filler pic x(10) value "Novembro".
           02 filler pic x(10) value "Dezembro".

       01 tabela-meses redefines desmes.
           02 mes-t pic x(10) occurs 12 times.

       01 arqst        pic x(02).
       01 op           pic 9(01) value zeros.
       01 salva        pic x(01) value spaces.
       01 wflag        pic 9(01) value zeros.
       01 espaco       pic x(30) value spaces.
       01 op-continua  pic x(01) value spaces.
      
       Screen Section.
       01 tela-menu.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de            de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 2 col 45 value "Video Locadora" highlight.
           02 line 4 col 29 value "Codastro de Socios" highlight.
           02 line 6 col 29 value  "1. Inclusao".
           02 line 8 col 29 value  "2. Alteracao".
           02 line 10 col 29 value "3. Exclusao".
           02 line 12 col 29 value "4. Consulta por Nome".
           02 line 14 col 29 value "5. Consulta por Endereco".
           02 line 16 col 29 value "6. Retorno".
           02 line 18 col 25 value "Escolha uma Opcao:".
      
       01 tela-cadastro.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 2 col 45 value "Video Locadora" highlight.
           02 line 4 col 29 value "Cadastro de Socios" highlight.
           02 line 8 col 19 value "Numero: ".
           02 line 9 col 19 value "Nome: ".
           02 line 10 col 19 value "Endereco: ".
           02 line 11 col 19 value "Cidade: ".
           02 line 12 col 19 value "Telefone: ".
           02 line 13 col 19 value "Livros: ".
