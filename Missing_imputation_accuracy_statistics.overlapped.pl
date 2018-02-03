#!usr/bin/perl
use strict;

### Usages: perl Missing_imputation_accuracy_statistics.overlapped.pl SNP_before_imputation.vcf beagle_with-ref.vcf beagle-without-ref.vcf accuracy_statistics.xls
### By Junling Pang

my(@hang,$n,%pos,%pos1,$right,$wrong,$snp);

open F1,"<$ARGV[0]";  ### before imputation
while(<F1>)
{if($_!~/^#/)
  {chomp; 
   @hang=split(/\t/);
   for($n=9;$n<=$#hang;$n++)
    {if($hang[$n] eq "./.")
      {$pos{$hang[0]."\t".$hang[1]}{$n}=1;}
    }
  }
}
close F1;

open F2,"<$ARGV[1]";  ## beagle-with-ref
while(<F2>)
{if($_!~/^#/)
  {chomp;
   @hang=split(/\t/);
   for($n=9;$n<=$#hang;$n++)
    {if(exists $pos{$hang[0]."\t".$hang[1]}{$n})
      {($snp)=($hang[$n]=~/(\d\|\d)/); $pos1{$hang[0]."\t".$hang[1]}{$n}=$snp;}
    }
  }

}
close F2;

open OUT, ">>$ARGV[3]";  ### statistics

print OUT "Chr\tPOS\tSNP_NAME\tRight_num\tWrong_num\n";

open F3,"<$ARGV[2]";  ### beagle-without-ref
while(<F3>)
{if($_!~/^#/)
  {chomp;
   @hang=split(/\t/);
   $right=0;
   $wrong=0;
   if(exists $pos1{$hang[0]."\t".$hang[1]})
   {
   for($n=9;$n<=$#hang;$n++)
    {if(exists $pos1{$hang[0]."\t".$hang[1]}{$n} && $pos1{$hang[0]."\t".$hang[1]}{$n} != 1)  ### overlapped sites
      {($snp)=($hang[$n]=~/(\d\|\d)/);
       if($pos1{$hang[0]."\t".$hang[1]}{$n} eq $snp)
          {$right++;}
#       elsif(($pos{$hang[0]."\t".$hang[1]}{$n} eq "0|1" && $snp eq "1|0") || ($snp eq "0|1" && $pos{$hang[0]."\t".$hang[1]}{$n} eq "1|0"))
#          {$right++;}
       else
          {$wrong++;}
      }
    }
   print OUT "$hang[0]\t$hang[1]\t$hang[2]\t$right\t$wrong\n";
  }
  }
}
close F3;

close OUT;
