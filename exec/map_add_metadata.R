#!/usr/bin/env Rscript
library(argparse)

parser <- ArgumentParser()
parser$add_argument("-i", help="qiime mapping file", type="character", required=TRUE)
parser$add_argument("-d", help="metadata file(should have SampleID column)", 
    type="character", required=TRUE)
parser$add_argument("-c", help="columns to add from metadata", nargs="+", 
    type="character")
parser$add_argument("-o", help="qiime mapping file with added metadata", required=TRUE)

args <- parser$parse_args()

map_file <- args$i
meta_file <- args$d
output <- args$o
columns_to_extract <- args$c

mapping <- read_qiime_map(map_file)
metadata <- read_qiime_map(meta_file)
map <- add_metadata(mapping, metadata, columns_to_extract)
write_qiime_map(map, output)

