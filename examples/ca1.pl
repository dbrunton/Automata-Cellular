use v6;
BEGIN { @*INC.push('../lib') };
use Automata::Cellular;
use Automata::Cellular::Rule;

my Automata::Cellular $ca .= new(:rule_number(30), :display_width(67), :steps(30));
say "Rule Number " ~ +$ca.rule;
say ~$ca.rule;
repeat {
  say ~$ca;
} while $ca.next();
