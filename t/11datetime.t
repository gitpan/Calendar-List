#!/usr/bin/perl -w
use strict;

use lib './t';
use Test::More;
use TestData;
use Calendar::Functions qw(:all);

# check we can load the module
eval "use DateTime";
if($@) {
	plan skip_all => "DateTime not installed.";
} elsif(defined $DateTime::VERSION && $DateTime::VERSION > 0.16) {
	plan skip_all => "DateTime after 0.16 is not supported.";
}

DateTime->import;
plan qw|no_plan|;

###########################################################################
# name: 11datetime.t
# desc: Functionality check with DateTime
###########################################################################

foreach my $test (@datetest) {
	is(dotw3(@{$test->{array}}),$test->{dotw});

	my $date = encode_date(@{$test->{array}});
	my @date = decode_date($date);
	is_deeply(\@date,$test->{array});
}

# Tests removed until delta_days() in DateTime.pm is fixed
# - Barbie 06-Nov-2003
#
#foreach my $test (@diffs) {
#	my $date1 = encode_date(@{$test->{from}});
#	my $date2 = encode_date(@{$test->{to}});
#	is(diff_dates($date2,$date1),$test->{duration});
#}
#
#foreach my $test (@monthlists) {
#	my $hash = month_list(@{$test->{array}});
#	is_deeply($hash,$test->{hash});
#	my $days = month_days(@{$test->{array}});
#	is($days,scalar(keys %$hash));
#}


# fail_range
is(fail_range(1899),0);
is(fail_range(1965),0);
is(fail_range(1999),0);
is(fail_range(2000),0);
is(fail_range(2038),0);
