#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

open my $file, "<", $filename or die "Failed to open file\n";

our %pipes = ();
while (<$file>) {
	$_ =~ /(\d+) <-> (.+)/;
	my $src = $1;
	my @dsts = split ', ', $2;
	$pipes{$src} = \@dsts;
}
close $file;

our @nodes = ();

sub searchPipes {
	my $pipe = shift;
	push @main::nodes, $pipe;
	foreach my $dst (@{$main::pipes{$pipe}}) {
		my $found = 0;
		foreach my $inter (@main::nodes) {
			if ($inter == $dst) {
				$found = 1;
				last;
			}
		}
		if (not $found) {
			searchPipes($dst);
		}
	}
}
searchPipes(0);

foreach my $inter (@nodes) {
	print $inter . " ";
}
print "\nTotal nodes: " . scalar(@nodes) . "\n";
