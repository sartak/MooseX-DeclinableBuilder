use strict;
use warnings;
use Test::More;

{
    package Biblical::Man;
    use Moose;
    use MooseX::PassableBuilder;

    my %father_of = (
        Cain => 'Adam',
        Seth => 'Adam',
        Enos => 'Seth',
    );

    has name => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );

    has father => (
        traits    => ['PassableBuilder'],
        is        => 'ro',
        isa       => 'Str|Undef',
        builder   => '_build_father',
        predicate => 'has_father',
    );

    sub _build_father {
        my $self     = shift;
        my $no_value = shift;

        return $no_value if $self->name eq 'Adam';
        return $father_of{$self->name};
    }
}

my $adam = Biblical::Man->new(name => 'Adam');
is($adam->name, 'Adam');
is($adam->father, undef);
is($adam->has_father, 0, 'Adam explicitly has no father');

my $cain = Biblical::Man->new(name => 'Cain');
is($cain->name, 'Cain');
is($cain->father, 'Adam');
is($cain->has_father, 1);

my $enos = Biblical::Man->new(name => 'Enos');
is($enos->name, 'Enos');
is($enos->father, 'Seth');
is($enos->has_father, 1);

my $moses = Biblical::Man->new(name => 'Moses');
is($enos->name, 'Moses');
is($enos->father, undef);
is($enos->has_father, 1, 'Moses explicitly has a father');

done_testing;
