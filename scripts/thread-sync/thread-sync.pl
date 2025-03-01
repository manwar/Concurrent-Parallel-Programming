#!/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;
use Thread::Semaphore;

my $semaphore = Thread::Semaphore->new(1);
my $resource :shared = 0;

sub worker {
    my $id = shift;

    $semaphore->down();

    $resource++;
    say "In thread $id, shared resource=$resource";

    $semaphore->up();
}

threads->create(\&worker, $_)->join foreach 1..5;

say "Final value of shared resource=$resource";
