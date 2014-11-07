context("Add metadata to mapping file")

pos2barcodes <- read_barcodes("PlateNumberWellPosition2Barcodes.txt")
well_plate_map <- transform_96wellPlate_to_map(read_96_well_plate("well_correct.txt"), 2)
mapping <- add_barcodes(well_plate_map, pos2barcodes)
metadata <- read_qiime_map("metadata.txt")

test_that("all columns in metadata were added(except SampleID)", {
    map_w_meta <- add_metadata(mapping, metadata)
    expect_equal(ncol(map_w_meta), ncol(mapping) + ncol(metadata) -  1)
})

test_that("some columns were added", {
    map_w_meta <- add_metadata(mapping, metadata, c("Read", "QT"))
    expect_equal(ncol(map_w_meta), ncol(mapping) + 2)
    expect_true( ! "MMM" %in% colnames(map_w_meta))
})

test_that("cannot add nonexistent column", {
    expect_error(add_metadata(mapping, metadata, c("NonExistingColumn")), "Column does not exist in the metadata file.")
})

test_that("fail if map and meta files does not have any shared SampleIDs", {
    metadata <- read_qiime_map("metadata_non_existent_ids.txt")
    expect_error(add_metadata(mapping, metadata), "Cannot find any SampleIDs that are shared.")
})

test_that("number of samples stays the same in mapping file", {
    map_w_meta <- add_metadata(mapping, metadata, c("Read"))
    expect_equal(nrow(map_w_meta), nrow(mapping))
})

test_that("NAs are added for the cases where metadata was missing", {
    map_w_meta <- add_metadata(mapping, metadata)
    nas <- subset(map_w_meta, SampleID %in% c("A1Lyme", "A2Lyme", "A3Lyme", "B1", "B2", "B3", "B4", "P1", "P2"))
    expect_true(all(is.na(nas$QT)))
    expect_true(all(is.na(nas$Read)))
    expect_true(all(is.na(nas$MMM)))
})
