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
