#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="./tophat_all/";  ### directory to deal with
my $dir2="./tophat_uniq_filtered/";   ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_accepted_hits.bam/)
 {$name=$1;
  $file2=$name."_accepted_filtered.bam";
  system("zsub -e \"samtools view -h -q 50 $dir/$file | samtools view -bS - > $dir2/$file2\""); 
}
}
closedir DIR;
