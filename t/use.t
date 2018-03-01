#!/usr/bin/env perl

use Test2::V0;
use Test::Alien;

use Alien::k2pdfopt;

alien_ok 'Alien::k2pdfopt';
run_ok([ 'k2view' ])
       ->success
       ->out_like(qr{\Qkview <infile.bmp>\E});

done_testing;
