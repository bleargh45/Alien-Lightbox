use strict;
use warnings;
use lib qw(inc lib);
use MY::Build;

MY::Build->new(
    'module_name'       => 'Alien::Lightbox',
    'license'           => 'perl',
    'dist_author'       => 'Graham TerMarsch (cpan@howlingfrog.com)',
    'build_requires'    => { 'Archive::Zip'     => 0,
                             'Test::Exception'  => 0,
                           },
    )->create_build_script();
