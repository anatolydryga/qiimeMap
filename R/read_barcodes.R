#' read file with barcode seq.
#'
#' @param fileName barcode, linker and position file
read_barcodes <- function(fileName) {
    barcodes <- read.table(fileName, sep="\t", as.is=TRUE, header=TRUE)
    if ( ! is_unique_ids(barcodes$BarcodeSequence)) {
        stop("Duplicate Barcodes found.")
    }
    barcodes
}
