#!/usr/bin/env perl

use v5.38;

sub worker {
    say "\tChild process (PID: $$) started.";
    sleep(2);
    say "\tChild process (PID: $$) finished.";
    exit(0);
}

sub parent {
    say "Parent process (PID: $$) started.";
    my $pid = fork();
    if ($pid == 0) {
        worker();
    } else {
        say "\tChild process (PID: $pid) created.";
        waitpid($pid, 0);
        say "Parent process (PID: $$) finished.";
    }
}

parent();
