#!/usr/bin/env perl

use v5.38;
use Future;
use IO::Async::Loop;

my $loop = IO::Async::Loop->new;

sub fetch {
    my $future = $loop->new_future;
    $loop->delay_future(after => 1)->on_done(sub {
        $future->done({ data => "Fetched data" });
    });
    return $future;
}

sub process($data) {
    my $future = $loop->new_future;
    $loop->delay_future(after => 1)->on_done(sub {
        $data->{processed} = "Processed: " . $data->{data};
        $future->done($data);
    });
    return $future;
}

sub save($data) {
    my $future = $loop->new_future;
    $loop->delay_future(after => 1)->on_done(sub {
        $data->{saved} = "Saved: " . $data->{processed};
        $future->done($data);
    });
    return $future;
}

sub display($data) {
    say "Displaying data: " . $data->{saved};
    return Future->done;
}

sub error($message) {
    say "Error: $message";
    return Future->done;
}

$loop->await(
    fetch()
    ->then( sub { return process(@_); })
    ->then( sub { return save(@_);    })
    ->then( sub { return display(@_); })
    ->catch(sub { return error(@_);   })
);
