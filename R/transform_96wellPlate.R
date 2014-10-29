library(reshape2)

transform_96wellPlate_to_map <- function(wellPlateTable, plateNumber) {
    valid_plateNumbers <- c(1, 2)
    if (! plateNumber %in% valid_plateNumbers) {
        stop("Only plate numbers 1,2 are allowed.")
    }
    let_number_id <- melt(as.matrix(wellPlateTable), 
        measure.vars=as.character(seq(1, 12)), value.name="SampleID")

    number <- sprintf("%02d", let_number_id$Var2)
    letter <- let_number_id$Var1
    ids <- as.character(let_number_id$SampleID)
    well_position <- paste(letter, number, sep="")

    map_w_na <- data.frame("SampleID"=ids, "plateNumber"=rep(plateNumber, nrow(let_number_id)), 
        "wellPosition"=well_position, stringsAsFactors=FALSE)
    mapping <- map_w_na[complete.cases(map_w_na), ]
    mapping[order(mapping$SampleID), ]
}
