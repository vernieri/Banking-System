      ******************************************************************
      * Author: Vernieri
      * Date: September 18, 2018
      * Purpose: Media do curso
      * Tectonics: cobc
      ******************************************************************
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  Media-Notas.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       special-names.
           decimal-point is comma.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01 DADOS.
           02 WNota1      PIC  9(02)v9.
           02 WNota2      PIC  9(02)V9.
           02 WNota3      PIC  9(02)V9.    
           02 WMedia      PIC  9(02)v9.

       01 EDITADAS.
           02 WNota1-E      PIC  Z9,9.
           02 WNota2-E      PIC  Z9,9.
           02 WNota3-E      PIC  Z9,9.    
           02 WMedia-E      PIC  Z9,9.
           
       01 wcont             PIC  X(01) value spaces.
       
       01 MENSAGEMS-DE-TELA.
           02 MENSA1            PIC X(50) VALUE
                "DIGITE A NOTA1".
           02 MENSA2            PIC X(50) VALUE
                "DIGITE A NOTA2".
           02 MENSA3            PIC X(50) VALUE
                "DIGITE A NOTA3".         
           02 MENSA4            PIC X(30) VALUE
                "F I M  D O  P R O G R A M A".
           02 MENSA5            PIC X(30) VALUE SPACE.

       01 DATA-DO-SISTEMA.
           02 ANO               PIC 9(02) VALUE ZEROS.
           02 MES               PIC 9(02) VALUE ZEROS.
           02 DIA               PIC 9(02) VALUE ZEROS.
      
       SCREEN SECTION.
       01 TELA01.
           02 LINE 02 COLUMN 05 PIC 9(02)/ USING DIA.
           02 LINE 02 COLUMN 08 PIC 9(02)/ USING MES.
           02 LINE 02 COLUMN 11 PIC 9(02)  USING ANO.
           02 LINE 02 COLUMN 28 VALUE
                "Cálcula da Média das Notas".
           02 LINE 08 COLUMN 15 VALUE "Nota 1:".
           02 LINE 10 COLUMN 15 VALUE "Nota 2:".
           02 LINE 12 COLUMN 15 VALUE "Nota 3:".
           02 LINE 14 COLUMN 15 VALUE "Média :".      

       PROCEDURE DIVISION.

       Inicio.
           ACCEPT  DATA-DO-SISTEMA FROM DATE.
           Perform Processo until wcont = "n".
           Perform Finaliza.
           Stop run.
           
       Processo.    
           Perform Inicializa.
           Perform Entrada.
           Perform Calcula.
           Perform Continua.
           
       Inicializa.    
           DISPLAY ERASE        AT    0101.
           DISPLAY TELA01       AT    0101.
           MOVE    high-values  TO    DADOS.
           MOVE    zeros        TO    EDITADAS.
           MOVE    spaces       TO    wcont.      
      
       Entrada.
           Perform Entra-Nota1 until WNota1 <= 10.
           Perform Entra-Nota2 until WNota2 <= 10.
           DISPLAY MENSA5 AT 2030.
           
       Entra-Nota1.    
           DISPLAY MENSA1 AT 2030.
           ACCEPT WNOTA1-E AT 0823.
           MOVE WNOTA1-E TO WNOTA1.
           
       Entra-Nota2.    
           DISPLAY MENSA2 AT 2030.
           ACCEPT WNOTA2-E AT 1023.
           MOVE WNOTA2-E TO WNOTA2. 
       
       Entra-Nota3.    
           DISPLAY MENSA3 AT 2030.
           ACCEPT WNOTA3-E AT 1223.
           MOVE WNOTA3-E TO WNOTA3. 
      
       Calcula.
           Compute WMEDIA = (WNOTA1 + WNOTA2) / 2.
           Perform Mostra-Media.  
           If WMedia < 6
               Perform Entra-Nota3 until WNota3 <= 10
               If WNota1 < WNota2
                   Compute WMEDIA = (WNOTA3 + WNOTA2) / 2
               else    
                   Compute WMEDIA = (WNOTA1 + WNOTA3) / 2
               End-if
               Perform Mostra-Media.
          
       Mostra-Media.
           MOVE WMEDIA TO WMEDIA-E.
           DISPLAY WMEDIA-E AT 1423.
           If WMedia >= 6  
               Display "- APROVADO" at 1429
           else
               if WNota3 <> high-values
                   Display "- REPROVADO" at 1429.
               
       Continua.
           Display "Continua (s/n):" at 2230.
           Accept wcont at 2246.
       
       Finaliza.
           DISPLAY MENSA4 AT 1830.
           stop " ".
       
