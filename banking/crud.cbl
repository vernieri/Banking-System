      ******************************************************************
      * Author: Vernieri
      * Date: September 6, 2018
      * Purpose: Banking C.R.U.D
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. crud.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 account.
           02 ws-name.
             03 ws-firstn        pic x(20).
             03 ws-middlen       pic x(20).
             03 ws-lastn         pic x(20).

           02 ws-date.
             03 ws-day           pic 9(02).
             03 ws-mouth         pic 9(02).
             03 ws-year          pic 9(04).

           02 ws-state.
             03 ws-country       pic x(16).
             03 ws-local         pic x(16).
             03 ws-city          pic x(16).

           02 ws-about.
             03 ws-cpf           pic x(11).
             03 ws-rg            pic x(10).
             03 ws-mom           pic x(20).
             03 ws-dad           pic x(20).
             03 ws-cel.
               04 ws-ddi         pic x(03).
               04 ws-ddd         pic x(03).
               04 ws-num         pic x(08).
             03 ws-gender        pic x(03).
             03 ws-nacionality   pic x(16).
             03 ws-job           pic x(16).

           02 ws-adress.
             03 ws-street        pic x(16).
             03 ws-neighborhood  pic x(16).
             03 ws-complement    pic x(06).
             03 ws-cep           pic x(08).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "BANKING CRUD".
            DISPLAY "FIRST NAME: ".
            STOP RUN.
       END PROGRAM crud.
