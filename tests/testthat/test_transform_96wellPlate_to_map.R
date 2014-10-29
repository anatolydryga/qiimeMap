context("Transforming 96 well plate to qiime map format")

well_plate_96 <- read_96_well_plate("well_correct.txt")
qiime_wp1 <- transform_96wellPlate_to_map(well_plate_96, 1)

test_that("dimensions are correct", {
    expect_equal(ncol(qiime_wp1), 3)
    expect_equal(nrow(qiime_wp1), 64)
} )

test_that("column labels are SampleID, plateNumber, wellPosition", {
    expect_equal(colnames(qiime_wp1), c("SampleID","plateNumber","wellPosition"))
} )

test_that("plate number 1,2 is valid everyhting else is not", {
    expect_error(transform_96wellPlate_to_map(well_plate_96, 3), "Only plate numbers 1,2 are allowed.")
    expect_error(transform_96wellPlate_to_map(well_plate_96, 0), "Only plate numbers 1,2 are allowed.")
    expect_error(transform_96wellPlate_to_map(well_plate_96, -5), "Only plate numbers 1,2 are allowed.")
} )

test_that("all plates are 1", {
    expect_equal(qiime_wp1$plateNumber, rep(1, 64))
} )

test_that("SampleIDs are sorted", {
    expect_false(is.unsorted(qiime_wp1$SampleID))
} )

test_that("SampleIDs are just characters not factor", {
    expect_false(is.factor(qiime_wp1$SampleID))
} )

test_that("values are as expected", {
    grepSample <- function(table, SampleID) {
        unlist(table[which(table$SampleID==SampleID), ])
    }
    expect_equivalent(grepSample(qiime_wp1, "9"), c("9", 1, "A01"))
    expect_equivalent(grepSample(qiime_wp1, "P1"),   c("P1", "1", "A11"))
    expect_equivalent(grepSample(qiime_wp1, "P2"),   c("P2", 1, "C10"))
    expect_equivalent(grepSample(qiime_wp1, "B3"),   c("B3", 1, "E06"))
    expect_equivalent(grepSample(qiime_wp1, "1119"), c("1119", 1, "E02"))
} )
