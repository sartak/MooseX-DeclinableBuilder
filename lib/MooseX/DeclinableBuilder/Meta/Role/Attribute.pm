package MooseX::DeclinableBuilder::Meta::Role::Attribute;
use Moose::Role;

override _inline_generate_default => sub {
    my $self = shift;
    my ($instance, $default) = @_;

    if ($self->has_default) {
        return 'my ' . $default . ' = $attr->default(' . $instance . ');';
    }
    elsif ($self->has_builder) {
        return (
            'my ' . $default . ';',
            'my $no_value = bless [], "MooseX::DeclinableBuilder";',
            'if (my $builder = ' . $instance . '->can($attr->builder)) {',
                $default . ' = ' . $instance . '->$builder($no_value);',
                'return if ref($default) eq ref($no_value) && $default == $no_value;',
            '}',
            'else {',
                'my $class = ref(' . $instance . ') || ' . $instance . ';',
                'my $builder_name = $attr->builder;',
                'my $attr_name = $attr->name;',
                $self->_inline_throw_error(
                    '"$class does not support builder method '
                  . '\'$builder_name\' for attribute \'$attr_name\'"'
                ) . ';',
            '}',
        );
    }
    else {
        $self->throw_error(
            "Can't generate a default for " . $self->name
          . " since no default or builder was specified"
        );
    }
};

1;

