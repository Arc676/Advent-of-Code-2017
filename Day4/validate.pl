#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

open my $file, "<", $filename or die "Failed to open file\n";
my $validPWs = 0;
while (<$file>) {
	my $line = $_;
	chomp $line;
	my @words = split / /, $line;
	my %wordlist = ();
	my $isValid = 1;
	foreach my $w (@words) {
		if (exists $wordlist{$w}) {
			$isValid = 0;
			last;
		} else {
			$wordlist{$w} = 0;
		}
	}
	$validPWs++ if ($isValid);
}
close $file;
print $validPWs . " valid passwords found.\n";
