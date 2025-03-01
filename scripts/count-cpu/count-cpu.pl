#!/usr/bin/env perl

use v5.38;
use System::CPU;

say "Using System::CPU, count: ", System::CPU::get_ncpu;

open (my $FH, '<', '/proc/cpuinfo') or die "Can't open /proc/cpuinfo: $!";
my $cores = 0;
while (<$FH>) { $cores++ if /^processor\s*:/ }
close $FH;
say "Reading /proc/cpuinfo, count: $cores";
