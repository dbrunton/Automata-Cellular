use v6;

=begin doc
This started out as an obfuscated Perl6 tweet some years ago. It provides text
output of Wolfram automata.
=end doc

role Rule {
  has Int $.number is required;
  has %.rules = [^8]>>.fmt("%03b") Z=> $!number.fmt("%08b").split("",:skip-empty).reverse;

  # Prettyprint the rule
  method Str() returns Str {

    my $rulestring = sprintf("Rule %d subrules:\n", $!number);

    for %!rules.sort(*.key)>>.kv -> ($k, $v) {
      $rulestring ~= sprintf("%s => %s\n", $k, $v);
    }
    return $rulestring;
  }

}

class Wolfram does Rule {
  has Rule $.rule .= new(:$!number);
  has Str @.format = <. #>;
  has Int $.width = 101;
  has Int $!steps = $!width div 2;
  has Int @!state = flat 0 xx $!steps, 1, 0 xx $!steps;

  method run() {
    for ^$!steps {
      say @!format[@!state].join;
      self.next();
    }
  }

  method next() {
    @!state = map { +$!rule.rules{ @!state[($_-1) % $!width, $_, ($_+1) % $!width].join } }, ^$!width;
  }
}
