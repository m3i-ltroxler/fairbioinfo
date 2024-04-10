library(DESeq2)

cts <- read.table("counts.txt", sep="\t",row.names=1)
colnames(cts) = c(paste0("condition1_",1:3),paste0("condition2_",1:3))
head(cts)

coldata = cbind.data.frame(condition= c(rep("condition1", 3),rep("condition2", 3)))
rownames(coldata) = c(paste0("condition1_",1:3),paste0("condition2_",1:3))
head(coldata)

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata ,
                              design= ~ condition)
dds <- DESeq(dds)
resultsNames(dds) # lists the coefficients

res <- results(dds, name="condition_condition2_vs_condition1")
res

plotMA(res, ylim=c(-2,2))

png(file = "deseq2_demo.png", width = 800, height = 700)
plotMA(res, ylim=c(-2,2))
dev.off()

write.table(res,"deseq2_demo.tsv", quote=F, sep="\t", col.names=T)


