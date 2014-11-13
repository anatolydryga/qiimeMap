#' read 96 well plate.
#'
#' Reads 96 well plate: rows are A, B,..., H and columns are 1, 2,..., 12.
#'
#' @param fileName 96 plate 
#' @return dataframe 8 by 12 with row names A,B,...,H and columns are 1,2,...,12.
#' each element is SampleID (repersented as char)
read_96_well_plate <- function(fileName) {
    well_plate <- read.table(fileName, 
        sep="\t", as.is=TRUE, check.names=FALSE,
        header=TRUE, colClasses="character", row.names=1)

    well_plate[well_plate==""] <- NA
    well_plate[well_plate=="NA"] <- NA

    if ( ! is_unique_ids(well_plate)) {
        stop("SampleID cannot be repeated.")
    }
    if ( ! is_correct_col_names(colnames(well_plate))) {
        stop("Incorrect Column names.")
    }
    if ( ! is_correct_row_names(rownames(well_plate))) {
        stop("Incorrect Row names.")
    }
    well_plate
}


is_correct_col_names <- function(columnNames) {
    ( ! NA %in% columnNames) && all(columnNames == as.character(seq(1,12)))
}


is_correct_row_names <- function(rowNames) {
    (! NA %in% rowNames) && all(rowNames == c("A", "B", "C", "D", "E", "F", "G", "H"))
}
