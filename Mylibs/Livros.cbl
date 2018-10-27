       Identification Division.
       Program-Id.  Livros.

       Environment Division.
       CONFIGURATION SECTION.
           Special-names.   decimal-point is comma.

       INPUT-OUTPUT SECTION.
       File-Control.
           Select BBLIVROS assign to disk
           organization indexed
           access mode dynamic
           record key tombo
           alternate record key titulo with duplicates
           file status arqst.

       Data Division.
       File Section.
       FD  BBLIVROS label record standard
           value of file-id is "bblivros.dat".
       01 reg-livro.
           02 tombo        pic 9(06).
           02 titulo       pic x(30).
           02 autor        pic x(20).
           02 editora      pic x(15).
           02 ano-livro    pic 9(04).
           02 doacao       pic x(01).
           02 doador       pic x(20).
           02 preco        pic 9(04)V99.
           02 procedencia  pic x(20).
           02 emprestado   pic 9(05).

       Working-storage section.
       01 w-reg-livro.
           02 w-tombo        pic 9(06).
           02 w-titulo       pic x(30).
           02 w-autor        pic x(20).
           02 w-editora      pic x(15).
           02 w-ano-livro    pic 9(04).
           02 w-doacao       pic x(01).
           02 w-doador       pic x(20).
           02 w-preco        pic 9(04)V99.
           02 w-procedencia  pic x(20).
           02 w-emprestado   pic 9(05).

       01 editadas.
           02 w-tombo-e      pic ZZZ.ZZ9.
           02 w-preco-e      pic Z.ZZ9,99.

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
           02 line 4 col 29 value "Codastro de Livros" highlight.
           02 line 6 col 29 value "1. Inclusao".
           02 line 8 col 29 value "2. Alteracao".
           02 line 10 col 29 value "3. Exclusao".
           02 line 12 col 29 value "4. Consulta por Tombo".
           02 line 14 col 29 value "5. Consulta por Titulo".
           02 line 16 col 29 value "6. Retorno".
           02 line 18 col 25 value "Escolha uma Opcao:".

       01 tela-cadastro.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 2 col 45 value "Video Locadora" highlight.
           02 line 4 col 29 value "Cadastro de Livros" highlight.
           02 line 8 col 19 value "Tombo: ".
           02 line 9 col 19 value "Titulo: ".
           02 line 10 col 19 value "Autor: ".
           02 line 11 col 19 value "Editora: ".
           02 line 12 col 19 value "Ano: ".
           02 line 13 col 19 value "Doacao: ".
           02 line 14 col 19 value "Doador: ".
           02 line 15 col 19 value "Preco: ".
           02 line 16 col 19 value "Procedencia: ".
