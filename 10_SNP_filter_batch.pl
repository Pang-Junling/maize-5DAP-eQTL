#!usr/bin/perl
use strict;
my($file,$file2,$file3,$name);

my $dir="/public/home/pangjunling/5DAP_project/SNP_calling/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/SNP_filter_good/"; ### directory to write to
my $dir3="/public/home/pangjunling/5DAP_project/SNP_filter_bad/";

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+).vcf$/)
 {$name=$1;
  $file2=$name.".good.vcf";
  $file3=$name.".bad.vcf";
  system("zsub -e \"perl 10_SNP_filter_single.pl $dir/$file $dir2/$file2 $dir3/$file3 \"");
}
}
closedir DIR;
