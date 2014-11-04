context("Read barcode from file")

pos2barcode <- read_barcodes("PlateNumberWellPosition2Barcodes.txt")

test_that("read correct number of rows, columns", {
    expect_equal(ncol(pos2barcode), 4)
    expect_equal(nrow(pos2barcode), 2*96)
} )

test_that("exact values as in file", {
    grepSample <- function(table, barcode) {
        unlist(table[which(table$BarcodeSequence==barcode), ])
    }
    expect_equivalent(grepSample(pos2barcode, "TACTCGGGAACT"), c(1, "A10", "TACTCGGGAACT", "CTGCTGCCTYCCGTA"))
    expect_equivalent(grepSample(pos2barcode, "CGTAGGTAGAGG"), c(2, "H10", "CGTAGGTAGAGG", "CTGCTGCCTYCCGTA"))
} )

test_that("columns names are plateNumber, wellPosition, BarcodeSequence, LinkerPrimerSequence", {
    expect_equal(colnames(pos2barcode), c("plateNumber", "wellPosition", "BarcodeSequence", "LinkerPrimerSequence"))
} )

test_that("no duplicate barcodes even in different plates", {
    expect_error(read_barcodes("PlateNumberWellPosition2Barcodes_withDuplicates.txt"), "Duplicate Barcodes found.")
} )

test_that("no duplicate barcodes even in different plates", {
    expect_error(read_barcodes("PlateNumberWellPosition2Barcodes_incorectNumber.txt"), "Does not have correct number of barcodes.")
} )
