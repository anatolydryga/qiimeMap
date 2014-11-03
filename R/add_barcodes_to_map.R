add_barcodes <- function(well_plate_map, barcodes) {
    merged <- merge(well_plate_map, barcodes, by=c("plateNumber", "wellPosition"))
    merged[c("SampleID", "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition")]
}
