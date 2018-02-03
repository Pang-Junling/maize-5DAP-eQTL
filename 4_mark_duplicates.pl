#!usr/bin/perl
use strict;
my($file,$file2,$file3,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_sort/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/bam_mark_dup/"; ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_rg_reorder_sort.bam/)
 {$name=$1;
  $file2=$name."_rg_reorder_sort_dedup.bam";
  $file3=$name."_rg_reorder_sort_dedup.metrics";
  system("zsub -e \"java -Xmx4g -jar ~/tool/picard-tools-1.119/MarkDuplicates.jar I=$dir/$file O=$dir2/$file2 M=$dir2/$file3 CREATE_INDEX=true VALIDATION_STRINGENCY=LENIENT\"");
}
}
closedir DIR;
