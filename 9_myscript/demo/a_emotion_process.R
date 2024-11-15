# 0 Info ----

# Project: annotated emotion data (VA) process
# Author: LiuZiyu
# Created date: 2024/11
# Last edited date: 2024/11/06

# This script is for: 
#   1) import and clean annotated data, 
#   2) build static network, temporal network and estimate centrality of networks.

# 1 program set up ---- 
library(tsna)
library(ndtv)
library(networkDynamic)
library(tidyverse)
library(rio)
library(scatterplot3d)
library(ergm)

root_dir <- "D:/# Library/0 Academic/2_Programs/1_Engagement/data/00_RawData/annotated emotion data/00-原始-2023年秋-康庄视频表情标注"
excel_files <- list.files(path = root_dir, 
                          pattern = "\\.xlsx$",
                          recursive = T,
                          full.names = T)
dfs <- tibble()

for (file in excel_files) {
  
  # 读取Excel文件，从第3行开始
  data <- import(file, skip = 2)
  
  # 提取文件名并拆分为date, class, group
  file_name <- basename(file)
  name_parts <- strsplit(gsub(".xlsx$", "", file_name), "-")[[1]]
  date <- name_parts[1]
  class <- name_parts[2]
  group <- name_parts[3]
  
  # 添加日期、班级、组别列
  data$date <- date
  data$class <- class
  data$group <- group
  
  # 重命名列，避免列不完整时的错误
  colnames(data)[1] <- "timestamp"
  
  if (ncol(data) >= 5) {
    colnames(data)[2] <- "valence_1"
    colnames(data)[3] <- "arousal_1"
  }
  if (ncol(data) >= 7) {
    colnames(data)[4] <- "valence_2"
    colnames(data)[5] <- "arousal_2"
  }
  if (ncol(data) >= 9) {
    colnames(data)[6] <- "valence_3"
    colnames(data)[7] <- "arousal_3"
  }
  if (ncol(data) >= 11) {
    colnames(data)[8] <- "valence_4"
    colnames(data)[9] <- "arousal_4"
  }
  
  # 合并数据
  dfs <- rbind(all_data, data)
}

# 输出合并后的数据为Excel文件
export(dfs, output_file)
cat("数据已成功合并并保存为：", output_file, "\n")