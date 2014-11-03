add_metadata <- function(qiime_mapping, metadata, columns_to_add="all") {
    id <- "SampleID"
    if ( ! have_shared_ids(qiime_mapping, metadata, id)) {
        stop("Cannot find any SampleIDs that are shared.") 
    }
    qiime_mapping_columns <- colnames(qiime_mapping)
    metadata_columns <- get_metadata_columns(metadata, columns_to_add)
    merged <- merge(qiime_mapping, metadata, by=id, all.x=TRUE)
    merged[c(qiime_mapping_columns, metadata_columns)]
    merged
}

have_shared_ids <- function(map, meta, id) {
    length(intersect(map[[id]], meta[[id]])) != 0
}

get_metadata_columns <- function(metadata, columns_to_add) {
    if (length(columns_to_add) == 1 && columns_to_add == "all") {
        return(colnames(metadata))
    }
    if ( ! all(columns_to_add %in% colnames(metadata))) {
        stop("Column does not exist in the metadata file.")
    }
    columns_to_add
}
