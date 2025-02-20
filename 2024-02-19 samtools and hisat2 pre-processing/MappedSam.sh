
#need to be in path where trimmed fastq files are
#-x and -s needs full path 
parallel --plus "hisat2 -k 1 --no-mixed --no-discordant --no-softclip -x /mnt/c/Users/s_aio/NGSAnalysisClass/trimmed_fastq/indexes/chrX_tran -S /mnt/c/Users/s_aio/NGSAnalysisClass/trimmed_fastq/SamSorted/{=s/_1_val_1.fq.gz//=}.hisat.sorted.sam -1 {} -2 {=s/_1_val_1/_2_val_2/=}" ::: *_1.fq.gz
