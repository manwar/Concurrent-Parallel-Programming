#!/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;

my $rlock :shared = 1;

sub worker {
    my $id = threads->tid();
    lock($rlock);
    say "Thread: $id acquired the lock.";
    {
        say "Thread: $id re-acquired the same lock.";
        lock($rlock);
        sleep(1);
        say "Thread: $id released the nested lock.";
    }
    say "Thread: $id released the lock.";
}

threads->create(\&worker)->join();
