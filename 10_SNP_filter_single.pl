##########################################################
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  001
#0/0 format:
#1       7818    .       T       .       248.23  .       AN=2;DP=88;MQ=50.00     GT:AD:DP        0/0:88:88
#
#0/1 format:
#1       6743    .       G       A       612.77  .       AC=1;AF=0.500;AN=2;BaseQRankSum=-4.571;ClippingRankSum=0.000;DP=101;ExcessHet=3.0103;FS=37.295;MLEAC=1;MLEAF=0.500;MQ=50.00;MQRankSum=0.000;QD=6.07;ReadPosRankSum=0.233;SOR=3.136      GT:AD:DP:GQ:PL  0/1:80,21:101:99:641,0,5104
#
#1/1 format:
#1       3498    .       A       G       253.78  .       AC=2;AF=1.00;AN=2;DP=9;ExcessHet=3.0103;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=50.00;QD=28.20;SOR=0.892 GT:AD:DP:GQ:PL  1/1:0,9:9:27:282,27,0
#
#./. or 1/2 format
#9       13664332        .       T       C       324.78  .       AC=1;AF=0.500;AN=2;BaseQRankSum=-0.661;ClippingRankSum=0.000;DP=12;ExcessHet=3.0103;FS=4.771;MLEAC=1;MLEAF=0.500;MQ=50.00;MQRankSum=0.000;QD=27.06;ReadPosRankSum=-0.580;SOR=1.670      GT      ./.
#9       104193665       .       GTT     G,GT    616.73  .       AC=1,1;AF=0.500,0.500;AN=2;DP=22;ExcessHet=3.0103;FS=0.000;MLEAC=1,1;MLEAF=0.500,0.500;MQ=50.00;QD=28.03;SOR=1.609      GT:AD:DP:GQ:PL  1/2:0,15,7:22:99:654,159,118,387,0,327
#
##########################################################
#
#!usr/bin/perl
use strict;
my($fs,$qd,@hang,$dp);

open OUT2,">>$ARGV[2]"; ## new, bad filtered vcf
open OUT1,">>$ARGV[1]"; ## new, good filtered vcf
open F1,"<$ARGV[0]";  ## GATK raw output, vcf file
while(<F1>)
{if($_=~/^#/)
 {print OUT1 "$_";
  print OUT2 "$_";
 }
 elsif($_=~/1\/1/)
 {($fs,$qd)=($_=~/FS=(\S+);MLEAC\S+;QD=(\S+);SOR/);
  if($fs>30 && $qd<2){print OUT2 "$_";}
  else
   {print OUT1 "$_";}
 }
 elsif($_=~/0\/1/)
 {
  ($fs,$qd)=($_=~/FS=(\S+);MLEAC\S+;QD=(\S+);ReadPosRankSum/);
  if($fs>30 && $qd<2){print OUT2 "$_";}
  else
   {print OUT1 "$_";}
 }
 #elsif($_=~/0\/0/)
 #{chomp;
 # @hang=split;
 # ($dp)=($_=~/DP=(\S+);MQ/);
 # if($dp==0){print OUT2 "$_\n";}
 # else
 # {
 # $qd=$hang[5]/$dp;
 # if($qd<2){print OUT2 "$_\n";}
 # else
 #  {print OUT1 "$_\n";}
 # }
 #}
 else {print OUT2 "$_";}
}
close F1;
close OUT1;
close OUT2;
