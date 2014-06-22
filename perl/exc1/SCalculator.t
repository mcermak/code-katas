# Very easy and naive text calculator inspired by http://osherove.com/tdd-kata-1/
#
# Author: Martin Cermak xmartin.cermak@gmail.com (2014)
#
package Test::SCalculator;

use SCalculator;

use strict;
use warnings;

use Test::Spec;
use Test::Exception;

describe 'SCalculator' => sub {
	my $calc;

	before all => sub {
		$calc = SCalculator->new;
	};

	describe 'Add' => sub {
		it 'Undefined value' => sub {
			my $undef_val = undef;
			my $zero_required = 0;
			is( $calc->Add($undef_val), $zero_required );
		};
		it 'One value' => sub {
			my $value_one = 1;
			is( $calc->Add("$value_one"), $value_one );
		};
		it 'List values with defined separator' => sub {
			my $delimiter = "delimiter";
			my $values_to_be_sum = join ("$delimiter", 10,20,30);;
			my $expec_result = 10 + 20 + 30;
			my $input = "//[$delimiter]\n$values_to_be_sum";

			is( $calc->Add($input), $expec_result );
		};
		it 'Negative numbers' => sub {
			my @list_with_neg_values = (1,2,3,-4,5,-3,-2);
			my $input = join ",", @list_with_neg_values;
			throws_ok { $calc->Add("$input") } qr/negatives not allowed: -4, -3, -2/, '';
		};
		it 'Big numbers ignored' => sub {
			my @list_with_neg_values = (1,2,1001);
			my $input = join ",", @list_with_neg_values;
			my $expected_result_three = 3;
			is ($calc->Add("$input"), $expected_result_three);
		};
		it 'More delimiters' => sub {
			my $delimiters = "[,][;][blah]";
			my $values_to_be_sum = "10,20;30blah40";
			my $expec_result = 10 + 20 + 30 + 40;
			my $input = "//$delimiters\n$values_to_be_sum";

			is( $calc->Add($input), $expec_result );
		};
	};
};

runtests unless caller;
