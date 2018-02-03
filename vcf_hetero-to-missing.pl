#!usr/bin/perl
use strict;

### Usages: perl vcf_hetero-to-missing.pl SNP.vcf SNP_hetero-to-missing.vcf hetero-to-missing.sites
### By Junling Pang

my(@hang,$n);

open OUT1,">>$ARGV[1]";  ## output vcf
open OUT2,">>$ARGV[2]";  ## output with masked sites (start from 0)

open F1,"<$ARGV[0]";  ## vcf
while(<F1>)
{if($_=~/^#/)
   {print OUT1 "$_";}
 else
   {chomp;
    @hang=split;
    print OUT2 "$hang[2]";
    for($n=9;$n<=$#hang;$n++)
     {if($hang[$n]=~/0\/1/ || $hang[$n]=~/1\/0/ || $hang[$n]=~/0\|1/ || $hang[$n]=~/1\|0/)
        {$hang[$n]="./.";
         print OUT2 "\t$n";
        }
     }
    print OUT2 "\n";
    print OUT1 join("\t",@hang);
    print OUT1 "\n";
   }
}
close F1;

close OUT1;
close OUT2;
