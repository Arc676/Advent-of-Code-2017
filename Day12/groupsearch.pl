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

my @groups = ();
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

foreach my $srcNode (keys %pipes) {
	my $found = 0;
	for (@groups) {
		foreach my $node (@$_) {
			if ($node == $srcNode) {
				$found = 1;
				last;
			}
		}
		last if $found;
	}
	if (not $found) {
		@nodes = ();
		searchPipes($srcNode);
		my @nodesCopy = @nodes;
		push @groups, \@nodesCopy;
	}
}

foreach my $group (@groups) {
	foreach my $node (@{$group}) {
		print $node . " ";
	}
	print "\n";
}
print "Group count: " . scalar(@groups) . "\n";
