read_qiime_map <- function(fileName) {
    map <- read.table(fileName, sep="\t", as.is=TRUE, header=TRUE)
    id <- "SampleID"
    if ( ! id %in% colnames(map) ) {
        stop("No SampleID found in map.") 
    }
    map[[id]] <- as.character(map[[id]])
    map
}

write_qiime_map <- function(map, fileName) {
    write.table(map, fileName, sep="\t", quote=FALSE, row.names=FALSE)
}
