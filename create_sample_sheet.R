suffix=".bin1.rpkm.bw"
bigwig_dir="./BIGWIG"

fpath = list.files(bigwig_dir,pattern=suffix,full.names=T,include.dirs=F)
fname = list.files(bigwig_dir,pattern=suffix,full.names=F,include.dirs=F)
fname = gsub(x=fname,pattern=suffix,replacement="")

m = cbind(fpath,outdir=paste0(fname,"-maxATAC"))
print(m)
write.table(m,"sample_sheet.maxATAC.txt",sep="\t",row.names=F,col.names=F,quote=F)
