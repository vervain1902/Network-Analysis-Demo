# 0. Info ----

# Project: process conflict dialog
# Author: LiuZiyu
# Created date: 2024/11
# Last edited date: 2024/11/15

# This script is for
# - conduct an example of graphicalVAR

# Data source
# - 2023 collected observation data

# 1 Program set up ----
rm(list = ls()) # clear work space

root_dir <- "D:/# Library/0 Academic/5_Learnings/202411-NetworkAnalysis"
config_dir <- file.path(root_dir, "9_myscript", "config")
source(file.path(config_dir, "config.R"))

# 2 import all discourse data ----
file_name <- file.path(raw_dir, "g7_discourse.dta")
df_dialog <- tibble(import(file_name))

df_dialog$apt_t[is.na(df_dialog$apt_t)] <- "Missing"
df_dialog$reg_t[is.na(df_dialog$reg_t)] <- "Missing"

df_a_dialog <- df_dialog %>%
  mutate(
    time_unit = ceiling(id / 10),
    speaker = as.factor(speaker),
    apt = as.factor(apt_t),
    reg = as.factor(reg_t),
    cfl = as.factor(cfl_t),
    mng = as.factor(mng_t)
  )

df_a_dialog <- df_a_dialog %>%
  dplyr::select(
    date, group, time_unit, id, speaker, apt, reg, cfl, mng, relate, episode
  )

df_a_dialog_new <- df_a_dialog %>%
  group_by(time_unit) %>%
  summarise(
    a_1 = mean(apt == 1.1 | apt == 1.2), # 计算 M1 的出现频率
    a_2 = mean(apt == 2), # 计算 M2 的出现频率
    a_3 = mean(apt == 3), # 计算 M3 的出现频率
    a_9 = mean(apt == "Missing"),
    r_1 = mean(reg == 1.1 | reg == 2.1), # 计算 rM1 的出现频率
    r_2 = mean(reg == 1.2 | reg == 2.2), # 计算 rM2 的出现频率
    r_3 = mean(reg == 1.3 | reg == 2.3), # 计算 rM3 的出现频率
    r_4 = mean(reg == 1.4 | reg == 2.4),
    r_9 = mean(reg == "Missing")
  ) %>%
  dplyr::select(-(starts_with("apt_") | starts_with("reg_")))

skim(df_a_dialog)

# Estimate model:
Res <- graphicalVAR(df_a_dialog, gamma = 0, nLambda = 5, centerWithin = T)
summary(Res)

layout(t(1:2))
plot(Res, "PCC", layout = "circle")
plot(Res, "PDC", layout = "circle")
