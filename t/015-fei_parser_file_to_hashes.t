#
#  Author: Otavio Fernandes <otavio.fernandes@locaweb.com.br>
# Created: 01/31/2010 01:57:23
#

use strict;
use warnings;

use FEI::ACS::Parser;
use File::Slurp;
use Test::More tests => 6;

my $parser;
my $connect;
my $disconnect;
my $repeated;

#
# Testing Method Returns
#

$parser = new FEI::ACS::Parser( { path => 't/mock/acs.txt' } );

( $connect, $disconnect, $repeated ) = $parser->file_to_hashes();

isa_ok( $connect,    'HASH' );
isa_ok( $disconnect, 'HASH' );
isa_ok( $repeated,   'HASH' );

( $parser, $connect, $disconnect, $repeated )
    = ( undef, undef, undef, undef );

#
# Mock New File
#

my $acs_mock = '/var/tmp/mock-ACS-' . int( rand(1000) ) . '.tmp';
unlink($acs_mock) if ( -f $acs_mock );

write_file(
    $acs_mock,
    [   "10.68.2.114|C|00:10:27 11/01/2010|vod1_trl_H260709W.mpi\n",
        "10.68.2.114|D|00:10:40 11/01/2010|vod1_trl_H260709W.mpi\n",
    ]
);

$parser = new FEI::ACS::Parser( { path => $acs_mock } );

( $connect, $disconnect, $repeated ) = $parser->file_to_hashes();

ok( eq_hash(
        $connect,
        {   '10.68.2.114' => {
                'date' => '00:10:27 11/01/2010',
                'file' => 'vod1_trl_H260709W.mpi'
            }
        }
    ),
    "Should Pass, connection came from an mock file"
);

ok( eq_hash(
        $disconnect,
        {   '10.68.2.114' => {
                'date' => '00:10:40 11/01/2010',
                'file' => 'vod1_trl_H260709W.mpi'
            }
        }
    ),
    "Should Pass, disconnection came from an mock file"
);

ok( eq_hash( $repeated, {} ),
    "Should Pass, in this mock file thereis no repeated" );

unlink($acs_mock);

__END__
