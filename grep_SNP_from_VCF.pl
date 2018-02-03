#!usr/bin/perl
use strict;

### Usages: perl grep_SNP_from_VCF.pl SNP.list SNP.vcf out.vcf 
### By Junling Pang

my(%list,@hang);

open F3,">>$ARGV[2]";  ### output_file
open F1,"<$ARGV[0]";  ### list  ### one row one SNP name, corresponding to the third colomn of vcf file
while(<F1>)
{chomp;
 @hang=split;
 $list{$hang[0]}=1;
}
close F1;

open F2,"<$ARGV[1]";   ### search_file
while(<F2>)
{if($_=~/^#/)
  {print F3 "$_";}
 else
  {
 chomp;
 @hang=split;
 if(exists $list{$hang[2]})
   {print F3 "$_\n";}
  }
}
close F2;
close F3;
