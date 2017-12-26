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

my @queue1 = ();
my @queue2 = ();

my $sends = 0;

my %registersA = ();

my %registersB = ();
$registersB{"p"} = 1;

my $pcA = 0;
my $pcB = 0;

my $AWaiting = 0;
my $aDst = 0;

my $BWaiting = 0;
my $bDst = 0;

# This doesn't work... probably something wrong with the references
# Fix once better understanding of pointers in Perl is obtained
#sub runInstruction {
#	my (%registers, $a, $value, $cmd, $pc, @queue, $waiting, $dst) = (@_);
#	if ($cmd eq "set") {
#		$registers{$a} = $value;
#	} elsif ($cmd eq "add") {
#		$registers{$a} += $value;
#	} elsif ($cmd eq "mul") {
#		$registers{$a} *= $value;
#	} elsif ($cmd eq "mod") {
#		$registers{$a} %= $value;
#	} elsif ($cmd eq "snd") {
#		push @queue, $registers{$a};
#	} elsif ($cmd eq "rcv") {
#		$dst = $a;
#		$waiting = 1;
#	} elsif ($cmd eq "jgz") {
#		if ($registers{$a} != 0) {
#			$pc += $value - 1;
#		}
#	}
#	$pc++;
#	return $pc;
#}

while (1) {
	last if ($pcA < 0 or $pcA >= scalar(@instructions));
	last if ($pcB < 0 or $pcB >= scalar(@instructions));
	last if ($AWaiting && scalar(@queue2) == 0 && $BWaiting && scalar(@queue1) == 0);

	my ($cmdA, $aA, $valueA) = split ' ', $instructions[$pcA];
	my ($cmdB, $aB, $valueB) = split ' ', $instructions[$pcB];

	$registersA{$aA} = 0 if (not exists $registersA{$aA});
	$registersB{$aB} = 0 if (not exists $registersB{$aB});
	if (defined $valueA) {
		if ($valueA !~ /\d+/) {
			$registersA{$valueA} = 0 if (not exists $registersA{$valueA});
			$valueA = $registersA{$valueA};
		}
	}
	if (defined $valueB) {
		if ($valueB !~ /\d+/) {
			$registersB{$valueB} = 0 if (not exists $registersB{$valueB});
			$valueB = $registersB{$valueB};
		}
	}

	if ($AWaiting) {
		if (scalar(@queue2) > 0) {
			$registersA{$aDst} = shift @queue2;
			$AWaiting = 0;
		}
	} else {
		if ($cmdA eq "set") {
			$registersA{$aA} = $valueA;
		} elsif ($cmdA eq "add") {
			$registersA{$aA} += $valueA;
		} elsif ($cmdA eq "mul") {
			$registersA{$aA} *= $valueA;
		} elsif ($cmdA eq "mod") {
			$registersA{$aA} %= $valueA;
		} elsif ($cmdA eq "snd") {
			push @queue1, $registersA{$aA};
		} elsif ($cmdA eq "rcv") {
			$aDst = $aA;
			$AWaiting = 1;
		} elsif ($cmdA eq "jgz") {
			my $vA = $registersA{$aA};
			$vA = $aA if ($aA =~ /\d+/);
			if ($vA > 0) {
				$pcA += $valueA - 1;
			}
		}
		$pcA++;
	}
	if ($BWaiting) {
		if (scalar(@queue1) > 0) {
			$registersB{$bDst} = shift @queue1;
			$BWaiting = 0;
		}
	} else {
		$sends++ if ($cmdB eq "snd");
		if ($cmdB eq "set") {
			$registersB{$aB} = $valueB;
		} elsif ($cmdB eq "add") {
			$registersB{$aB} += $valueB;
		} elsif ($cmdB eq "mul") {
			$registersB{$aB} *= $valueB;
		} elsif ($cmdB eq "mod") {
			$registersB{$aB} %= $valueB;
		} elsif ($cmdB eq "snd") {
			push @queue2, $registersB{$aB};
		} elsif ($cmdB eq "rcv") {
			$bDst = $aB;
			$BWaiting = 1;
		} elsif ($cmdB eq "jgz") {
			my $vB = $registersB{$aB};
			$vB = $aB if ($aB =~ /\d+/);
			if ($vB > 0) {
				$pcB += $valueB - 1;
			}
		}
		$pcB++;
	}
}
print "Send count: " . $sends . "\n";
