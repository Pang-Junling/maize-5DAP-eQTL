#!usr/bin/perl
use strict;

### Usages: perl SNP_hetero-rate.pl SNP.vcf OUTPUT
### By Junling Pang

my(@hang,$n,$ref,$alt,$het,$rate,$miss,$miss_rate);

open OUT,">>$ARGV[1]"; ###
print OUT "SNP\t00_num\t11_num\t01_num\thetero-rate(%)\tmissing_rate(%)\n";

open F1,"<$ARGV[0]";  ### vcf file, 0/0; 0/1; 1/1; ./. 
while(<F1>)
{if($_=~/^#/)
  {# print OUT "$_";
  }
 else
  {chomp;
   @hang=split(/\t/);
   $ref=0;
   $alt=0;
   $het=0;
   $miss=0;
   for($n=9;$n<=$#hang;$n++)
    {if($hang[$n]=~/0\/1/ || $hang[$n]=~/1\/0/)
      {$het++;}
     elsif($hang[$n]=~/0\/0/)
      {$ref++;}
     elsif($hang[$n]=~/1\/1/)
      {$alt++;}
     elsif($hang[$n]=~/\.\/\./)
      {$miss++;
      }
    }
   if(($het+$ref+$alt)==0){$rate=1;}
   else {$rate=$het/($het+$ref+$alt)*100;}
   $miss_rate=$miss/($het+$ref+$alt+$miss)*100;
   print OUT "$hang[2]\t$ref\t$alt\t$het\t$rate\t$miss_rate\n";
  }
}

close F1;
close OUT;
