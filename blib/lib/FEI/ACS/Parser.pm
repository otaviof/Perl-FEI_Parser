package FEI::ACS::Parser;

use warnings;
use strict;

our $VERSION = '0.01';

use Moose;

has 'path' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    trigger  => \&_set_path,
);

sub _set_path {
    my ( $self, $path ) = @_;
    confess "File not found: $path" if ( !-f $path );
}

sub file_to_hashes {
    my ($self) = @_;
    open( my $fh, '<', $self->{path} )
        or confess $1;
    my %parsed;
    while ( my $line = <$fh> ) {
        chomp $line;
        next
            if ( $line !~ /^(.*?)\|(.*?)\|(.*?)\|(.*?)$/ );

        # searching for repeated lines
        if (( $parsed{$2}->{$1}->{date} and $parsed{$2}->{$1}->{file} )
            and (   $parsed{$2}->{$1}->{date} eq $3
                and $parsed{$2}->{$1}->{file} eq $4 )
            )
        {
            $parsed{R}->{$1}->{date} = $3;
            $parsed{R}->{$1}->{file} = $4;
            next;
        }

        $parsed{$2}->{$1}->{date} = $3;
        $parsed{$2}->{$1}->{file} = $4;
    }
    close($fh);
    return (
        ( $parsed{C} ) ? $parsed{C} : {},
        ( $parsed{D} ) ? $parsed{D} : {},
        ( $parsed{R} ) ? $parsed{R} : {},
    );
}

1;

__END__
