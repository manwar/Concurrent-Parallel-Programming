#!/usr/bin/env perl

use v5.38;
use threads;
use Time::HiRes qw(time);

sub cpu_worker($id) {
    my $result = 0;
    for (my $i = 0; $i < 10_000_000; $i++) {
        $result += sqrt($i);
    }
    say "Thread $id completed.";
}

my $start_time = time();
my @threads = map { threads->create(\&cpu_worker, $_) } (1..9);
$_->join for @threads;
my $end_time = time();

printf("Total time taken: %.2f seconds\n", $end_time - $start_time);
