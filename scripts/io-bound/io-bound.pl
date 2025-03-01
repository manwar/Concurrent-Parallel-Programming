#!/usr/bin/env perl

use v5.38;
use threads;
use LWP::Simple;
use Time::HiRes qw(time);

sub io_worker($id) {
    my $url = "https://www.google.com";
    my $content = get($url);
    say "Thread $id finished.";
}

my $start_time = time();
my @threads = map { threads->create(\&io_worker, $_) } (1..9);
$_->join for @threads;
my $end_time = time();
printf("Total time taken: %.2f seconds\n", $end_time - $start_time);
