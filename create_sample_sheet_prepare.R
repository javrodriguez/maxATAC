suffix=".dd.bam$"
bam_dir="./BAM-DD"

fpath = list.files(bam_dir,pattern=suffix,full.names=T,include.dirs=F)
fname = list.files(bam_dir,pattern=suffix,full.names=F,include.dirs=F)
fname = gsub(x=fname,pattern=suffix,replacement="")

m = cbind(fpath,outdir=paste0(fname,"-maxATAC_prepare"))
print(m)
write.table(m,"sample_sheet_prepare.txt",sep="\t",row.names=F,col.names=F,quote=F)
