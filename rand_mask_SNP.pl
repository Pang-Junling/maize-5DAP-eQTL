#!usr/bin/perl
use strict;

### Usage: perl rand_mask_SNP.pl SNP.vcf SNP_masked.vcf maksed_pos.txt
### By Junling Pang

my(@hang,$total,%pos,@pos,$n,$m,$rand,$rand2,$rand3);

my $mask_num=3; ### the number of sites needed to be masked per one SNP 

open OUT_SNP,">>$ARGV[1]"; ## masked vcf
open OUT_POS,">>$ARGV[2]"; ## masked pos (start from 0)
open F1,"<$ARGV[0]";  ### /public/home/pangjunling/5DAP_project/analysis/20160801/SNP_318merge.confirmed.all.vcf
while(<F1>)
{if($_=~/^#/)
  {print OUT_SNP "$_";}
 else
  {chomp;
   $total=0;
   %pos=();
   @hang=split/\t/;
   for($n=9;$n<=$#hang;$n++)
    {if($hang[$n] ne "./.")
       {$total++;
        $pos{$n}=1;
       }
    }
   @pos=keys %pos;
   if($total<=$mask_num)
    {
     for($m=0;$m<=$#pos;$m++)
     {$hang[$pos[$m]]="./.";}
     print OUT_SNP join("\t",@hang);
     print OUT_SNP "\n";
     print OUT_POS "$hang[0]\t$hang[1]\t";
     print OUT_POS join("\t",@pos);
     print OUT_POS "\n";     
    }
   else
    {$rand=int(rand($total-1));    ### generate a random number
     if($rand==$total-1){$rand2=$rand-1;$rand3=$rand-2;}
     elsif($rand==0){$rand2=$rand+1;$rand3=$rand+2;}
     else {$rand2=$rand-1; $rand3=$rand+1;}
     $hang[$pos[$rand]]="./.";
     $hang[$pos[$rand2]]="./.";
     $hang[$pos[$rand3]]="./.";
     print OUT_SNP join("\t",@hang);
     print OUT_SNP "\n";
     print OUT_POS "$hang[0]\t$hang[1]\t$pos[$rand]\t$pos[$rand2]\t$pos[$rand3]\n";
    }
  }
}
close F1;
close OUT_POS;
close OUT_SNP;
