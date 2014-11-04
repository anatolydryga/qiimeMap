is_unique_ids <- function(data) {
    ids <- unlist(data)
    ids <- ids[! is.na(ids)]
    
    len <- length(ids)
    len_uniq <- length(unique(ids))

    (len == len_uniq)
}


