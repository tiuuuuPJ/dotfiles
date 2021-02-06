#!/usr/bin/env perl

$latex = 'platex -synctex=1 -halt-on-error -shell-escape';
$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = 3
