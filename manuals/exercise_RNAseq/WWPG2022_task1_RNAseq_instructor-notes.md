
# Exercise 1 

## Map the RNA-seq data to the reference


 Go to the exercise directory

$ cd /home/manager/Task_1_SexualDevelopment


Index the genome reference sequence

$ hisat2-build PbANKA_v3.fa PbANKA_v3_hisat2id

Map the reads to the reference genome 

$ hisat2 --max-intronlen 1000 -x PbANKA_v3_hisat2id -1 Pb_MUT1_1.fastq.gz -2 Pb_MUT1_2.fastq.gz -S MT1.sam

Convert SAM to BAM file

$ samtools view -b -o MT1.bam MT1.sam

Sort BAM file

$ samtools sort -o MT1_sorted.bam MT1.bam

Index sorted BAM file

$ samtools index MT1_sorted.bam

Repeat these steps for the other 5 samples

Remove the sam and bam (unsorted) files

$ rm MT[1-3].sam WT[1-3].sam MT[1-3].bam WT[1-3].bam 

Is quite boring to repeat all the commands all the time so why dont you try to generate a bash script with iterations to do it? It's a good oportinuity to include scripting exercising also.

Map the reads using a bash script (we provide one)

$ chmod +x run_mapping.sh 

$ ./run_mapping.sh 


# Exercise 2 

## Confirm the knockout in the mutant samples

Index the fasta file so Artemis can view each chromosome separately

$ samtools faidx PbANKA_v3.fa

$ art -Dbam="Pb_MUT1_sorted.bam,Pb_MUT2_sorted.bam,Pb_MUT3_sorted.bam,Pb_WT1_sorted.bam,Pb_WT2_sorted.bam,Pb_WT3_sorted.bam" PbANKA_v3.fa &

Select ”Use index” so Artemis will show individual chromosomes.

Right click on the BAM view, and clone the window and de-select one of the condition in each view so you can have MT and WT separately.

Go to chromosome 14 and upload annotation file provided for this chromosome (PbANKA_14_v3.embl).

Press ctrl-g and use Goto Feature With Gene Name to navigate to the gene "AP2-G". Remember that this gene was knoked out in MT parasites, so we do not expect to find reads on this gene in the MT samples. Visualize that there are practically no reads mapping to this gene in MT sample. A good practice is to calcular RPKM and compare this parameter between samples.






# Exercise 3


## Call differentially expressed genes

Kalliso and Sleuth are going to used in order to identify differentially expressed genes.

Kallisto needs an index of the transcript sequences.

$ kallisto index -i PbANKA_v3_kallisto PbANKA_v3_transcriptome.fa


Quantify the expression levels of your transcripts for all the samples. Again it's a good oportinuity to practice interations

$ chmod +x run_kallisto.sh 

$ ./run_kallisto.sh

Statistical analysis are going to be done with Sleuth that takes as an input the transcript abundance calculated by Kallisto. But first we need a text file containing the a matrix that explicit the conditions we want to compare and wich sample correspond to which conditions (hiseq_info_task1.txt). After that Sleuth_task1.R could be run in R for differentially expression analysis.



$ R

Copy and paste commmand in Sleuth_task1.R


$ cut -f1,2,4,5 kallisto.results | awk -F '\t' '$3 < 0.01 && $4 > 0' | wc -l

170 genes are downregulated in knock out parasites 

$ cut -f1,2,4,5 kallisto.results | awk -F '\t' '$3 < 0.01 && $4 < 0' | wc -l

179 genes are upregulated in knock out parasites


# Exercise 4

## Perform a Gene Ontology enrichment analysis (we have provided an R script to help with this)

First we need a files with gene ids that are up and down regulated in knock out parasites.

cut -f1,2,4,5 kallisto.results | awk -F '\t' '$3 < 0.01 && $4 < 0' | awk '{print $1}' > up.list

cut -f1,2,4,5 kallisto.results | awk -F '\t' '$3 < 0.01 && $4 > 0' | awk '{print $1}' > dw.list

 Gene Ontology enrichment analysis could be performed using topGO package from R (we have provided an R script to help with this).
 
 We provide the GO result as table (Result_BP_up.txt & Result_BP_dw.txt)
