#conda install conda-forge::parallel
#must be in /mnt/c/Users/s_aio/NGSAnalysisClass/Week04/Week04 (or where all your original fastq.gz files are)
#xapply flag runs each pair - must include, otherwise every combination of reads will be run between the two lists
parallel --xapply trim_galore -q 28 --illumina --max_n 1 --trim-n -o trimmed_fastq --clip_R1 10 --clip_R2 10 --paired ::: *_1.fastq.gz ::: *_2.fastq.gz