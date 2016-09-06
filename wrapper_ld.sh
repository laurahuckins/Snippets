
zcat /sc/orga/projects/CommonMind/lhuckins/CM5-chr22_imputed.dos.id.gz | head -1 > header

for ((i=1; i<=113; i++))

do

gene=$(head -$i SNPLIST.$chr | tail -1 | awk '{print $1}')

head -$i SNPLIST.$chr | tail -1 | awk '{$1=""; $2=""; print $0}' | tr ' ' '\n' | sort -u | sed "1d" > snps.tmp

zcat /sc/orga/projects/CommonMind/lhuckins/CM5-chr22_imputed.dos.id.gz | fgrep -wf snps.tmp - >> $gene.dosage

nsnps=$(wc -l snps.tmp | awk '{print $1}')

./run_ld.py $nsnps $gene

rm snps.tmp

done
