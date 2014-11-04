#!/usr/bin/env Rscript
library(argparse)

parser <- ArgumentParser()
parser$add_argument("-i", help="sample IDs with positions file", type="character", required=TRUE)
parser$add_argument("-b", help="barcodes", type="character", required=TRUE)
parser$add_argument("-o", help="qiime mapping file", required=TRUE)

args <- parser$parse_args()

positions_file <- args$i
barcode_file <- args$b
output <- args$o

posToBarcodes <- read_barcodes(barcode_file)
positions <- read_qiime_map(positions_file)
map <- add_barcodes(positions, posToBarcodes)
write_qiime_map(map, output)

