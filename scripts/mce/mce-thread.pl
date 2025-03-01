#/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;
use MCE;

my $counter :shared = 0;

my $mce = MCE->new(
    max_workers => 5,
    chunk_size  => 1,
    user_func   => sub {
        my ($mce, $chunk_ref, $chunk_id) = @_;
        my $task = $chunk_ref->[0];

        {
            lock($counter);
            $counter += $task;
        }

        my $tid = threads->tid;
        say "Process $$ - Thread $tid: task $task";
    },
);

$mce->spawn;
$mce->process([1..5]);
$mce->shutdown;

say "Final counter: $counter";
