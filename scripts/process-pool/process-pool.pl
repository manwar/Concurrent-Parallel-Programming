#!/usr/bin/env perl

use v5.38;
use MCE;

my $mce = MCE->new(
    max_workers => 5,
    chunk_size  => 1,
    user_func   => sub {
        my ($mce, $chunk_ref, $chunk_id) = @_;
        my $task_id = $chunk_ref->[0];
        say "Process ", $mce->wid, " doing task: $task_id";
    },
);

$mce->process([0..9]);
$mce->shutdown;
