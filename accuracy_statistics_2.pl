### Usages: perl accuracy_statistics_2.pl [output of accuracy_statistics_1.pl] [final_accuracy_statistics.txt]
### By Junling Pang

##############################################
##SNP_318merge.confirmed.all.rand-mask-3.chr10.beagle-no-ref.statistics
# Totatl 318 samples; for each SNP site, mask 3 or less samples.
#chr     pos     total_sample    missing_sample  mask-SNPs       impute-SNPs
#10      1368    318     317                     1/1:0,2:2:6:49,6,0                      1|0
#10      300972  318     65                      0/0:1,0:1:3:0,3,35      0/0:1,0:1:3:0,3,36      0/0:3,0:3:9:0,9,106                     0|0     0|0     0|0
################################################
#
#!usr/bin/perl
use strict;
my(@hang,%stat,$missing,$percent,$num,%right,%wrong,$n,$tmp);

open F1,"<$ARGV[0]";  ### SNP_318merge.confirmed.all.rand-mask-3.chr10.beagle-no-ref.statistics; || output of accuracy_statistics_1.pl
while(<F1>)
{if($_!~/^#/)
  {chomp;
   @hang=split;
   $missing=$hang[3]/$hang[2]+0.05;
   $percent=sprintf("%.1f",$missing);   ### ie. 0.56 belongs to <0.6 column ; sprintf 4 she 5 ru
  $num=($#hang-3)/2; 
   for($n=4;$n<=$num+3;$n++)   # $n and $n+$num are pairs
    {if($hang[$n]=~/0\/0/ && $hang[$n+$num]=~/0\|0/) {$right{$percent}++;}
     elsif($hang[$n]=~/1\/1/ && $hang[$n+$num]=~/1\|1/) {$right{$percent}++;}
     elsif($hang[$n]=~/0\/1/ && ($hang[$n+$num]=~/0\|1/ || $hang[$n+$num]=~/1\|0/)) {$right{$percent}++;}
     else {$wrong{$percent}++;}
    }
  }
}
close F1;

open OUT,">>$ARGV[1]";
print OUT "Missing_rate\tRight_num\tWrong_num\tAccuracy_rate\n";
for($n=0.1;$n<=1;$n+=0.1)
{$n=sprintf("%.1f",$n);
 if(! exists $right{$n})
  {$right{$n}=0;}
 if(! exists $wrong{$n})
  {$wrong{$n}=0;}
 if($right{$n}+$wrong{$n}==0){$tmp="NA";}
 else {$tmp=$right{$n}/($right{$n}+$wrong{$n});}
 print OUT "$n\t$right{$n}\t$wrong{$n}\t$tmp\n";
}
close OUT;
