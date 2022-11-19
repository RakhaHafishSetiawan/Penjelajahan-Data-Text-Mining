#Aktivasi Library
library(tidyverse)
library(pdftools)
library(tm)
library(RColorBrewer)

#Kreasi Korpora Teks dan Pembersihan Data
textCorpus <- Corpus(VectorSource(pdf_text("C:/Users/Rakha Hafish S/Downloads/Pertemuan10.pdf"))) %>%
  tm_map(tolower) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, IDNStop) %>%
  tm_map(removeWords, ENGStop)

#Konversi Korpora Menjadi Data Frame dan Matrix Data
DataMatrix <- textCorpus %>%
  DocumentTermMatrix() %>%
  as.matrix() %>%
  t() %>%
  rowSums() %>%
  sort(decreasing = TRUE)

DataFrame <- data.frame(names(DataMatrix), DataMatrix) %>%
  select(everything()) %>%
  mutate(rank = row_number()) %>%      
  rename(term = names.DataMatrix.) %>%
  rename(frequency = DataMatrix)
