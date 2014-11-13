#' add barcodes to file with well position, plate number.
#'
#' @param well_plate_map dataframe with columns "plateNumber", "wellPosition"
#' @param barcodes dataframe with 
#'    "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition" columns
#' @note only 5 columns are returned (no metadata)
#' @note plateNumber and wellPosition should be unique
add_barcodes <- function(well_plate_map, barcodes) {
    if ( ! is_plateNumber_wellPosition_unique(well_plate_map)) {
        stop("PlateNumber, wellPosition columns are not unique.")
    }
    merged <- merge(well_plate_map, barcodes, by=c("plateNumber", "wellPosition"))
    if (nrow(well_plate_map) != nrow(merged)) {
        stop("Cannot find required barcodes.")
    }
    merged[c("SampleID", "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition")]
}

is_plateNumber_wellPosition_unique <- function(map) {
    plate_well <- map[ , c("plateNumber", "wellPosition")]
    nrow(map) == nrow(unique(plate_well))
}
