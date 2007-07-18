use strict;
use warnings;
use Test::More tests => 5;
use Test::Exception;
use File::Path qw(rmtree);
use Alien::Lightbox;

my $dir = 't/eraseme';

# Do an install and make sure that at least one file from each of the 'lib' and
# 'src' directories was installed properly.
Alien::Lightbox->install( $dir );
foreach my $file (qw( prototype.js effects.js scriptaculous.js lightbox.js )) {
    ok( -e "$dir/$file", "$dir/$file exists" );
}

# Re-install into the same directory, to make sure that it doesn't choke.
lives_ok { Alien::Lightbox->install($dir) };

# Clean out the test directory
rmtree( $dir );
