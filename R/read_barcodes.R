#' read file with barcode seq.
#'
#' at present we have 2 plates with 96 well positions each,
#' so each file should have 2*96 unique barcodes and 4 columns:
#' plateNumber, wellPosition, BarcodeSequence, LinkerPrimerSequence.
#'
#' @param fileName barcode, linker and position file
read_barcodes <- function(fileName) {
    barcodes <- read.table(fileName, sep="\t", as.is=TRUE, header=TRUE)
    if (nrow(barcodes) != n_plates * wells_per_plate) {
        stop("Does not have correct number of barcodes.")
    }
    if ( ! is_unique_ids(barcodes$BarcodeSequence)) {
        stop("Duplicate Barcodes found.")
    }
    barcodes
}

n_plates <- 2
wells_per_plate <- 96
