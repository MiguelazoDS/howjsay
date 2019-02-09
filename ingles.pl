#!/usr/bin/env perl

use LWP::Simple;

$url="https://howjsay.com/";
$url_mp3=$url."mp3";
$contenido=get($url);

system ("if [ ! -e audios ]; then mkdir audios; fi");
@palabras = $contenido =~ /loadEcho'>(\w+)/g;

print scalar@palabras;
@letras = (a..z);

foreach $x (@letras){
    my $url_letra="$url$x";
    $contenido=get($url_letra);
    @paginas = $contenido =~ /href='($x\?page=\d+)'>/g;
    foreach $y (@paginas){
        my $url_pagina="$url$y";
        $contenido=get($url_pagina);
        @palabras = $contenido =~ /loadEcho'>(\w+)/g;
        foreach $z (@palabras){
            my $url_final="$url_mp3/$z.mp3";
            print $url_final, "\n";
	    system ("wget $url_final -P audios");
        }
    }
}
