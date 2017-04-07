use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'                => 'Parse::Emacspeak',
    'VERSION_FROM'        => 'Emacspeak.pm', # finds $VERSION
    'PREREQ_PM'                => { Parse::Yapp => 1.05 },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Emacspeak.pm', # retrieve abstract from module
       AUTHOR     => 'Mike Ray <mike.ray@btinternet.com>') : ( )),
);
