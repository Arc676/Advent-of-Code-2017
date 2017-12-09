#!/usr/bin/perl

use strict;
use warnings;

print "Enter filename: ";
my $filename = <STDIN>;
chomp $filename;

my %allprogs = ();
open my $file, "<", $filename or die "Failed to open file\n";
while (<$file>) {
	my $line = $_;
	chomp $line;
	$line =~ /(\w+) \(\d+\)(.+)?$/;
	my $prog = $1;
	my $leaves = $2;
	if (not defined $allprogs{$prog}) {
		$allprogs{$prog} = 1;
	}
	if (defined $leaves) {
		$leaves =~ /-> (.+)/;
		my @progs = split ', ', $1;
		foreach my $leafProg (@progs) {
			$allprogs{$leafProg} = 0;
		}
	}
}
close $file;

foreach my $key (keys %allprogs) {
	if ($allprogs{$key}) {
		print $key . "\n";
		last;
	}
}
