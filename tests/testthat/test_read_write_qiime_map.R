context("Writing and reading qiime mapping file")

pos2barcodes <- read_barcodes("PlateNumberWellPosition2Barcodes.txt")
well_plate_map <- transform_96wellPlate_to_map(read_96_well_plate("well_correct.txt"), 2)
mapping_file <- add_barcodes(well_plate_map, pos2barcodes)

test_that("can write a file", {
    expect_true(write_qiime_map(mapping_file, "mapping_file.txt"))
})

test_that("write/read are consistent", {
    write_qiime_map(mapping_file, "mapping_file.txt")
    map <- read_qiime_map("mapping_file.txt")
    expect_equivalent(mapping_file, map)
} )

test_that("all ids are characters", {
    map <- read_qiime_map("mapping_file.txt")
    expect_true(is.character(map$SampleID))
} )

test_that("all ids are characters even for the metadata file", {
    map <- read_qiime_map("metadata.txt")
    expect_true(is.character(map$SampleID))
} )
