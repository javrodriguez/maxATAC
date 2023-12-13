argv = commandArgs(trailingOnly = T)
bigwig_dir = argv[1L]
suffix=".bin1.rpkm.bw"

fpath = list.files(bigwig_dir,pattern=suffix,full.names=T,include.dirs=F)
fname = list.files(bigwig_dir,pattern=suffix,full.names=F,include.dirs=F)
fname = gsub(x=fname,pattern=suffix,replacement="")

m = cbind(fpath,outdir=paste0(fname,"-maxATAC"))
print(m)
write.table(m,"sample_sheet.maxATAC.txt",sep="\t",row.names=F,col.names=F,quote=F)
