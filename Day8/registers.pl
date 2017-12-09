#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

my %registers = ();

my $max = 0;
open my $file, "<", $filename or die "Failed to open file\n";
while (<$file>) {
	# example:
	# b inc 5 if a > 1
	$_ =~ /(\w+) (...) (-?\d+) if (\w+) (.+)/;
	my $register = $1;
	my $delta = $2 eq "inc" ? 1 : -1;
	my $amount = $3;
	my $checkReg = $4;
	if (not defined $registers{$register}) {
		$registers{$register} = 0;
	}
	if (not defined $registers{$checkReg}) {
		$registers{$checkReg} = 0;
	}
	my $operation = "$registers{$checkReg}" . $5;
	if (eval "$operation") {
		$registers{$register} += $delta * $amount;
		if ($registers{$register} > $max) {
			$max = $registers{$register};
		}
	}
}
close $file;
print "Biggest value during operation was " . $max . "\n";

$max = 0;
my $bigReg = "";
foreach my $key (keys %registers) {
	print $key . " -> " . $registers{$key} . "\n";
	if ($registers{$key} > $max) {
		$max = $registers{$key};
		$bigReg = $key;
	}
}
print "Register " . $bigReg . " has value " . $max . "\n";
