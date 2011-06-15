use strict;
use warnings;
use Test::More;

{
    package DeclinableTest;
    use Moose;
    use MooseX::DeclinableBuilder;

    has desired_result => (
        is => 'ro',
    );

    has result => (
        traits    => ['DeclinableBuilder'],
        is        => 'ro',
        builder   => '_build_result',
        lazy      => 1,
        predicate => 'has_result',
    );

    sub _build_result {
        my $self     = shift;
        my $no_value = shift;

        return 'ok'      if $self->desired_result eq 'ok';
        return $no_value if $self->desired_result eq 'no value';
        return undef;
    }
}

my $t = DeclinableTest->new(desired_result => 'ok');
is($t->result, 'ok', 'builder returned a real value');

$t = DeclinableTest->new(desired_result => '');
is($t->result, undef, 'result is undef');
ok($t->has_result, 'builder successfully returned undef');

$t = DeclinableTest->new(desired_result => 'no value');
is($t->result, undef, 'result is undef');
ok(!$t->has_result, 'builder successfully declined to return a value');

done_testing;
