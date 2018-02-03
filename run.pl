#!usr/bin/perl
use strict;
my($file,$file2,$name);

 my $dir="./BC7A8VANXX/";  ### director to deal with

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+).R1/)
 {$name=$1;
  $file2=$name.".R2.clean.fastq.gz";
  system("zsub -p 24 -N $name -e \"tophat -o $dir/$name -i 5 -I 60000 --library-type fr-unstranded -p 24 -r 250 --mate-std-dev 60 --no-novel-juncs --microexon-search -G /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.gtf /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27 $dir/$file $dir/$file2\"");
 }
}
closedir DIR;
