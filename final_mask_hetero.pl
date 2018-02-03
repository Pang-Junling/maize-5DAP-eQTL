#!usr/bin/perl
use strict;

### Usages: perl final_mask_hetero.pl hetero-to-missing.sites imputed.vcf final.vcf
### By Junling Pang

my(@hang,$n,%list);

####################  the input hetero-to-missing.sites of this program is the output of vcf_hetero-to-missing.pl program  
#5DAP-SNP.rm-ht-samples.heter10_missing40.hetero-to-missing.sites
#S1_1155 198
#S1_1192
#S1_1765 127
######################

open F1,"<$ARGV[0]";  ### *sites
while(<F1>)
{chomp;
 @hang=split;
 if(@hang > 1)
  {for($n=1;$n<=$#hang;$n++)
   {
    $list{$hang[0]}{$hang[$n]}=1;
   }
  }
}
close F1;

open OUT,">>$ARGV[2]";   ### final.vcf

open F2,"<$ARGV[1]";  ### *imputed*.vcf
while(<F2>)
{if($_=~/^#/)
  {print OUT "$_";}
 else
  {chomp;
   @hang=split;
   for($n=9;$n<=$#hang;$n++)
     {if(exists $list{$hang[2]}{$n} || $hang[$n]=~/0\|1/ || $hang[$n]=~/1\|0/)   ###
       {$hang[$n]="./.";}
     }
   print OUT join("\t",@hang);
   print OUT "\n";
  }
}
close F2;

close OUT;

