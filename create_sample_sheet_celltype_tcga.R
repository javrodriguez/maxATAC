library(splitstackshape)

suffix="maxatac_predict_32bp.bed"
maxATAC_dir="/Users/javrodher/Work/RStudio-PRJs/TCGA_PanCan/data/maxATAC/CTCF/"
setwd(maxATAC_dir)

fpath = list.files(maxATAC_dir,pattern=suffix,full.names=T,include.dirs=F,recursive = T)
fname = list.files(maxATAC_dir,pattern=suffix,full.names=F,include.dirs=F,recursive = T)
fname = gsub(x=fname,pattern=paste0("/",suffix),replacement="")

m = as.data.frame(cbind(sample_name=fname,celltype=NA))
x=cSplit(indt = m,splitCols = "sample_name",sep = "_")
m$celltype=x$sample_name_01

write.csv(m,"sample_sheet_celltype.csv",row.names=F)
