read_96_well_plate <- function(fileName) {
    well_plate <- read.table(fileName, sep="\t", as.is=TRUE, check.names=FALSE, header=TRUE)
    well_plate[well_plate==""] <- NA
    well_plate[well_plate=="NA"] <- NA

    columnNames <- colnames(well_plate)
    columnNames <- columnNames[2:length(columnNames)]
    rowNames <- well_plate[, 1]

    if ( ! is_unique_ids(well_plate)) {
        stop("SampleID cannot be repeated.")
    }
    if ( ! is_correct_col_names(columnNames)) {
        stop("Incorrect Column names.")
    }
    if ( ! is_correct_row_names(rowNames)) {
        stop("Incorrect Row names.")
    }

    well_plate <- well_plate[, columnNames]
    rownames(well_plate) <- rowNames
    well_plate
}

is_correct_col_names <- function(columnNames) {
    ( ! NA %in% columnNames) && all(columnNames == as.character(seq(1,12)))
}

is_correct_row_names <- function(rowNames) {
    (! NA %in% rowNames) && all(rowNames == c("A", "B", "C", "D", "E", "F", "G", "H"))
}

is_unique_ids <- function(well_plate) {
    ids <- unlist(well_plate)
    ids <- ids[! is.na(ids)]
    
    len <- length(ids)
    len_uniq <- length(unique(ids))

    (len == len_uniq)
}
