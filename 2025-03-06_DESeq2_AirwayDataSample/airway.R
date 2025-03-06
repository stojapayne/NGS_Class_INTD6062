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

poisd2 <- PoissonDistance(t(counts(dds)))
airwayPoisDistMatrix <- as.matrix( poisd2$dd)
#rownames(samplePoisDistMatrix) <- ddsHTSeq$condition
colnames(airwayPoisDistMatrix) <- NULL
#colors = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255) ;  for some reason this didn't work for me
pheatmap(airwayPoisDistMatrix,
         clustering_distance_rows = poisd2$dd,
         clustering_distance_cols = poisd2$dd,
         #col = colors
)


## Perform DESeq2 analysis  

ddsAirway <- DESeq(dds)


## Obtain the results and store in an object called 'results'

Airwayresults <- results(ddsAirway)
Airwayresults
write.csv(as.data.frame(Airwayresults), file="Airwayresults.csv")

## plot average expression versus log2 fold change - points are colored red if Padj < 0.1

plotMA(Airwayresults, ylim = c(-4, 4), alpha = 0.1, colSig = "red" )


## add gene annotation to results table
Airwayanno <- AnnotationDbi::select(org.Hs.eg.db, rownames(Airwayresults), 
                              columns=c("ENSEMBL", "ENTREZID", "SYMBOL", "GENENAME"), 
                              keytype="ENSEMBL")
Airwayresults = cbind(ENSEMBL = rownames(Airwayresults), Airwayresults)
Airwayanno_results <- left_join(as.data.frame(Airwayresults), Airwayanno )
head(Airwayanno_results) 



## Plot your favorite volcano plot and send it to Dr. Bunnik

EnhancedVolcano(Airwayanno_results, 
                lab = c(Airwayanno_results$SYMBOL), 
                x = "log2FoldChange", 
                y="pvalue", 
                border = "full", 
                borderWidth = 1.5, 
                borderColour = "black", 
                gridlines.major = FALSE, 
                gridlines.minor = FALSE)


    


