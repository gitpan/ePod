#########################

###use Data::Dumper ; print Dumper(  ) ;

use Test;
BEGIN { plan tests => 1 } ;

use ePod ;

use strict ;
use warnings qw'all' ;

###########
# CAT_DIR #
###########

sub cat_dir {
  my ( $DIR ) = @_ ;
  opendir (my $dh, $DIR);

  my @files ;

  while (my $filename = readdir $dh) {
    if ($filename =~ /^(.*?)\.epod$/i) {
      push(@files , "$DIR/$1") ;
    }
  }

  closedir ($dh);
  
  return @files ;
}

############
# CAT_FILE #
############

sub cat_file {
  my ( $file ) = @_ ;
  my $data = '' ;
  open (my $fh,$file) ;
  1 while( read($fh, $data , 1024*8 , length($data) ) ) ;
  close ($fh) ;
  $data =~ s/\r\n?/\n/gs ;
  return $data ;
}

#########################
{

  use ePod ;

  my $epod = new ePod( over_size => 10 ) ;
  
  my @files = cat_dir('./test') ;
  
  foreach my $files_i ( sort @files ) {
    print "testing: $files_i.epod ". ('.' x (18 - length($files_i)) ) ."... " ;

    my $pod = $epod->epod2pod( "$files_i.epod" ) ;
    ##my (undef , $pod) = $epod->to_pod( "$files_i.epod" , "$files_i.pod" , 1 ) ; ## To generate the PODs

    my $chk_pod = cat_file("$files_i.pod") ;
    
    print "*** ERRO with file: $files_i.epod\n" if $pod ne $chk_pod ;
    ok($pod , $chk_pod) ;
  }

  
}
#########################

print "\nThe End! By!\n" ;

1 ;

