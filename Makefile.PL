###############
# MAKEFILE.PL #
###############

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'ePod' ,
    'VERSION_FROM'  => 'lib/ePod.pm' ,
    #'PREREQ_PM'     => {'Foo'  => 0.01} ,
    ($] >= 5.005 ?
      ( ABSTRACT_FROM => 'lib/ePod.pm',
        AUTHOR        => 'Graciliano M. P. <gm@virtuasites.com.br>'
       ) : ()
     ),
);

1;

