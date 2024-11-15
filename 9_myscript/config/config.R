# 0. Info ----

# Project: process conflict dialog
# Author: LiuZiyu
# Created date: 2024/11
# Last edited date: 2024/11/15

library(tsna)
library(ndtv)
library(networkDynamic)
library(tidyverse)
library(rio)
library(scatterplot3d)
library(ergm)
library(skimr)
library(paletteer)
library(graphicalVAR)

# define working directories ----
root_dir <- "D:/# Library/0 Academic/5_Learnings/202411-NetworkAnalysis"

raw_dir <- file.path(root_dir, "0_rawdata")
my_dir <- file.path(root_dir, "1_mydata")
des_dir <- file.path(root_dir, "2_description")

func_dir <- file.path(root_dir, "9_myscript/function")

# load functions ---- 
files <- list.files(func_dir, pattern = "\\.R$", full.names = TRUE)
lapply(files, source)

# define paletteers ----
scale_color <- scale_color_paletteer_d("ggprism::black_and_white")
scale_fill <- scale_fill_paletteer_d("ggprism::black_and_white")