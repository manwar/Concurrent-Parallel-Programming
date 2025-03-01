#/usr/bin/env perl

use v5.38;
use MCE;
use MCE::Shared;

my $counter = MCE::Shared->scalar(0);

my $mce = MCE->new(
    max_workers => 5,
    chunk_size  => 1,
    user_func   => sub {
        my ($mce, $chunk_ref, $chunk_id) = @_;
        my $task = $chunk_ref->[0];

        $counter->lock;
        my $value = $counter->get;
        $value += $task;
        $counter->set($value);
        $counter->unlock;

        say "Process $$: task $task";
    },
);

$mce->spawn;
$mce->process([1..5]);
$mce->shutdown;

say "Final counter: ", $counter->get;
