read_qiime_map <- function(fileName) {
    map <- read.table(fileName, sep="\t", as.is=TRUE, header=TRUE)
    map$SampleID <- as.character(map$SampleID)
    map
}

write_qiime_map <- function(map, fileName) {
    write.table(map, fileName, sep="\t", quote=FALSE)
    TRUE
}
