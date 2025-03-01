#!/usr/bin/env perl

use v5.38;
use Parallel::ForkManager;

my $pm = Parallel::ForkManager->new(5);

$pm->run_on_finish(sub {
    my ($pid, $exit_code) = @_;
    if ($exit_code == 0) {
        say "Child process $pid finished.";
    }
});

say "Parent process PID: $$\n";
say "Starting 5 processes.";
foreach (1..5) {
    $pm->start and next;

    say "Child process $$ started.";
    sleep(2);

    $pm->finish(0);
}

$pm->wait_all_children;
