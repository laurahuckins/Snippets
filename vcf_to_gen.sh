
for chr in {1..22}

do

    cat Amanda_vcfids | tr ':' ' ' | awk -v c=$chr '$1==c {print $1":"$2}' > Amanda_vcfids.$chr # Get ids in format for qctool

    qctool -g chr21.vcf.gz -og Amanda.21.gen -incl-rsids Amanda_vcfids.21

    cat CMC_eqtl_SVA_Caucasian_combined+BP_chrS_cis_conditional.out.bp | awk -v c=$chr '$1==c {print $1":"$3, $2}' > Amanda.mapping.$chr # get mapping file to upate chr:pos to rsids

    while read line; do

        echo $line

        old=$(echo $line | awk '{print $1}')
        new=$(echo $line | awk '{print $2}')

        sed -i "s/$old/$new/1" Amanda.21.gen

    done<Amanda.mapping.21

done

