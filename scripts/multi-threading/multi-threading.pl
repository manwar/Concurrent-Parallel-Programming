#!/usr/bin/env perl

use v5.38;
use threads;

sub worker($t_id) {
    say "Thread $t_id started.";
    sleep(2);
    say "Thread $t_id finished.";
    return $t_id;
}

say "Process ID: $$";
say "Starting 5 threads.";

my @threads;
for my $i (1..5) {
    my $thread = threads->create(\&worker, $i);
    push @threads, $thread;
}

$_->join foreach @threads;
