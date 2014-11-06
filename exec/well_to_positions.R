#!/usr/bin/env Rscript
library(argparse)
library(qiimeMap)
library(reshape2)

parser <- ArgumentParser()
parser$add_argument("-i", help="96 well plate file", type="character", required=TRUE)
parser$add_argument("-p", help="plate number", type="integer", choices=c(1,2), required=TRUE)
parser$add_argument("-o", help="output file(arranged as qiime mapping file)", required=TRUE)

args <- parser$parse_args()

well_plate_file <- args$i
plate_number <- args$p
output <- args$o

well_plate <- read_96_well_plate(well_plate_file)
well_plate_map <- transform_96wellPlate_to_map(well_plate, plate_number)
write_qiime_map(well_plate_map, output)

