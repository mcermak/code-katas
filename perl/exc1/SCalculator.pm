# Very easy and naive text calculator inspired by http://osherove.com/tdd-kata-1/
#
# Author: Martin Cermak xmartin.cermak@gmail.com (2014)
#
#!/usr/bin/env perl

package SCalculator;

use strict;
use warnings;
use utf8;

use Moose;

sub Add
{
	my ( $self, $input ) = @_;

	return 0 unless $input;

	my $delimiters_str;
	($delimiters_str, $input) = $input =~ /^(?:\/\/([^\n]*)\n)?(.*)$/;
	$delimiters_str //= "[,]";

	return 0 unless $input;

	my @delimiters = $delimiters_str =~ /\[([^\]]*)\]/g;

	my $sum = 0;
	my $split_value = "(?:".join("|",@delimiters).")";
	my @values_to_sum = split( "$split_value", $input );

	my @negs = grep $_ < 0, @values_to_sum;
	die 'negatives not allowed: '.join(", ", @negs) if scalar @negs;

	$sum += $_ <= 1000 ? $_ : 0 foreach @values_to_sum;

	return $sum;
}

__PACKAGE__->meta->make_immutable;
