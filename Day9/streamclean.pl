#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

open my $file, "<", $filename or die "Failed to open file\n";
my $line = <$file>;
close $file;

$line =~ s/!.//g;

my $removed = 0;
while ($line =~ s/<(.*?)>//) {
	$removed += length $1;
}
print "Removed garbage characters: " . $removed . "\n";

$line =~ s/[^{}]//g;

my $score = 0;
my $total = 0;
foreach my $i (split //, $line) {
	if ($i eq "{") {
		$score++;
		$total += $score;
	} elsif ($i eq "}") {
		$score--;
	}
}
print "Total score: " . $total . "\n";
