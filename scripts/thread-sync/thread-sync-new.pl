#!/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;

my $resource :shared = 0;

sub worker {
    my $id = shift;

    lock $resource;
    $resource++;
    say "In thread $id, shared resource=$resource";
}

threads->create(\&worker, $_)->join foreach 1..5;

say "Final value of shared resource=$resource";
