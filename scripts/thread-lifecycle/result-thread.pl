#!/usr/bin/env perl

use v5.38;
use threads;

sub worker($id) {
  say "Thread $id started.";
  sleep  5;
  say "Thread $id finished.";
  return $id * 2;
}

say "Main process started.";
my $thread = threads->create(\&worker, 1);
say "Result from thread: ", $thread->join;
say "Main process finished.";
