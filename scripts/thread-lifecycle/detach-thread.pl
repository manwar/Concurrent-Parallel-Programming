#!/usr/bin/env perl

use v5.38;
use threads;

sub worker($id) {
  say "Thread $id started.";
  sleep 5;
  say "Thread $id finished.";
}

say "Main process started.";
threads->create(\&worker, 1)->detach;
say "Main process finished.";
