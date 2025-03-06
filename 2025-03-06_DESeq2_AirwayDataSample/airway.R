if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("airway")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("AnnotationHub")
BiocManager::install("dplyr")

library(DESeq2)
library(gplots)
library(RColorBrewer)
library(genefilter)
library(EnhancedVolcano)
library(pheatmap)
library(PoiClaClu)
library(airway)
library(org.Hs.eg.db)
library(dplyr)

## See: https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html


## load data from "airway" dataset and create the DESeq object
data("airway")
se <- airway
colData(se)
dds <- DESeqDataSet(se, design = ~ cell + dex)


## plot heatmap of Poisson distances between samples
# don't worry about the rownames! You can leave that line out.




## Perform DESeq2 analysis  



## Obtain the results and store in an object called 'results'



## plot average expression versus log2 fold change - points are colored red if Padj < 0.1



## add gene annotation to results table
anno <- AnnotationDbi::select(org.Hs.eg.db, rownames(results), 
                              columns=c("ENSEMBL", "ENTREZID", "SYMBOL", "GENENAME"), 
                              keytype="ENSEMBL")
results = cbind(ENSEMBL = rownames(results), results)
anno_results <- left_join(as.data.frame(results), anno )
head(anno_results) 



## Plot your favorite volcano plot and send it to Dr. Bunnik




    


