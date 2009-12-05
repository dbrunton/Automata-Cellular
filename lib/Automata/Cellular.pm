use v6;

=begin pod

=head1 NAME

Automata::Cellular - Build and render Cellular Automata on a terminal

=head1 VERSION

Version 0.1

=head1 DESCRIPTION

C<Automata::Cellular> is the meat of this module; everything you need for
most investigations should be included by:

    use Automata::Cellular;

This code makes use of the object-oriented goodness found in the Moose
framework.  As such, even if you find A::C useless in terms of performance
or functionality, you should still be able to enjoy reading the code.

=head1 DEPENDENCIES

C<Automata::Cellular> is written in Perl 6, and currently runs via Pugs

=head1 EXAMPLE

    my Automata::Cellular::Rule $rule .= new(30);
    my Automata::Cellular $ca .= new( :@state, :$rule, :$steps, :$display_width);

    while($ca++) {
        say $ca.prettystate();
    }

=head1 AUTHOR

David Brunton - dbrunton@gmail.com

=end pod

use Automata::Cellular::Rule;

class Automata::Cellular does Automata::Cellular::Rule
{

    # future enhancement: accept a $rule_number, and build a rule in BUILD
    has Automata::Cellular::Rule $.rule is rw;
    has Bool @.state is rw;
    has Int  $.steps is rw;
    has Int  $.rule_number is rw;
    has Int  $.display_width is rw;
    has Int  $.stage is rw;

    # used to set initial stage and defaults
    submethod BUILD (:$.rule_number = 30,
                     :$.steps = 10,
                     :$.display_width = 30,
                     :$.stage = 1) {

        $.rule =
Automata::Cellular::Rule.new(:rule_number($.rule_number));

        my $width = $.display_width + $.steps * 2;

        @.state = Bool::False xx $width;
        @.state[($width/2).Int] = Bool::True;
    }
    # "pretty" being a relative term, on a terminal
    method prettystate (Str $true = 'x', Str $false = '.') {
        my $state = @.state[$.steps..(@.state.elems() -
$.steps)].join("");
        $state.=subst(/0/, $false, :g);
        $state.=subst(/1/, $true, :g);
        "Stage $.stage: $state";
    }

    method next () is export {
        my @old_state = @.state;
        for ( 0 .. (@old_state.elems - 2) ) -> $index {
            my $index_key = :2(@old_state[ $index .. $index + 2 ].join(""));
            @.state[ $index + 1 ] = $.rule.rule{$index_key};
        }

        $.stage++;
        if $.stage > $.steps { return Bool::False; }
        else { return Bool::True; }
    }

} # class Automata::Cellular
