package MooseX::DeclinableBuilder;
use strict;
use warnings;
use Moose ();
use Moose::Exporter;
our $VERSION = '0.01';


Moose::Util::_create_alias(
    'Attribute', 'DeclinableBuilder', 1,
    'MooseX::DeclinableBuilder::Meta::Role::Attribute',
);

1;

__END__

=head1 NAME

MooseX::DeclinableBuilder - let your builders decline to return a value

=head1 SYNOPSIS

    has attr => (
        traits    => ['DeclinableBuilder'],
        is        => 'ro',
        builder   => '_build_attr',
        predicate => 'has_attr',
    );

    sub _build_attr {
        my ($self, $no_value) = @_;

        return $no_value if rand() < .333;
        return undef     if rand() < .5;
        return "ok";
    }

=head1 DESCRIPTION

Sometimes, you just need your builders to elect to return no value.
This is distinct from returning C<undef> or false, especially since
predicate treats a value of C<undef> as having a value.

This is very similar to L<MooseX::UndefTolerant> except this module
only modifies how builders work, and this module keeps C<undef> as a
distinct, usable value.

=head1 AUTHOR

Shawn M Moore C<sartak@gmail.com>

=head1 COPYRIGHT

Copyright 2011 Shawn M Moore.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

