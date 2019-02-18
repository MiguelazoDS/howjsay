#!/usr/bin/env perl

use LWP::Simple;
use strict;

my $url="https://howjsay.com/";
my $url_mp3=$url."mp3";
my $contenido=get($url);

system ("if [ ! -e audios ]; then mkdir audios; fi");
my @palabras = $contenido =~ /loadEcho'>(\w+)/g;

print scalar@palabras;
my @letras = ("a".."z");

foreach my $x (@letras){
    my $url_letra="$url$x";
    my $contenido=get($url_letra);
    my @paginas = $contenido =~ /href='($x\?page=\d+)'>/g;
    foreach my $y (@paginas){
        my $url_pagina="$url$y";
        $contenido=get($url_pagina);
        @palabras = $contenido =~ /loadEcho'>(\w+)/g;
        foreach my $z (@palabras){
            my $url_final="$url_mp3/$z.mp3";
            print $url_final, "\n";
	    system ("wget $url_final -P audios");
        }
    }
}
