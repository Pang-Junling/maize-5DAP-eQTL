#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_reorder/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/bam_sort/"; ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_rg_reorder.bam/)
 {$name=$1;
  $file2=$name."_rg_reorder_sort.bam";
  system("zsub -e \"java -Xmx4g -jar ~/tool/picard-tools-1.119/SortSam.jar I=$dir/$file O=$dir2/$file2 SORT_ORDER=coordinate\"");
}
}
closedir DIR;
