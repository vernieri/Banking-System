      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       Identification Division.
       Program-Id.  Cadastro.
       Environment Division.
       CONFIGURATION SECTION.
           Special-names.   decimal-point is comma.
       INPUT-OUTPUT SECTION.
       File-Control.
           Select CAD assign to disk
           organization indexed
           access mode dynamic
           record key codigo
           alternate record key Nome with duplicates
           alternate record key Cargo with duplicates
           file status arqst.
       Data Division.
       File Section.
       FD  CAD label record standard
           value of file-id is "CAD.dat".

       01 reg-cad.
           02 Codigo           pic 9(06).
           02 Nome             pic x(30).
           02 Cargo            pic x(20).
           02 Salario          pic 9(05).
           02 Departamento     pic x(10).
           02 Cidade           pic x(20).

       WORKING-STORAGE SECTION.
       01 w-reg-cad.
           02 w-codigo         pic 9(06).
           02 w-nome           pic x(30).
           02 w-cargo          pic x(20).
           02 w-salario        pic 9(05).
           02 w-departamento   pic x(10).
           02 w-cidade         pic x(20).

       01 data-sis.
           02 ano   pic 9(04).
           02 mes   pic 9(02).
           02 dia   pic 9(02).

       01 arqst        pic x(02).
       01 op           pic 9(01) value zeros.
       01 salva        pic x(01) value spaces.
       01 wflag        pic 9(01) value zeros.
       01 espaco       pic x(30) value spaces.
       01 op-continua  pic x(01) value spaces.
       01 check        pic x(01) value spaces.


       Screen Section.
       01 tela-menu.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de            de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Profissionais" highlight.
           02 line 6 col 29 value  "1. Inclusao".
           02 line 8 col 29 value  "2. Alteracao".
           02 line 10 col 29 value "3. Exclusao".
           02 line 12 col 29 value "4. Consulta por Nome".
           02 line 16 col 29 value "9. Sair".
           02 line 18 col 25 value "Escolha uma Opcao: ".

       01 tela-cadastro.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Cadastro de Funcionario" highlight.
           02 line 8 col 19 value "Codigo: ".
           02 line 9 col 19 value "Nome: ".
           02 line 10 col 19 value "Cargo: ".
           02 line 11 col 19 value "Salario: ".
           02 line 12 col 19 value "Departamento: ".
           02 line 13 col 19 value "Cidade: ".
           02 line 15 col 19 value "Salvar<S/N>: ".

       01 tela-altera.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Altera Dados" highlight.
           02 line 6 col 19 value "Entre Codigo: ".
           02 line 8 col 19 value "Codigo: ".
           02 line 9 col 19 value "Nome: ".
           02 line 10 col 19 value "Cargo: ".
           02 line 11 col 19 value "Salario: ".
           02 line 12 col 19 value "Departamento: ".
           02 line 13 col 19 value "Cidade: ".
           02 line 15 col 19 value "Salvar? <S/N>: ".

       01 tela-consulta.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Consulta Dados" highlight.
           02 line 8 col 19 value "Consulta Nome: ".
           02 line 12 col 19 value "Codigo: ".
           02 line 13 col 19 value "Nome: ".
           02 line 14 col 19 value "Cargo: ".
           02 line 15 col 19 value "Salario: ".
           02 line 16 col 19 value "Departamento: ".
           02 line 17 col 19 value "Cidade: ".
           02 line 18 col 19 value "Voltar? ".

       01 tela-excluir.
           02 BLANK SCREEN.
           02 line 2 col 5 value "Santos,    de           de     .".
           02 line 2 col 13 PIC 9(02) using dia.
           02 line 2 col 33 PIC 9(04) using ano.
           02 line 4 col 29 value "Deletar Dados" highlight.
           02 line 8 col 19 value "Deletar Nome: ".
           02 line 12 col 19 value "Deletar? <S/N>: ".

       PROCEDURE DIVISION.
       Inicio.
           Perform Abre-arq.
           Move function current-date to data-sis.
           Perform Processo until op = 9.
           Perform Finaliza.
           stop run.

       Abre-arq.
           Open i-o CAD.
           If arqst not = "00"
               Display "erro de abertura" at 2110
               Close CAD
               Open I-O CAD.
       Limpeza.
           move zeros to w-codigo.
           move spaces to w-nome.
           move spaces to w-cargo.
           move zeros to w-salario.
           move spaces to w-departamento.
           move spaces to w-cidade.

       mostra-erro.
           display "REGISTRO NAO ENCONTRADO!" at 2020.

       Inclusao.
           DISPLAY tela-cadastro.
           accept w-codigo at 0845.
           accept w-nome at 0945.
           accept w-cargo at 1045.
           accept w-salario at 1145.
           accept w-departamento at 1245.
           accept w-cidade at 1345.
           accept salva at 1545 WITH PROMPT AUTO.
           if salva = "S" or "s"
               move w-reg-cad to reg-cad
               READ CAD key is codigo INVALID KEY perform mostra-erro
               WRITE reg-cad.
           Perform Processo.

       Alteracao.
           DISPLAY tela-altera.
           accept w-codigo at 0645
           READ CAD key is w-codigo INVALID KEY perform mostra-erro
           display codigo at 0845.
           accept w-nome at 0945.
           ACCEPT w-cargo at 1045.
           accept w-salario at 1145.
           accept w-departamento at 1245.
           accept w-cidade at 1345.
           accept salva at 1545.
           if salva = "S" or "s"


               move w-reg-cad to reg-cad
               REWRITE reg-cad.
           Perform Inicio.

       Exclusao.
           display tela-excluir.
           accept w-nome AT 0845.
           READ CAD key is w-nome INVALID KEY perform mostra-erro.
           move codigo to w-codigo.
           accept salva at 1245.
           if salva = "S" or "s"
               move spaces to nome.
               move spaces to w-cargo
               move zeros to w-salario
               move spaces to w-departamento
               move spaces to w-cidade
               move w-reg-cad to reg-cad
               REWRITE reg-cad.

           accept check at 1545.
           Perform Processo.

       Consulta.
           Display tela-consulta.
           accept w-nome at 0845.
           move w-nome to nome.
           move spaces to w-nome.
           READ CAD key is nome INVALID key perform mostra-erro.
           move reg-cad to w-reg-cad.
           Display w-codigo at 1245.
           DISPLAY w-nome at 1345.
           DISPLAY w-cargo at 1445.
           display w-salario at 1545.
           DISPLAY w-departamento at 1645.
           display w-cidade at 1745.
           accept salva at 1845.
           Perform Processo.

       Processo.
           Display tela-menu.
           Perform Limpeza.
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
               perform Consulta until op-continua = "n" or "N".

       Finaliza.
           close CAD.
           Display "F I M   D O   P R O G R A M A" at 1530.
