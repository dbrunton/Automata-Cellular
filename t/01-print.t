use v6;
use Test;
use lib 'lib';
use Automata::Cellular;

plan 2;

my Wolfram $w .= new(:number(30));

ok ~$w.rule ~~ m:s/Rule 30/, "Prints the rule";
$w.next;
my $step2 = $w.current;
ok $step2 ~~ m/ XXX /, "Next stage is corect";
