use v6;
use Test;
use lib 'lib';
use Automata::Cellular;

plan 1;

my Wolfram $w .= new(:number(30));

ok ~$w.rule ~~ m:s/Rule 30/, "Prints the rule";
