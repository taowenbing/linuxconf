#!/usr/bin/perl

$pname = $0;
$ROOT = "/mnt/cdrom/slackware";
$TAGP = "/home/taoweb/doc/tagpath";

sub usage {
	print STDERR "$pname error: @_" if ($#_ >= 0);
	print STDERR <<EOF;
usage: $pname [-s rootpath] [-d tagpath]
EOF
	exit(1);
}

while ($#ARGV >= 0 && $ARGV[0] =~ /^-/) {
	$_ = shift @ARGV;
	if (/^-s(.*)/) {
		if ($1) {
			$ROOT = $1;
		} else {
			$ROOT = shift @ARGV;
		}
		next;
	}
	if (/^-d(.*)/) {
		if ($1) {
			$TAGP = $1;
		} else {
			$TAGP = shift @ARGV;
		}
		next;
	}
	usage if (/^-h/);
	usage("unkown option!");
}

chdir $ROOT or die "chdir $ROOT error";
for $f (glob "*") {
	if (-d $f) {
		`mkdir -p $TAGP/$f`;
		`cp $f/tagfile $TAGP/$f/tagfile.org`;
	}
}
