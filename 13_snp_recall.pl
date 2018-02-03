#!usr/bin/perl
use strict;
my($file,$file2,$name);

my $dir="/public/home/pangjunling/5DAP_project/bam_recal/";  ### directory to deal with 
my $dir2="/public/home/pangjunling/5DAP_project/SNP_recall/"; ### directory to write to

opendir DIR,"$dir";
while($file=readdir(DIR))
{if($file=~/(\S+)_recal.bam/)
 {$name=$1;
  $file2=$name.".vcf";
  system("zsub -e \"java -Xmx8g -jar /public/home/pangjunling/tool/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T HaplotypeCaller  -R /public/home/pangjunling/genome/AGPv3.27/B73.AGPv3.27.fa -I $dir/$file -dontUseSoftClippedBases -stand_call_conf 20 -stand_emit_conf 20 -out_mode EMIT_ALL_SITES -alleles /public/home/pangjunling/5DAP_project/analysis/20160711/SNP_318merge.only11.rename.SNV.vcf -gt_mode GENOTYPE_GIVEN_ALLELES -o $dir2/$file2\"");
}
}
closedir DIR;
