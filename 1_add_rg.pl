#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/tophat_uniq_filtered/";  ### directory to deal with
my $dir2="/public/home/pangjunling/5DAP_project/bam_add_rg/";
opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_accepted_filtered.bam/)
 {$name=$1;
  $file2=$name."_rg_added.bam";
  system("zsub -e \"java -Xmx2g -jar ~/tool/picard-tools-1.119/AddOrReplaceReadGroups.jar I=$dir/$file O=$dir2/$file2 ID=$name LB=$name PL=illumina PU=run SM=$name\"");
}
}
closedir DIR;
