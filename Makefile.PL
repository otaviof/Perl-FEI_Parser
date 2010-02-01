use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'FEI::ACS::Parser',
    AUTHOR       => 'Otavio Fernandes <otaviof@gmail.com>',
    VERSION_FROM => 'lib/FEI/ACS/Parser.pm',
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ( 'LICENSE' => 'perl' )
        : () ),
    PL_FILES  => {},
    PREREQ_PM => {
        'Moose'      => 0.94,
        'Test::More' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'FEI-Parser-*' },
);
