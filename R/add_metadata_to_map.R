#' add metadata columns to mapping file.
#'
#' @param qiime_mapping map dataframe
#' @param metadata dataframe
#' @columns_to_add columns from metadata to add to qiime mapping file
#'    add all columns by default
add_metadata <- function(qiime_mapping, metadata, columns_to_add=c()) {
    id <- "SampleID"
    if ( ! have_shared_ids(qiime_mapping, metadata, id)) {
        stop("Cannot find any SampleIDs that are shared.") 
    }
    merged <- merge(qiime_mapping, metadata, by=id, all.x=TRUE)

    qiime_mapping_columns <- colnames(qiime_mapping)
    metadata_columns <- get_metadata_columns(metadata, columns_to_add)
    metadata_columns <- remove_id_column(metadata_columns, id)
    merged[c(qiime_mapping_columns, metadata_columns)]
}

have_shared_ids <- function(map, meta, id) {
    length(intersect(map[[id]], meta[[id]])) != 0
}

get_metadata_columns <- function(metadata, columns_to_add) {
    if (length(columns_to_add) == 0) {
        return(colnames(metadata))
    }
    if ( ! all(columns_to_add %in% colnames(metadata))) {
        stop("Column does not exist in the metadata file.")
    }
    columns_to_add
}

remove_id_column <- function(data, id) {
    data[data != id]
}
