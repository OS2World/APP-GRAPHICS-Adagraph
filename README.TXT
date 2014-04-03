  Package Adagraph is a system independent AutoCad compatible graphic package
that was written on Ada 95 and may be used in different operation systems.
It's a base for vector oriented graphic engineering.
  It create own graphic file that may be viewed in PM OS/2 (bantview.exe)
or in Dos (tempor.exe, image.axe).
  This package is engineering design oriented and has interface for
AutoCad (*.dxf) program acad.exe .

-------------------------------------------------------------------------
                            A little manuel
                          --------------------
   Package BUILTIN, which implements many of BUILT_IN PL/I functions, was
designed for greater comfort from PL/I to Ada transition.
   The type VARING, near to PL/I varying string, was described before of all.

PRIVATE
TYPE VARING(VARING_MAX:INTEGER:=255) IS RECORD
LEN_STR:INTEGER RANGE 0..VARING_MAX:=0;
CNT_STR:STRING(1..VARING_MAX);
END  RECORD;

   The first package routines group contains two functions:

DATE_MEANS and TIME_MEANS, which returns date and time in seven symbols
string;

   The second group is procedures and functions input/output and compare
to STRING and VARING variables:
GET_I    -  compatible functions input integer variable  ;
GET_F    -  compatible functions input float   variable  ;
PUT_I    -  compatible functions output integer variable in I format ;
PUT_E    -  compatible functions output float variable in E format ;
PUT_F    -  compatible functions output float variable in F format ;
PUT_EDIT - compatible procedures printing text and variable ;
COMP_STR - compare two string.

  The third group is the procedures and functions for working with string
and varying variables:

SUBSTR, LEFT, RIGHT, VAR_LEN, INDEX, CLEAN, OVERLAY, CTEXT, UPPER_LOW;

  the fourth group contains two procedures :

BEGENT  - input character string until separator-symbol occur;
HELPSTR - definition is how many numbers are contained in the string until
separator-symbol;

  The  fifth group is some functions for integer and float variables
such as:

MIN, MAX, SIGN;

  The package BUILTIN uses only package TEXT_IO and not uses generic
packages INTEGER_IO and FLOAT_IO, besides input of float variables
is a free ( that's 2.0, 2, 2.0e0, 2e0 equivalent from GET_F function
input).
   Function PUT_F and procedure PUT_EDIT trying to output in F format,
so that decimal point moving in limits of outputting field's length
(that is keeping relative precision of outputting information).
for example PUT_F(x,7)    .......
                           343.21
                          -34.321
                           3.4321
that allow to avoid reservation of unnecessary fields in tables.
  Described package solves many problems, which related with the
works up complicated string information and "clever" input/output.


   Machine-building design has a great means in engineering applications.
The package ADAGRAPH may be a low level layer for complex graphic systems.
It, at the same time with output graphic information into screen, creates
special file on hard drive.

    This file easy exports to AutoCad or others systems. The special
program ADACAD creates the .dxf file.

     The loading symbol table allows to draw 256 symbols:
English, Russian, Greeks, special symbols and markers.
It easy modifications,because written in text format;

     The first group is the procedures for open and close design file,
define the page, output strings, numbers, markers and fonts:

GRINIT, GRFIN, PAGE, SYMBOL, NUMBER, MARKER, ITALIC, MMS, INCHES;

    The second group is drawing line, moving, set coordinates, connection
mathematics and physics coordinates, selection of "pen":

MOVE   -  ³
MOVA   -  ÃÄÄ  procedures moving with or without drawing line ;
MOVB   -  ³
MOVC   -  ³
WHERE  -  procedure definition of 'pen' coordinate ;
PEN    -  procedure selection of 'pen' ;
REGION -  procedure definition  area for graphics draw ;
LIMITS -  procedure connected mathematical and physical coordinates;

    The third group is creations the levels and blocks:

BEGLEV -  procedure opening new sub picture ;
ENDLEV -  procedure closing  last sub picture ;
RESET  -  procedure closing  all  sub pictures;

    The fourth group is area transformations:

ROTATE - procedure rotating coordinate relatively to point ;
PSCALE - procedure stretching coordinate relatively to point ;
LSCALE - procedure stretching coordinate relatively to line  ;
TRANSL - procedure transferring beginning of system coordinate .

    The fifth group is simple figures:

ANGLER, BOX, CIRCLE, LINE;
Leonid Dulman (dulman@ibm.net).
