suffix=".dd.bam$"
bam_dir="/BAM-DD/"

wd=getwd()
bam_dir=paste0(wd,bam_dir)
fpath = list.files(bam_dir,pattern=suffix,full.names=T,include.dirs=F)
fname = list.files(bam_dir,pattern=suffix,full.names=F,include.dirs=F)
fname = gsub(x=fname,pattern=suffix,replacement="")

m = cbind(fpath=fpath,outdir=paste0(fname,"-maxATAC_prepare"),fname=fname)
print(m)
write.table(m,"sample_sheet_prepare.txt",sep="\t",row.names=F,col.names=F,quote=F)
