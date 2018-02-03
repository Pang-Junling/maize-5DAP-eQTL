#!usr/bin/perl
use strict;
my($file,$file2,$file3,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_realign_part2/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/bam_recal/"; ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_rg_reorder_sort_dedup_splitN_realign.bam/)
 {$name=$1;
  $file2=$name."_recal.grp";
  $file3=$name."_recal.bam";
  system("zsub -e \"java -Xmx4g -jar /public/home/pangjunling/tool/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T PrintReads -R /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.fa -I $dir/$file -o $dir2/$file3 -BQSR $dir/$file2\"");
}
}
closedir DIR;
