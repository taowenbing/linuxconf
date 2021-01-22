#!/usr/bin/perl

$pname = $0;
$PACKS = "/var/log/packages";
$TAGP = "/home/taoweb/doc/tagpath";

sub usage {
	print STDERR "$pname error: @_" if ($#_ >= 0);
	print STDERR <<EOF;
usage: $pname [-d tagpath]
EOF
	exit(1);
}

while ($#ARGV >= 0 && $ARGV[0] =~ /^-/) {
	$_ = shift @ARGV;
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

chdir $PACKS or die "chdir $PACKS error";
@packs = glob "*";

chdir $TAGP or die "chdir $TAGP error";
opendir(D1, ".") or die "opendir $TAGP error";
while ($f = readdir D1) {
	next if ($f eq "." || $f eq "..");
	if (-d $f) {
		open(FS, "$f/tagfile.org") or die "open $f/tagfile.org error";
		open(FD, ">$f/tagfile") or die "open $f/tagfile error";

		while (<FS>) {
			next if (/^#/);
			$skip = 1;
			chomp;
			s/:.*//;
			#s/^\s+|\s+$//;
			for $p (@packs) {
				if ($p =~ /^\Q$_\E-.*/ ) {
					$skip = 0;
					last;
				}
			}
			if ($skip) {
				print FD "$_:SKP\n";
			} else {
				print FD "$_:ADD\n";
			}
		}
		close FS;
		close FD;
	}
}
