#!/usr/bin/env perl

use v5.38;

sub worker($name) {
    say "Child process $name (PID: $$) started.";
    sleep(2);
    say "Child process $name (PID: $$) finished.";
}

say "Parent process PID: $$\n";
say "Starting 5 processes.";
my @child_pids;
for my $i (1..5) {
    my $pid = fork();

    if (!defined $pid) {
        die "Failed to fork: $!";
    } elsif ($pid == 0) {
        worker($i);
        exit;
    } else {
        push @child_pids, $pid;
    }
}

waitpid($_, 0) foreach @child_pids;
