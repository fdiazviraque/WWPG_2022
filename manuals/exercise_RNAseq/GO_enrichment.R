infiles=c("up.list","dw.list")

for (f in infiles){
  infile="dw.list"
  goDB="PbANKA_v3.go" 
  ontology_type="BP"

  ### loads the needed library
  library(topGO)

  ### get and prepare the GO data base
  mappingFile <- goDB
  title <- "GO analysis"
  minNumberNodesPerGO <- 5
  pvalue_max <- 0.05

  geneID2GO <- readMappings(file = mappingFile)
  geneNames <- names(geneID2GO)

  ### load our genes of interest
  myInterestingGenes = read.table(infile, header=FALSE, stringsAsFactors=F)
  ### get all the gene id that also have a GO term
  geneList <- factor(as.integer(geneNames %in% myInterestingGenes[,1]))
  names(geneList) <- geneNames


  GOdata <- new("topGOdata",
  description = title,
  ontology = ontology_type,
allGenes = geneList, # a named numeric vector
annot = annFUN.gene2GO, # a built-in function!
gene2GO = geneID2GO, # the read-in gene-to-GO mappings
nodeSize = minNumberNodesPerGO) # pruning all nodes with less than 5 genes per GO term

resultFis <- runTest(GOdata, algorithm = "weight01", statistic = "fisher")

allRes <- GenTable(GOdata, classic = resultFis, orderBy = "classic", topNodes =length(resultFis@score) )
outfile = "Result_BP_dw.txt"
write.table(file=outfile, x=allRes[as.double(sub("< ", "", allRes[,6]))<=pvalue_max,], sep="\t", row.names=F, quote=F) 
write.csv(file="Result_BP_dw.csv", x=allRes[as.double(sub("< ", "", allRes[,6]))<=pvalue_max,], row.names=F)

head(allRes)
