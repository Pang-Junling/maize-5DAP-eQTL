#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_splitN/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/bam_realign/"; ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_rg_reorder_sort_dedup_splitN.bam/)
 {$name=$1;
  $file2=$name."_rg_reorder_sort_dedup_splitN_realign.bam";
  system("zsub -e \"java -Xmx4g -jar /public/home/pangjunling/tool/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T IndelRealigner -R /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.fa -I $dir/$file -o $dir2/$file2 -targetIntervals /public/home/pangjunling/genome/AGPv3.27/vcf/zea_mays.indel.reorder.intervals -known /public/home/pangjunling/genome/AGPv3.27/vcf/zea_mays.indel.reorder.vcf\"");
}
}
closedir DIR;
