#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

open my $file, "<", $filename or die "Failed to open file\n";

my @programs = qw(
	a b c d e f g h i j k l m n o p
);
my @moves = split ",", <$file>;
close $file;

sub swap {
	my ($a, $b, $list) = (@_);
	my $tmp = $list->[$a];
	$list->[$a] = $list->[$b];
	$list->[$b] = $tmp;
}

foreach my $move (@moves) {
	if ($move =~ /s(\d+)/) {
		my @progs = splice(@programs, scalar(@programs) - $1);
		unshift @programs, @progs;
	} elsif ($move =~ /x(\d+)\/(\d+)/) {
		swap $1, $2, \@programs;
	} elsif ($move =~ /p(\w)\/(\w)/) {
		my $posA = -1;
		my $posB = -1;
		my $pos = 0;
		foreach my $prog (@programs) {
			if ($posA < 0 && $prog eq $1) {
				$posA = $pos;
			} elsif ($posB < 0 && $prog eq $2) {
				$posB = $pos;
			}
			last if $posA > 0 && $posB > 0;
			$pos++;
		}
		swap $posA, $posB, \@programs;
	}
}

foreach my $prog (@programs) {
	print $prog;
}
print "\n";
