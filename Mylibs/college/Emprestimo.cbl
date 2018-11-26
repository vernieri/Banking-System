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
