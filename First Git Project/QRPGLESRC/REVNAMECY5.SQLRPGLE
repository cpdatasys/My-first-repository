000100181104
000200181106        ctl-opt  option(*srcstmt : *nodebugio) debug(*input)
000300181106              dftactgrp(*no) actgrp('WEBINAR');
000400181104
000500131214       dcl-f  custmast disk(*ext) keyed usage(*update);
000600131214
000700181104       dcl-s   characterstring   char(30);
000800181104
000900181106
001000181106      // Begin loop here, for each record call the reversestring
001100181106      // subprocedure.  Upon returning, upper case the result
001200181106      // and then update the record.
001300181106
001400100418       read custmast;
001500100418       dow not %eof (custmast);
001600100418
001700181104         reversestring(ccsnam:characterstring);
001800181104
001900181106       // Set the reversed character string to all upper case
002000181104          exec sql set :characterstring = upper(:characterstring);
002100181104
002200090307
002300181104        //  Update file CUSTMAST with the newly capitalized reversed string
002400181104         ccsnamrev = characterstring;
002500100418         update custmstr;
002600100418
002700100418       read custmast;
002800100418       enddo;
002900100418
003000090307       *inlr = *on;
003100090307       return;
003200181104
003300181106      // Reverestring procedure
003400181106      // Receives a character string and returns the string in reverse sequence
003500181106
003600181104         dcl-proc reversestring;
003700181104
003800181104
003900181104        dcl-pi  reversestring;
004000181104           charin        Char(30);
004100181104           charout       Char(30);
004200181104        end-Pi;
004300181104
004400181104       dcl-s backctr  zoned(2);
004500181104       dcl-s frontctr zoned(2);
004600181104
004700181104       charout = *blanks;
004800181104       backctr = %len(%trim(charin));
004900181104
005000181104       if backctr = *zero;
005100181104         return;
005200181104       endif;
005300181104
005400181104       charout = *blanks;
005500181104       frontctr = 1;
005600181104
005700181104       dou  backctr = *zero;
005800181104         %subst(charout:frontctr:1) = %subst(charin:backctr:1);
005900181104         frontctr +=1;
006000181104         backctr -=1;
006100181104       enddo;
006200181104
006300181106        // When here parameter charout is the reverse of parameter charin
006400181104
006500181104       return;
006600181104
006700181104       end-proc reversestring;
006800181104
006900100418
