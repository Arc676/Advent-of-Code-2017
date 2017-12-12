#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;
open my $file, "<", $filename or die "Failed to open file\n";

my %movements = (
	n => 0,
	ne => 0,
	se => 0,
	s => 0,
	sw => 0,
	nw => 0
);

my $line = <$file>;
chomp $line;

foreach my $direction (split ',', $line) {
	$movements{$direction}++;
}

my @opposites = (
	"n/s",
	"ne/sw",
	"nw/se"
);

foreach my $pair (@opposites) {
	my @dirs = split '/', $pair;
	if ($movements{$dirs[0]} > $movements{$dirs[1]}) {
		$movements{$dirs[0]} -= $movements{$dirs[1]};
	} else {
		$movements{$dirs[1]} -= $movements{$dirs[0]};
	}
}

my @optimizations = (
	"ne,nw/n",
	"se,sw/s",
	"ne,s/se",
	"nw,s/sw",
	"se,n/ne",
	"sw,n/sw"
);

foreach my $set (@optimizations) {
	my @parts = split '/', $set;
	my @dirs = split ',', $parts[0];
	my $res = $parts[1];
	while ($movements{$dirs[0]} > 0 && $movements{$dirs[1]} > 0) {
		$movements{$dirs[0]}--;
		$movements{$dirs[1]}--;
		$movements{$res}++;
	}
}

my $sum = 0;
foreach my $key (keys %movements) {
	$sum += $movements{$key};
	print $key . " -> " . $movements{$key} . "\n";
}
print "Sum: " . $sum . "\n";
