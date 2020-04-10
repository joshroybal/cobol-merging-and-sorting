       identification division.
       program-id.  sortflat.

       environment division.
      
       input-output section.
       file-control.
           select input-file assign to ws-file-path
              organization is line sequential.
           select work-file assign to work.
           select output-file assign to "sorted.txt"
              organization is line sequential.

       data division.
       file section.

       fd input-file.
       01 input-record       pic x(296).
           
       fd output-file.
       01 output-record      pic x(296).

       sd work-file.
       01 work-record.
          05 firstname-field pic x(15).
          05 lastname-field  pic x(15).
          05 company-field   pic x(35).
          05 address-field   pic x(35).
          05 city-field      pic x(35).
          05 county-field    pic x(35).
          05 state-field     pic x(2).
          05 zip-field       pic x(5).
          05 phone-field     pic x(12).
          05 cell-field      pic x(12).
          05 email-field     pic x(45).
          05 www-field       pic x(50).      

       working-storage section.
       77 ws-file-path       pic x(80).

       procedure division.
       begin.
           accept ws-file-path from argument-value
           sort work-file 
              on ascending key lastname-field
              on ascending key firstname-field
                 using input-file giving output-file
           display "sorted data written to sorted.txt"           
           stop run.

