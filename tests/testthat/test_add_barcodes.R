context("Adding barcodes to well plate, plate number")

pos2barcodes <- read_barcodes("PlateNumberWellPosition2Barcodes.txt")
well_plate_map <- transform_96wellPlate_to_map(read_96_well_plate("well_correct.txt"), 2)
mapping_file <- add_barcodes(well_plate_map, pos2barcodes)

test_that("read correct number of rows, columns", {
    expect_equal(ncol(mapping_file), 5)
    expect_equal(nrow(mapping_file), 64)
} )

test_that("column names as qiime expects", {
    expect_equal(colnames(mapping_file), c("SampleID", "BarcodeSequence", "LinkerPrimerSequence", "plateNumber","wellPosition"))
} )

test_that("correct barcodes are used", {
    grepSample <- function(mapping, SampleID) {
        unlist(mapping[which(mapping$SampleID==SampleID), ])
    }
    expect_equivalent(grepSample(mapping_file, "9"), c("9", "CAGAAATGTGTC", "CTGCTGCCTYCCGTA", 2, "A01"))
    expect_equivalent(grepSample(mapping_file, "73"), c("73", "AGAGTCTTGCCA", "CTGCTGCCTYCCGTA", 2, "B02"))
} )

test_that("each well position, plate number is matched to barcodes", {
    expect_equal(length(mapping_file$BarcodeSequence), 64)
    expect_equal(sum(is.na(mapping_file$BarcodeSequence)), 0)
} )

test_that("all SampleIDs with plateNumber, wellPositon have corresponing BarcodeSequence and LinkerPrimerSequence", {
    pos2barcodes <- read_barcodes("PlateNumberWellPosition2Barcodes_wrongPlateNumber.txt")
    well_plate_map <- transform_96wellPlate_to_map(read_96_well_plate("well_correct.txt"), 2)
    expect_error(add_barcodes(well_plate_map, pos2barcodes), "Cannot find required barcodes.")
})

test_that("one missing and two repeated samples positions are caught", {
    no_first_row <- well_plate_map[2:nrow(well_plate_map),]
    repeats <- rbind(no_first_row[1,], no_first_row)
    repeats[1,1] <- "newNonExistentId"
    expect_error(add_barcodes(repeats, pos2barcodes), "PlateNumber, wellPosition columns are not unique.")
})
