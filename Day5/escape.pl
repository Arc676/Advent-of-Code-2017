#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;
open my $file, "<", $filename or die "Failed to open file\n";

my @jumps = ();
while (<$file>) {
	chomp $_;
	push @jumps, $_;
}
close $file;

my $jumpCount = 0;
my $index = 0;
while ($index >= 0 && $index < scalar(@jumps)) {
	my $tmp = $jumps[$index];
	$jumps[$index]++;
	$index += $tmp;
	$jumpCount++;
}
print "Escaped maze after " . $jumpCount . " jumps\n";
