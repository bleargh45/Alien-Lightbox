package Alien::Lightbox;

# Required inclusions.
use strict;
use warnings;
use Carp;
use File::Copy qw(copy);
use File::Path qw(mkpath);
use File::Find qw(find);
use File::Basename qw(dirname);

# Version number
our $VERSION = '2.03.3';

# Returns the Lightbox version number.
sub version {
    return $VERSION;
}

# Returns the path to the available copy of Lightbox.
sub path {
    my $base = $INC{'Alien/Lightbox.pm'};
    $base =~ s{\.pm$}{};
    return $base;
}

# Installs the Lightbox into the given '$destdir'.
sub install {
    my ($class, $destdir) = @_;
    if (!-d $destdir) {
        mkpath( [$destdir] ) || croak "can't create '$destdir'; $!";
    }
    my $path = $class->path();

    # Install JS files
    my @files = grep { -f $_ } glob "$path/js/*.js";
    foreach my $file (@files) {
        copy( $file, $destdir ) || croak "can't copy '$file' to '$destdir'; $!";
    }

    # Install CSS/image files
    my $css_srcdir = "$path/css";
    my $img_srcdir = "$path/images";
    @files = ();
    File::Find::find(
        sub { -f $_ && push(@files, $File::Find::name) },
        $css_srcdir,
        $img_srcdir
        );
    foreach my $file (@files) {
        my $destfile = $file;
        $destfile =~ s{$path}{$destdir/lightbox};

        my $destpath = dirname( $destfile );
        if (!-d $destpath) {
            mkpath( [$destpath] ) || croak "can't create '$destpath'; $!";
        }
        copy( $file, $destpath ) || croak "can't copy '$file' to '$destpath'; $!";
    }
}

1;

=head1 NAME

Alien::Lightbox - installing and finding Lightbox JS

=head1 SYNOPSIS

  use Alien::Lightbox;
  ...
  $version = Alien::Lightbox->version();
  $path    = Alien::Lightbox->path();
  ...
  Alien::Lightbox->install( $my_destination_directory );

=head1 DESCRIPTION

Please see L<Alien> for the manifesto of the Alien namespace.

=head1 AUTHOR

Graham TerMarsch (cpan@howlingfrog.com)

=head1 LICENSE

Copyright (C) 2007, Graham TerMarsch.  All rights reserved.

This is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

http://www.huddletogether.com/projects/lightbox2/,
L<Alien>.

=cut
