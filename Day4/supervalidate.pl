#!/usr/bin/perl

use strict;
use warnings;

sub checkHashEquality {
	my %hash1 = shift;
	my %hash2 = shift;
	foreach my $k (keys %hash1) {
		return 0 if not defined $hash2{$k};
		return 0 if $hash1{$k} != $hash2{$k};
		delete $hash2{$k};
	}
	return 0 if scalar(keys %hash2) != 0;
	return 1;
}

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

open my $file, "<", $filename or die "Failed to open file\n";
my $validPWs = 0;
while (<$file>) {
	my $line = $_;
	chomp $line;
	my @words = split / /, $line;
	my @anagramlist = ();
	my $isValid = 1;
	foreach my $w (@words) {
		my %lettercount = ();
		my @letters = split //, $w;
		foreach my $l (@letters) {
			if (defined $lettercount{$l}) {
				$lettercount{$l}++;
			} else {
				$lettercount{$l} = 1;
			}
		}
		for (@anagramlist) {
			my %anagram = %$_;
			if (checkHashEquality(%anagram, %lettercount)) {
				$isValid = 0;
				last;
			}
			push @anagramlist, %lettercount;
		}
		last if not $isValid;
	}
	$validPWs++ if ($isValid);
}
close $file;
print $validPWs . " valid passwords found.\n";
