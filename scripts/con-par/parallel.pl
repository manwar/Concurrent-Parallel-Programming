#!/usr/bin/env perl

use v5.38;
use threads;

sub worker($id) {
    my $result = 0;
    for (my $i = 0; $i < 1_000_000; $i++) {
        $result += sqrt($i);
    }
    say "Task $id result: $result";
}

my @threads = map { threads->create(\&worker, $_) } (1..2);
$_->join for @threads;
print "All tasks done!\n";
