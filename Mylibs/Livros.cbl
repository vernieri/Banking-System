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

             Procedure Division.
       Inicio.
           Perform Abre-arq.
           Move function current-date to data-sis.
           Perform Processo until op = 6.
           Perform Finaliza.
           stop run.

       Abre-arq.
           Open i-o BBLIVROS.
           If arqst not = "00"
               Display "erro de abertura" at 2110
               Close BBLIVROS
               Open output BBLIVROS.

       Processo.
           Perform mostra-tela-menu.
           move spaces to op-continua.
           Accept op at 1845 with prompt auto.
           Evaluate op
           when 1
               perform inclusao until op-continua = "n" or "N"
           when 2
               perform alteracao until op-continua = "n" or "N"
           when 3
               perform exclusao until op-continua = "n" or "N"
           when 4
               perform consulta-tombo until op-continua = "n" or "N"
           when 5
               perform consulta-titulo until op-continua = "n" or "N".

       Inclusao.
           Perform mostra-tela-cadastro.
           Display "I N C L U S A O" at 0630 with highlight.
           Perform entra-tombo until wflag = 1.
           Perform recebe-dados.
           Perform gravar-livro.
           Perform continua.

       Mostra-tela-menu.
           Display tela-menu.
           Display mes-t(mes) at 0219.
           move zeros to op.

       Mostra-tela-cadastro.
           Display tela-cadastro.
           Display mes-t(mes) at 0219.
           move zeros to wflag w-tombo w-preco editadas
                         w-emprestado w-ano-livro.
           move spaces to op-continua salva.
           move spaces to w-titulo w-autor w-editora.
           move spaces to w-doacao w-doador w-procedencia.

       Recebe-dados.
           perform entra-titulo   until wflag = 0.
           perform entra-autor    until wflag = 1.
           perform entra-editora  until wflag = 0.
           perform entra-ano      until wflag = 1.
           perform entra-doacao   until wflag = 0.
           if w-doacao = "S"
               perform entra-doador        until wflag = 1
           else
                perform entra-preco         until wflag = 1
                perform entra-procedencia   until wflag = 0.

       Entra-Tombo.
           move 1 to wflag.
           move zeros to w-tombo-e.
           accept w-tombo-e at 0826 with prompt auto.
           move w-tombo-e to w-tombo tombo.
           if w-tombo = 999999 then
                Close BBLIVROS
                Exit program.
           if op = 1
                read BBLIVROS key is tombo not invalid key perform
                ja-cadastrado
           else
                read BBLIVROS key is tombo invalid key perform
                nao-cadastrado.

       Ja-cadastrado.
           display "Codigo ja cadastrado" at 2321
           set wflag to 0.

       Nao-cadastrado.
           display "Codigo nao cadastrado" at 2321
           set wflag to 0.

       Entra-titulo.
           accept w-titulo at 0927 with prompt auto.
           if w-titulo = spaces then
                display "Digite o Titulo do Livro." at 2321
           else
                display espaco at 2321
                move 0 to wflag.

       Entra-autor.
           accept w-autor at 1027 with prompt auto.
           if w-autor = spaces then
                display "Digite o Autor do Livro." at 2321
           else
                display espaco at 2321
                move 1 to wflag.

       Entra-Editora.
           accept w-editora at 1128 with prompt auto.
           if w-editora = spaces then
                display "Digite a Editora do Livro." at 2321
           else
                display espaco at 2321
                move 0 to wflag.

       Entra-ano.
           accept w-ano-livro at 1224 with prompt auto.
           if w-ano-livro = zeros then
                display "Digite o Ano do Livro." at 2321
           else
                If (w-ano-livro > 2000) and (w-ano-livro <= ano)
                   display espaco at 2321
                   move 1 to wflag.

       Entra-Doacao.
           accept w-doacao at 1327 with prompt auto.
           if w-doacao = "S" or "N" then
                display espaco at 2321
                move 0 to wflag
           else
                display "Digite <S> SIM ou <N> NAO" at 2321.

       Entra-doador.
           accept w-doador at 1427 with prompt auto.
           if w-doador = spaces then
                display "Digite o Doador do Livro." at 2321
           else
                display espaco at 2321
                move 1 to wflag.

       Entra-preco.
           accept w-preco-e at 1526 with prompt auto.
           move w-preco-e to w-preco.
           if w-preco = zeros then
                display "Digite o Preco do Livro." at 2321
           else
                display espaco at 2321
                move 1 to wflag.

       Entra-procedencia.
           accept w-procedencia at 1632 with prompt auto.
           if w-procedencia = spaces then
                display "Digite a Procedencia do Livro." at 2321
           else
                display espaco at 2321
                move 0 to wflag.

       Gravar-livro.
           Display "Gravar Registro? <S/N> [ ]" at 2321.
           Accept salva at 2345 with prompt auto.
           If salva = "S" or "s" then
               Move w-tombo       to tombo
               Move w-titulo      to titulo
               Move w-autor       to autor
               Move w-editora     to editora
               Move w-ano-livro   to ano-livro
               Move w-doacao      to doacao
               Move w-doador      to doador
               Move w-preco       to preco
               Move w-procedencia to procedencia
               Move w-emprestado  to emprestado
               If op = 1
                   Write reg-livro invalid key perform estuda-erro
               else
                   Rewrite reg-livro invalid key perform estuda-erro.

       Continua.
           display espaco at 2321.
           display "Continua <S/N> [ ]" at 2321.
           accept op-continua at 2337 with prompt auto.
           if op-continua = "S" or "s" then
                display espaco at 2315.

       Estuda-erro.
           display "Erro de atualização." at 2321.
           display arqst at 2221.
           stop " ".

       Alteracao.
           perform mostra-tela-cadastro.
           Display "A L T E R A C A O" at 0630 with highlight.
           Display "Empresatado: " at 1719.
           Perform entra-tombo until wflag = 1.
           Perform mostra-dados.
           Perform recebe-dados.
           accept w-emprestado at 1732 with prompt auto.
           Perform gravar-livro.
           Perform continua.

       Mostra-dados.
           Move reg-livro to w-reg-livro.
           Move w-preco to w-preco-e
           Display w-titulo at 0927.
           Display w-autor at 1027.
           Display w-editora at 1128.
           Display w-ano-livro at 1224.
           Display w-doacao at 1327.
           Display w-doador at 1427.
           Display w-preco-e at 1526.
           Display w-procedencia at 1632.
           Display w-emprestado at 1732.

       Exclusao.
           perform mostra-tela-cadastro.
           Display "E X C L U S A O" at 0630 with highlight.
           Perform entra-tombo until wflag = 1.
           Perform mostra-dados.
           Perform excluir-livro.
           Perform continua.

       Excluir-livro.
           display espaco at 2315.
           display "Excluir? <S/N> [ ]" at 2321.
           accept salva at 2337 with prompt auto.
           if salva = "S" or "s" then
                Delete BBLIVROS invalid key perform
                estuda-erro
                display espaco at 2315.

       Consulta-tombo.
           perform mostra-tela-cadastro.
           Display "C O N S U L T A   T O M B O" at 0630 with highlight.
           Perform entra-tombo until wflag = 1.
           Perform mostra-dados.
           Perform continua.

       Consulta-titulo.
           perform mostra-tela-cadastro.
           Display
           "C O N S U L T A   T I T U L O" at 0630 with highlight.
           Perform entra-titulo.
           move w-titulo to titulo.
           read BBLIVROS key is titulo
               invalid key
                   display "Livro nao encontrado!" at 1835
               not invalid key
                   Perform mostra-dados
                   Display tombo at 0826.
           Perform continua.

       Finaliza.
           close BBLIVROS.
           Display "F I M   D O   P R O G R A M A" at 1530.
