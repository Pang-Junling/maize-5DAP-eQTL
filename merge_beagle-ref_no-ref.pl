#!usr/bin/perl
use strict;

### Usages: perl merge_beagle-ref_no-ref.pl with-ref.vcf no-ref.vcf merged.vcf
### By Junling Pang

my(@hang,%list);

open OUT,">>$ARGV[2]";  ### merged.vcf

open F1,"<$ARGV[0]";  ### with ref vcf
while(<F1>)
{if($_=~/^#/)
  {print OUT "$_";
  }
 else
  {print OUT "$_";
   chomp;
   @hang=split;
   $list{$hang[2]}=1; 
  }
}
close F1;

open F2,"<$ARGV[1]"; ### no-ref vcf
while(<F2>)
{chomp;
 @hang=split;
 if($_!~/^#/ && (! exists $list{$hang[2]}))
  {print OUT "$_\n";
  }
} 
close F2;

close OUT;
