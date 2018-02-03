#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/SNP_filter_good/";  ### directory to deal with 

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+).good.vcf$/)
 {$name=" -V:$1 "."$dir/$file";
  $file2.=$name;
 }
}
closedir DIR;

system("zsub -p 10 -e \"java -Xmx60g -jar /public/home/pangjunling/tool/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T CombineVariants -nt 10 -R /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.fa $file2 -o SNP_318merge.keep11and01.vcf \"");
