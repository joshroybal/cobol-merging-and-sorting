       identification division.
       program-id. mergeflat.

       environment division.

       input-output section.
       file-control.
           select input-file-1 assign to ws-file-path-1
              organization is line sequential.
           select input-file-2 assign to ws-file-path-2
              organization is line sequential.
           select output-file assign to "merged.txt"
              organization is line sequential.
           select work-file assign to "scratch.dat".

       data division.
       file section.

       fd input-file-1.
       01 input-record-1     pic x(296).

       fd input-file-2.
       01 input-record-2     pic x(296).

       fd output-file.
       01 output-record      pic x(296).

       sd work-file.
       01 input-record-1.
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
       77 ws-file-path-1     pic x(80).
       77 ws-file-path-2     pic x(80).


       procedure division.
       begin.
           accept ws-file-path-1 from argument-value
           accept ws-file-path-2 from argument-value
           merge work-file
              on ascending key lastname-field
              on ascending key firstname-field
              using  input-file-1, input-file-2
              giving output-file
              display "merged data written to merged.txt"
           stop run.
