use inc::Module::Install;

name           'MooseX-DeclinableBuilder';
all_from       'lib/MooseX/DeclinableBuilder.pm';
readme_from    'lib/MooseX/DeclinableBuilder.pm';
githubmeta;

requires       'Moose';

manifest_skip;
auto_manifest;
WriteAll;

