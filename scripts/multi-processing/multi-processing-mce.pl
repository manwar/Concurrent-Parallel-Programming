#!/usr/bin/env perl

use v5.38;
use MCE;

say "Parent process PID: $$\n";
say "Starting 5 processes.";
my $mce = MCE->new(
   max_workers => 5,
   user_func => sub {
      my ($mce) = @_;
      $mce->say("Child process " . $mce->wid . " (PID:$$) started.");
      sleep(2);
      $mce->say("Child process " . $mce->wid . " (PID: $$) finished.");
   }
);
$mce->run;
