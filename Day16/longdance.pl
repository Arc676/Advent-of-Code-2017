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
my @nums = qw(
	1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
);
my @moves = split ",", <$file>;
close $file;

sub swap {
	my ($a, $b, $list) = (@_);
	my $tmp = $list->[$a];
	$list->[$a] = $list->[$b];
	$list->[$b] = $tmp;
}

for my $i (1..10) {
	foreach my $move (@moves) {
		if ($move =~ /s(\d+)/) {
			my @progs = splice(@nums, scalar(@nums) - $1);
			unshift @nums, @progs;
		} elsif ($move =~ /x(\d+)\/(\d+)/) {
			swap $1, $2, \@nums;
		} elsif ($move =~ /p(\w)\/(\w)/) {
			my $posA = -1;
			my $posB = -1;
			my $pos = 0;
			foreach my $prog (@nums) {
				if ($posA < 0 && $prog eq $1) {
					$posA = $pos;
				} elsif ($posB < 0 && $prog eq $2) {
					$posB = $pos;
				}
				last if $posA > 0 && $posB > 0;
				$pos++;
			}
			swap $posA, $posB, \@nums;
		}
	}
}

my @tenSteps = @nums;
for my $i (1..3) {
	my @copy = @nums;
	for (my $i = 0; $i < scalar(@copy); $i++) {
		$nums[$i] = $copy[$copy[$i] - 1];
	}
}
print @tenSteps;

for my $i (1..10) {
	my @copy = @nums;
	for (my $i = 0; $i < scalar(@copy); $i++) {
		$nums[$i] = $copy[$tenSteps[$i] - 1];
	}
}

print "\n";
foreach my $prog (@nums) {
	print $programs[$prog - 1];
}
print "\n";
