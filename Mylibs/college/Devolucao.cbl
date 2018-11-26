      ******************************************************************
      * Author: Joao Victor && Julio Cesar
      * Date: 22/11/2018
      * Purpose: Fins academicos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Devolucao.
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
           02 livros       pic x(20).
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
           02 line 4 col 29 value "DEVOLUCAO" highlight.
           02 line 12 col 29 value "1. Devolucao".
           02 line 14 col 29 value "2. Atualizar Data.".
           02 line 16 col 29 value "9. Retorno".
           02 line 18 col 25 value "Escolha uma Opcao:".

       01 tela-devolucao.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Devolucao de Livro" highlight.
           02 line 8 col 19 value "Tombo: ".
           02 line 9 col 19 value "Numero:".
           02 line 10 col 19 value "Data de retirada: ".
           02 line 11 col 19 value "Data de devolucao: ".
           02 line 13 col 19 value "Deseja devolver? <S/N>".

       01 tela-atualiza.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Atualiza dados" highlight.
           02 line 8 col 19 value "Tombo: ".
           02 line 9 col 19 value "Numero:".
           02 line 10 col 19 value "Data de retirada: ".
           02 line 11 col 19 value "Data de devolucao: ".
           02 line 13 col 19 value "Atualizar? <S/N>".
      
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

       Processo-multa.
           compute multa = w-data-retirada-ano - w-data-devolucao-ano.
           if multa is less than 0
              compute multa = w-data-retirada-mes -
              w-data-devolucao-mes
              compute check = (w-data-retirada-dia -
              w-data-devolucao-dia)
              MULTIPLY multa by check
              display "Multa de:" at 1706
              display multa at 1712
           else
              display "Multa muito alta!" at 2306.      

       Devolucao.
           Display tela-devolucao.
           accept w-tombo-li at 0827.
           move w-tombo-li to tombo-li
           READ BBSOCIOS key is tombo-li INVALID KEY perform
           estuda-erro.
           accept w-numero-so at 0930.
           move w-numero-so to numero-so.
           READ BBLIVROS key is numero-so
           INVALID KEY perform estuda-erro.
           READ BBMOVIM key is data-retirada INVALID KEY perform
           estuda-erro.
           move data-retirada to w-data-retirada.
           read BBMOVIM key is data-devolucao invalid key perform
           estuda-erro.
           move data-devolucao to w-data-devolucao.
           display w-data-retirada at 1040.
           display w-data-devolucao at 1140.
           perform processo-multa.
           accept op at 1345.
           if op = "S" or "s"
              delete BBMOVIM invalid key perform estuda-erro
           ELSE
              PERFORM Processo.      

       Estuda-erro.
           display "Erro! Registro Nao encontrado!." at 2121.
           display arqst at 2221.
           stop " ".      

      
       Atualizar.
           move spaces to op-continua.
           Display tela-atualiza.
           accept w-numero at 0830.
           accept w-tombo at 0930.
           accept w-data-retirada at 1040.
           accept w-data-devolucao at 1140.
           accept op-continua at 1340.
           if op-continua = "S" or "s"
               move w-numero to numero
               move w-tombo to tombo
               move w-data-retirada to data-retirada
               move w-data-devolucao to data-devolucao
               rewrite reg-movim invalid key perform estuda-erro
           else
              Perform Processo.
      
       Processo.
           Perform mostra-tela-menu.
           move zeros to op.
           move zeros to w-reg-movim.
           move spaces to op-continua.
           Accept op-continua at 1845 with prompt auto.
           Evaluate op-continua
           when 1
               perform devolucao until op-continua = "n" or "N"
           when 2
               perform atualizar until op-continua = "n" or "N"
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
