context("Reading 96 well plate")

test_that("can read correct 96 well plate", {
    well_plate_96 <- read_96_well_plate("well_correct.txt")
    expect_equal(ncol(well_plate_96), 12)
    expect_equal(nrow(well_plate_96), 8)
    expect_equal(sum(is.na(well_plate_96)), 32)
    expect_equal(sum( ! is.na(well_plate_96)), 64)
} )

test_that("can process well names", {
    well_plate_96 <- read_96_well_plate("well_correct.txt")
    expect_equal(colnames(well_plate_96), as.character(seq(1,12)))
    expect_equal(rownames(well_plate_96), c("A", "B", "C", "D", "E", "F", "G", "H"))
} )

test_that("can values are OK", {
    well_plate_96 <- read_96_well_plate("well_correct.txt")
    expect_equal(well_plate_96["A", "11"], "P1")
    expect_equal(well_plate_96["B", "11"], "158")
    expect_true(is.na(well_plate_96["G", "11"]))
    expect_equal(well_plate_96["C", "3"], "179")
    expect_equal(well_plate_96["D", "5"], "389")
    expect_true(is.na(well_plate_96["F", "9"]))
} )

test_that("id repeated several times lead to failure", {
    expect_error(read_96_well_plate("well_repetition_328.txt"), "SampleID cannot be repeated.")
} )

test_that("column names are 1,2...12", {
    expect_error(read_96_well_plate("well_incorrect_x_labels.txt"), "Incorrect Column names.")
} )

test_that("row names are A, B, ... H", {
    expect_error(read_96_well_plate("well_incorrect_y_labels.txt"), "Incorrect Row names.")
} )
