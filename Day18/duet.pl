#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;
open my $file, "<", $filename or die "Failed to open file\n";

my @instructions = ();
while (<$file>) {
	chomp $_;
	push @instructions, $_;
}
close $file;

my %registers = ();
my $lastSound = 0;
my $pc = 0;
while (1) {
	last if ($pc < 0 or $pc >= scalar(@instructions));
	my ($cmd, $a, $value) = split ' ', $instructions[$pc];
	$registers{$a} = 0 if (not exists $registers{$a});
	if (defined $value) {
		if ($value !~ /\d+/) {
			$registers{$value} = 0 if (not exists $registers{$value});
			$value = $registers{$value};
		}
	}
	if ($cmd eq "set") {
		$registers{$a} = $value;
	} elsif ($cmd eq "add") {
		$registers{$a} += $value;
	} elsif ($cmd eq "mul") {
		$registers{$a} *= $value;
	} elsif ($cmd eq "mod") {
		$registers{$a} %= $value;
	} elsif ($cmd eq "snd") {
		$lastSound = $registers{$a};
	} elsif ($cmd eq "rcv") {
		if ($registers{$a} != 0) {
			print "Last sound played: " . $lastSound . "\n";
			last;
		}
	} elsif ($cmd eq "jgz") {
		if ($registers{$a} != 0) {
			$pc += $value - 1;
		}
	}
	$pc++;
}
print "Program terminated\n";
