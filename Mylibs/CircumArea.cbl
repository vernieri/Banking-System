      ******************************************************************
      * Author: Vernieri
      * Date: August 28, 2018
      * Purpose: Circumferencia Area Calc
      * Tectonics: cobc
      ******************************************************************

      
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  Calaulo-Area-Circunferencia.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

           special-names.
      *         CRT STATUS     CBL-KEY
               decimal-point is comma.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01 DADOS.
           02 WRaio      PIC  9(03)v99.
           02 WArea      PIC  9(05)V99.
       01 EDITADAS.
           02 WRaio-e    PIC  ZZ9,99.
           02 WArea-e    PIC  ZZ.ZZ9,99.
       01 wcont          PIC  X(01) value spaces.
       01 MENSAGEMS-DE-TELA.
           02 MENSA1            PIC X(50) VALUE
                "DIGITE O Raio".
           02 MENSA2            PIC X(30) VALUE
                "F I M  D O  P R O G R A M A".
           02 MENSA3            PIC X(30) VALUE SPACE.

       01 DATA-DO-SISTEMA.
           02 ANO               PIC 9(02) VALUE ZEROS.
           02 MES               PIC 9(02) VALUE ZEROS.
           02 DIA               PIC 9(02) VALUE ZEROS.      

      SCREEN SECTION.
      
       01 TELA01.
           02 BLANK SCREEN.
           02 LINE 02 COLUMN 05 PIC 9(02)/ USING DIA.
           02 LINE 02 COLUMN 08 PIC 9(02)/ USING MES.
           02 LINE 02 COLUMN 11 PIC 9(02)  USING ANO.
           02 LINE 02 COLUMN 28 VALUE
                "Cálcula da Área de um Circulo".
           02 LINE 08 COLUMN 15 VALUE "Raio:".
           02 LINE 10 COLUMN 15 VALUE "Área:".

      PROCEDURE DIVISION.

       Inicio.
           ACCEPT  DATA-DO-SISTEMA FROM DATE.
           Perform Processo until wcont = "n".
           Perform Finaliza.
           Stop Run.

       Processo.
           Perform Inicializa.
           Perform Entra-Raio.
           Perform Calcula.
           Perform Continua until wcont = "s" or "n".      

       Inicializa.
           DISPLAY TELA01      AT    0101.
           MOVE    ZEROS       TO    DADOS.
           MOVE    spaces      TO    wcont.      

       Entra-raio.
           DISPLAY MENSA1 AT 2030.
           ACCEPT WRaio-e AT 0821.
           MOVE WRaio-e to WRaio.
           DISPLAY MENSA3 AT 1830.      

       Calcula.
           compute WArea = 3,1416 * (WRaio ** 2).
           move WArea to WArea-e.
           Display WArea-e AT 1021.      

       Continua.
           Display "Continua (s/n):" at 2230.
           Accept wcont at 2246.

       Finaliza.
           DISPLAY MENSA2 AT 1830.
           stop " ".
      
