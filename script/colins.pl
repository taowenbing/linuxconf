#!/usr/bin/perl

sub lie {
	my ($l, $str) = @_;
	my $k;
	for my $i (0 .. length($str)-1) {
		if (substr($str, $i, 1) eq "\t") {
			$k += 8;
		} else {
			++$k;
		}

		return $i if ($k == $l);
	}
	return -1;
}

my $nl = shift;
my $ins = shift;

while (<>) {
	my $l = lie($nl, $_);
	s/^(.{$l})/${1}$ins/ if $l != -1;
	print;
}
