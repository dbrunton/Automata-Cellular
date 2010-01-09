use v6;

=begin pod

=head1 NAME

Automata::Cellular::Rule - Build and render Cellular Automata Wolfram-style
rules

=head1 VERSION

Version 0.1

=head1 DESCRIPTION

C<Automata::Cellular> is the meat of this module; everything you need for
most investigations should be included by:

    use Automata::Cellular;

More information can also be found in the Perldoc for that module.

=head1 AUTHOR

David Brunton - dbrunton@gmail.com

=end pod
role Automata::Cellular::Rule is rw {

    has Bool %.rule;
    has Int $.rule_number;

    # submethod unpacks the rule number into a hash
    submethod BUILD (Int $.rule_number) {
        for 0..7 -> $key {
            %.rule{$key} = ?($.rule_number +& (1 ~ 0 x $key) );
        }
    }

    # print the rule in string context
    method Str (Str $true = 'x', Str $false = '.') {
        my Str $rule_string = '';
        # not sure why I can't just %(self) here....
        for %(self.Hash()).kv -> $k,$v {
             $rule_string ~= "'$k' becomes '$v'\n";
        }
        return $rule_string;
   }

    method Hash (Str $true = 'x', Str $false = '.') {
       map { (([$false, $true][sprintf("%03b",$_).split("")]).join("") => [$false, $true][%.rule{$_}]) }, %.rule.keys;
    }

    method Num () {
        return $.rule_number.Int;
    }

} # role Automata::Cellular::Rule
