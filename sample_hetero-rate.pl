#!usr/bin/perl
use strict;

### Usages: perl sample_hetero-rate.pl SNP.vcf OUTPUT
#### By Junling Pang

my(@hang,@sample,$n,%count,%het,$tmp);

open F1,"<$ARGV[0]";  ##
while(<F1>)
{if($_=~/^#CHROM/)
   {chomp;
    @sample=split; 
   }
 elsif($_!~/^#/)
   {chomp;
    @hang=split;
    for($n=9;$n<=$#hang;$n++)
     {if($hang[$n]=~/(\d)\/(\d)/)
        {$count{$sample[$n]}++;
         if($hang[$n]=~/0\/1/ || $hang[$n]=~/1\/0/)
           {$het{$sample[$n]}++;}
        }
     }    
   }
}
close F1;

open OUT,">>$ARGV[1]";  ## 
print OUT "Sample\tHetero-sites\tTotal_sites\tHetero-rate(%)\n";
for($n=9;$n<=$#sample;$n++)
{$tmp=$het{$sample[$n]}/$count{$sample[$n]}*100;
 print OUT "$sample[$n]\t$het{$sample[$n]}\t$count{$sample[$n]}\t$tmp\n";
}
close OUT;
