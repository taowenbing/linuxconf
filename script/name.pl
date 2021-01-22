#!/usr/bin/perl

use strict;

my $pname = $0;
$pname = $1 if $0 =~ m,.*/(.*),;

sub usage {
	print STDERR "$pname: error: @_\n" if ($#_ >= 0);
	print STDERR <<EOF;
usage: $pname [-s start] [-n number length] [-p prefix] [-e ext] file ...
EOF
	exit(1);
}

my ($prefix, $ext, $s, $n) = ("xyz", ".jpg", 1, 3);

while ($#ARGV >= 0 && $ARGV[0] =~ /^-/) {
	$_ = shift @ARGV;

	if (/^-s(.*)$/) {
		if ($1) {
			$s = $1;
		} else {
			$s = shift @ARGV;
		}
		next;
	}
	if (/^-n(.*)$/) {
		if ($1) {
			$n = $1;
		} else {
			$n = shift @ARGV;
		}
		next;
	}
	if (/^-p(.*)$/) {
		if ($1) {
			$prefix = $1;
		} else {
			$prefix = shift @ARGV;
		}
		next;
	}
	if (/^-e(.*)$/) {
		if ($1) {
			$ext = $1;
		} else {
			$ext = shift @ARGV;
		}
		next;
	}
	usage() if (/^-h$/);
	usage("unkonw option!");
}

usage() if ($#ARGV < 0);

sub shu0 {
	my ($s, $n) = @_;
	my $sn = length $s;

	$s = "0"x($n-$sn) . $s if ($n>$sn);
	return $s;
}

sub path0 {
	$_ = shift;

	return $1 if (m,(.*/),);
	return '';
}

my ($of, $nf) = ($ARGV[0]);
my $base = path0 $of;

open MV, "> /tmp/rename_$$.pl" or die "open /tmp/rename_$$.pl error.";
for $of (@ARGV) {
	$nf = $base . $prefix . shu0($s++, $n) . $ext;

	print "$of ==> $nf\n";
	print MV qq{rename "$nf", "$of";\n};
	rename $of, $nf or warn "rename error: $!";
}
close MV;
