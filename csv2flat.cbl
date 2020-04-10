      ******************************************************************
      * csv record parsing field extraction program cobol version
      * copyright (c) 2019 josh roybal
      ******************************************************************
       identification division.
       program-id.    csv2flat.
       environment division.
       input-output section.
       file-control.
           select input-file assign to ws-file-path
              organization is line sequential.
           select output-file assign to "flat.txt"
              organization is line sequential.

       data division.
       file section.
       
       fd input-file.
       01 input-record                 pic x(256).

       fd output-file.
       01 output-record.
          05 firstname-field           pic x(15).
          05 lastname-field            pic x(15).
          05 company-field             pic x(35).
          05 address-field             pic x(35).
          05 city-field                pic x(35).
          05 county-field              pic x(35).
          05 state-field               pic x(2).
          05 zip-field                 pic x(5).
          05 phone-field               pic x(12).
          05 cell-field                pic x(12).
          05 email-field               pic x(45).
          05 www-field                 pic x(50).
       
       working-storage section.
       77 ws-file-path                 pic x(80).
       77 ws-max-flds                  pic 99 value 12.
       77 ws-no-flds                   pic 99 value 1.
       77 ws-fld-idx                   pic 99.
       77 ws-fld-no                    pic 99.
       77 ws-rec-idx                   pic 999.
       77 ws-rec-len                   pic 999.
       77 ws-fld-len                   pic 99.
       01 no-more-records              pic x(1) value space. 
       01 ws-record-fields.
           05 ws-record-field          pic x(50) occurs 12 times.
      ******************************************************************
      * main program section
      ******************************************************************
       procedure division.
           accept ws-file-path from argument-value
           open input input-file
           open output output-file
           read input-file into input-record
           perform until no-more-records = 'y'
               move spaces to input-record
               read input-file into input-record
                 at end 
                    move 'y' to no-more-records
                 not at end
                    if input-record not = spaces
                       perform extract-fields
                       perform load-fields
                       write output-record
                    end-if
               end-read
           end-perform
           close input-file
           close output-file
           display "flat.txt written"           
           stop run.
      ******************************************************************
      * extract field(s) from comma delimited sequential file record
      ******************************************************************
       extract-fields section.
           move 1 to ws-rec-idx
           move 1 to ws-fld-idx
           move 1 to ws-fld-no
           perform find-record-length
           perform until ws-fld-no > ws-max-flds 
              or ws-rec-idx > ws-rec-len
               move spaces to ws-record-field(ws-fld-no)
               perform until input-record(ws-rec-idx:1) = ","
                   or ws-rec-idx > ws-rec-len
                   if input-record(ws-rec-idx:1) not = '"'
                       move input-record(ws-rec-idx:1) 
                       to ws-record-field(ws-fld-no)(ws-fld-idx:1)
                       set ws-rec-idx up by 1
                       set ws-fld-idx up by 1
      * step through any double quoted substrings and adjust the indices
      * accordingly
                   else
                       set ws-rec-idx up by 1 
                       perform until input-record(ws-rec-idx:1) = '"'
                       or ws-fld-idx > 50
                           move input-record(ws-rec-idx:1) 
                           to ws-record-field(ws-fld-no)(ws-fld-idx:1)
                           set ws-fld-idx up by 1
                           set ws-rec-idx up by 1
                       end-perform
                       set ws-rec-idx up by 1
                   end-if
               end-perform
               set ws-rec-idx up by 1
               move 1 to ws-fld-idx
               set ws-fld-no up by 1
           end-perform
           set ws-fld-no down by 1
           move ws-fld-no to ws-no-flds.
      ******************************************************************
      * find the length of input-record sans trailing blank spaces
      ******************************************************************
       find-record-length section.
           move function length(function trim(input-record)) to ws-rec-l
      -en.
      ******************************************************************
      * load extracted fields into output-record
      ******************************************************************
       load-fields section.
           move ws-record-field(1) to firstname-field
           move ws-record-field(2) to lastname-field
           move ws-record-field(3) to company-field
           move ws-record-field(4) to address-field
           move ws-record-field(5) to city-field
           move ws-record-field(6) to county-field
           move ws-record-field(7) to state-field
           move ws-record-field(8) to zip-field
           move ws-record-field(9) to phone-field
           move ws-record-field(10) to cell-field
           move ws-record-field(11) to email-field
           move ws-record-field(12) to www-field.
