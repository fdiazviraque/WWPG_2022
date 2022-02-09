
# Exercise 1 

## Map the RNA-seq data to the reference


 Go to the exercise directory

$ cd /home/manager/Task_1_SexualDevelopment


Index the genome reference sequence

$ hisat2-build PbANKA_v3.fa PbANKA_v3_hisat2id


Map the reads trying to used a bash script with iterations

$ chmod +x run_mapping.sh 

$ ./run_mapping.sh 


# Exercise 2 

## Confirm the knockout in the mutant samples

Index the fasta file so Artemis can view each chromosome separately

$ samtools faidx PbANKA_v3.fa

$ art -Dbam="Pb_MUT1_sorted.bam,Pb_MUT2_sorted.bam,Pb_MUT3_sorted.bam,Pb_WT1_sorted.bam,Pb_WT2_sorted.bam,Pb_WT3_sorted.bam" PbANKA_v3.fa &
Sleuth
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


# Exercise 4

## Perform a Gene Ontology enrichment analysis (we have provided an R script to help with this)
