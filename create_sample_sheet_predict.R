preprocessed=T # Set to T if used maxATAC's 'prepare' pre-processing. Set to F if using SNS bigwigs.

if (preprocessed){
  suffix="_IS_slop20_RP20M_minmax01.bw"
  bigwig_dir="."

  fpath = list.files(bigwig_dir,pattern=suffix,full.names=T,include.dirs=F,recursive = T)
  fname = list.files(bigwig_dir,pattern=suffix,full.names=F,include.dirs=F,recursive = T)
  fname = gsub(x=fname,pattern=suffix,replacement="")
  fname = gsub(x=fname,pattern="^.*-maxATAC_prepare/",replacement="",fixed = F)
} else{
  
  suffix=".bin1.rpkm.bw"
  bigwig_dir="./BIGWIG"
  
  fpath = list.files(bigwig_dir,pattern=suffix,full.names=T,include.dirs=F)
  fname = list.files(bigwig_dir,pattern=suffix,full.names=F,include.dirs=F)
  fname = gsub(x=fname,pattern=suffix,replacement="")
}

m = cbind(fpath,outdir=paste0(fname,"-maxATAC-predict"))
print(m)
write.table(m,"sample_sheet_predict.txt",sep="\t",row.names=F,col.names=F,quote=F)
