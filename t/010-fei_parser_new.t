#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 01/31/2010 01:52:41
#

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok('FEI::ACS::Parser');
    use FEI::ACS::Parser;
}

my $parser = new_ok( 'FEI::ACS::Parser', [ { path => 't/mock/acs.txt' } ] );

__END__
