#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_add_rg/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/bam_reorder/"; ### directory to write to
opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_rg_added.bam/)
 {$name=$1;
  $file2=$name."_rg_reorder.bam";
  system("zsub -e \"java -Xmx2g -jar ~/tool/picard-tools-1.119/ReorderSam.jar I=$dir/$file O=$dir2/$file2 R=/public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.fa\"");
}
}
closedir DIR;
