      ******************************************************************
      * Author: Joao Victor && Julio Cesar
      * Date: 20/11/2018
      * Purpose: Fins academicos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Emprestimo.
       Environment Division.
       CONFIGURATION SECTION.
           Special-names.   decimal-point is comma.
       INPUT-OUTPUT SECTION.
       File-Control.
           Select BBMOVIM assign to disk
           organization indexed
           access mode dynamic
           record key numero
           alternate record key tombo with duplicates
           file status arqst.

       Select BBLIVROS assign to disk
           organization indexed
           access mode dynamic
           record key tombo-li
           alternate record key titulo with duplicates
           file status arqst.

       Select BBSOCIOS assign to disk
           organization indexed
           access mode dynamic
           record key numero-so
           alternate record key nome with duplicates
           file status arqst.

       Data Division.
       File Section.
       FD  BBMOVIM label record standard
           value of file-id is "bbmovim.dat".
       01 reg-movim.
           02 numero           pic 9(05).
           02 tombo            pic 9(06).
           02 data-retirada.
             03 data-retirada-dia pic 9(02).
             03 data-retirada-mes pic 9(02).
             03 data-retirada-ano pic 9(04).

           02 data-devolucao.
             03 data-devolucao-dia pic 9(02).
             03 data-devolucao-mes pic 9(02).
             03 data-devolucao-ano pic 9(04).

       FD  BBLIVROS label record standard
       value of file-id is "bblivros.dat".
       01 reg-livro.
           02 tombo-li     pic x(05).
           02 titulo       pic x(30).
           02 autor        pic x(20).
           02 editora      pic x(15).
           02 ano-livro    pic 9(04).
           02 doacao       pic x(01).
           02 doador       pic x(20).
           02 preco        pic 9(04)V99.
           02 procedencia  pic x(20).
           02 emprestado   pic 9(05).
       FD BBSOCIOS label record STANDARD
       value of FILE-ID is "bbsocios.dat".
       01 reg-socio.
           02 numero-so    pic 9(05).
           02 nome         pic x(30).
           02 endereco     pic x(60).
           02 cidade       pic x(20).
           02 telefone     pic x(10).
           02 livros       pic 9(20).   

       Working-storage section.
       01 w-reg-movim.
           02 w-numero             pic 9(05).
           02 w-tombo              pic x(06).
           02 w-data-retirada.
             03 w-data-retirada-dia pic 9(02).
             03 w-data-retirada-mes pic 9(02).
             03 w-data-retirada-ano pic 9(04).

           02 w-data-devolucao.
             03 w-data-devolucao-dia pic 9(02).
             03 w-data-devolucao-mes pic 9(02).
             03 w-data-devolucao-ano pic 9(04).

       01 editadas.
           02 w-numero-e      pic  ZZ.ZZ9.
           02 w-tombo-e       pic ZZZ.ZZ9.
       01 w-reg-livro.
           02 w-tombo-li     pic 9(06).
           02 w-titulo       pic x(30).
           02 w-autor        pic x(20).
           02 w-editora      pic x(15).
           02 w-ano-livro    pic 9(04).
           02 w-doacao       pic x(01).
           02 w-doador       pic x(20).
           02 w-preco        pic 9(04)V99.
           02 w-procedencia  pic x(20).
           02 w-emprestado   pic 9(05).
       01 w-reg-socio.
           02 w-numero-so    pic 9(05).
           02 w-nome         pic x(30).
           02 w-endereco     pic x(60).
           02 w-cidade       pic x(20).
           02 w-telefone     pic x(10).
           02 w-livros       pic x(20).
       01 editadas.
           02 w-tombo-li-e      pic ZZZ.ZZ9.
           02 w-preco-e      pic Z.ZZ9,99.
       01 data-sis.
           02 ano   pic 9(04).
           02 mes   pic 9(02).
           02 dia   pic 9(02).
       01 desmes.
           02 filler pic x(10) value "Janeiro".
           02 filler pic x(10) value "Fevereiro".
           02 filler pic x(10) value "MarÃ§o".
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
       01 multa        pic 9(06) value zeros.
       01 op           pic 9(01) value zeros.
       01 salva        pic x(01) value spaces.
       01 check        pic 9(06) value zeros.
       01 wflag        pic 9(01) value zeros.
       01 espaco       pic x(30) value spaces.
       01 op-continua  pic x(01) value spaces.
      
       Screen Section.
       01 tela-menu.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de            de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "EMPRESTIMO" highlight.
           02 line 12 col 29 value "1. Registrar Emprestimo".
           02 line 16 col 29 value "9. Retorno".
           02 line 18 col 25 value "Escolha uma Opcao:".

       01 tela-emprestimo.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Emprestimo de Livro" highlight.
           02 line 8 col 19 value "Tombo: ".
           02 line 9 col 19 value "Numero:".
           02 line 10 col 19 value "Data de retirada: ".
           02 line 13 col 19 value "Deseja emprestar? <S/N>".

       Procedure Division.
       Inicio.
           Perform Abre-arq1.
           Perform Abre-arq2.
           Perform Abre-arq3.
           Move function current-date to data-sis.
           Perform Processo until op = 9.
           Perform Finaliza.
           stop run.
       Abre-arq1.
           Open i-o BBMOVIM.
           If arqst not = "00"
               Display "erro de abertura" at 2110
               Close BBMOVIM
               Open output BBMOVIM.
       Abre-arq2.
           Open i-o BBLIVROS.
           If arqst not = "00"
               Display "erro de abertura" at 2110
               Close BBLIVROS
               Open output BBLIVROS.
       Abre-arq3.
           Open i-o BBSOCIOS.
               If arqst not = "00"
               Display "erro de abertura" at 2110
               Close BBLIVROS
               Open output BBLIVROS.      

       atualiza-livros.
           move w-tombo-li to tombo-li.
           read BBSOCIOS key is tombo-li
               invalid key
                   display "Livro nao encontrado!" at 1835
               not invalid key
                   compute emprestado = emprestado + 1
                   write reg-livro invalid key perform estuda-erro..
      

       atualiza-socios.
           move w-numero-so to numero-so.
           read BBSOCIOS key is numero-so
               invalid key
                   display "Socio nao encontrado!" at 1835
               not invalid key
                   if livros > 3
                       display "Socio ja atingiu o limite"
                       perform Processo
                   else
                       compute livros = livros + 1
                       write reg-socio invalid key perform estuda-erro.

       emprestimo.
           Display tela-emprestimo.
           accept w-tombo-li at 0827.
           move w-tombo-li to tombo-li
           READ BBSOCIOS key is tombo-li INVALID KEY perform
           estuda-erro.
           accept w-numero-so at 0930.
           move w-numero-so to numero-so.
           READ BBLIVROS key is numero-so
           INVALID KEY perform estuda-erro.
           Move function current-date to w-data-retirada.
           display w-data-retirada at 1040.
           perform atualiza-socios.
           perform atualiza-livros.
           accept op at 1345.
           if op = "S" or "s"
              write reg-livro invalid key perform estuda-erro
           ELSE
              PERFORM Processo.      

       Estuda-erro.
           display "Erro! Registro Nao encontrado!." at 2121.
           display arqst at 2221.
           stop " ".      

        Processo.
           Perform mostra-tela-menu.
           move zeros to op.
           move zeros to w-reg-movim.
           move spaces to op-continua.
           Accept op-continua at 1845 with prompt auto.
           Evaluate op-continua
           when 1
               perform emprestimo until op-continua = "n" or "N"
           when 9
               perform retorno until op-continua = "n" or "N".     

       Retorno.
           Perform Processo.

       Mostra-tela-menu.
           Display tela-menu.
           Display mes-t(mes) at 0219.
           move zeros to op.      

       Finaliza.
           close BBMOVIM.
           close BBLIVROS.
           close BBSOCIOS.
           Display "F I M   D O   P R O G R A M A" at 1530.
      
