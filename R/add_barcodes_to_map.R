#' add barcodes to file with well position, plate number.
#'
#' @param well_plate_map dataframe with columns "plateNumber", "wellPosition"
#' @param barcodes dataframe with 
#'    "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition" columns
#' @note only 5 columns are returned (no metadata)
add_barcodes <- function(well_plate_map, barcodes) {
    merged <- merge(well_plate_map, barcodes, by=c("plateNumber", "wellPosition"))
    if (nrow(well_plate_map) != nrow(merged)) {
        stop("Cannot find required barcodes.")
    }
    merged[c("SampleID", "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition")]
}
