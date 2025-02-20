#need to be in environment where sam files are
#output placed in already created folder 'BamSorted'
parallel "samtools sort {} -o /mnt/c/Users/s_aio/NGSAnalysisClass/BamSorted/{=s/.sam//=}.bam" ::: *.hisat.sorted.sam