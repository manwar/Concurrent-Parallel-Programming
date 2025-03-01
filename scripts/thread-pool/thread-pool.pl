#!/usr/bin/env perl

use v5.38;
use threads;
use Thread::Pool;

sub worker($task_id) {
    my $id = threads->self->tid();
    say "Thread $id doing task: $task_id";
}

my $pool = Thread::Pool->new({ workers => 5, do => \&worker });
$pool->job($_) for (1..9);
$pool->shutdown();
