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
