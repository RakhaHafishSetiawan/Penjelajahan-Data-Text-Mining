![Screenshot (420)](https://user-images.githubusercontent.com/102712597/204098419-b783a61e-5490-4745-97a5-36bb80298739.png)

# Analisis Teks / Text Analysis
• Repositori ini berisi hasil dari analisis data eksplorasi dari data penambangan teks dari sebuah artikel ilmiah yang berjudul "Paradigma Analisis Wacana dalam Memahami Teks dan Konteks Untuk Meningkatkan Kemampuan". <br>
• This repository contains the results of exploratory data analysis of a text mining data from a scientific article entitled "Paradigm of Discourse Analysis in Understanding Text and Context to Improve Ability"

# Aplikasi / Tools
• R Language <br>
• Microsoft Power BI

# Library yang Dibutuhkan / Required Libraries
 • Untuk dapat mengubah data yang tidak terstruktur, seperti file .pdf menjadi kumpulan data terstruktur, selain menggunakan sistem yang biasa, saya harus menggunakan library R seperti pdftools untuk mengubah file .pdf menjadi korpora teks dan tm untuk membersihkan dan mengubah kumpulan teks menjadi bingkai data yang dapat dikelola. <br>
• To be able to transform an unstructured data, such as the .pdf file into a structured data set, besides using the usual tidyverse, i had to use R libraries such as pdftools to convert .pdf file into a textcorpora and tm to clean and transform the text corpora into a manageable data frame.

```r
library(dplyr)
library(tibble)
library(magrittr)
library(pdftools)
library(tm)
```

# Kode Transformasi Data / Data Transformation Code
## Memperoleh Data Frekuensi Istilah / Obtaining Term Frequency Data
• Dalam pengubahan file .pdf yang termasuk dalam jenis data tidak terstruktur menjadi data yang terstruktur, pdftools digunakan untuk membaca format file .pdf, setelah itu digunakan tm untuk membersihkan korpora teks dari residu-residu data yang tidak diinginkan seperti kata angka dan kata konjungsi. Resultan dari transformasi ini adalah bingkai data yang mengandung data istilah beserta frekuensi kemunculannya<br>
• In converting .pdf files belonging to the unstructured data type into structured data, pdftools was used to read files in .pdf format, after which tm is used to clean the text corpora from unwanted data residues such as numbers and stopwords. The resultant of this transformation is a data frame containing the term data and the frequency with which it occurs<br>

```r
# Pengubahan file .pdf menjadi korpora teks / Converting .pdf files to text corpora
textCorpus = Corpus(VectorSource(pdf_text("C:/Users/Rakha Hafish S/Downloads/Pertemuan10.pdf"))) %>%
    tm_map(tolower) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace) %>%
    tm_map(removeNumbers) %>%
    tm_map(removeWords, IDNStop) %>%
    tm_map(removeWords, ENGStop)
    
# Pengubahan korpora teks menjadi Matriks Data dan Bingkai Data / Converting corpora text to Data Matrix and Data Frame
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
```
## Resultan Skrip / Script Resultant
```r
tibble(DataFrame)
# A tibble: 847 × 3
   term       frequency  rank
   <chr>          <dbl> <int>
 1 wacana           126     1
 2 analisis          67     2
 3 bahasa            41     3
 4 teks              34     4
 5 konteks           32     5
 6 pandangan         27     6
 7 paradigma         26     7
 8 sosial            26     8
 9 fairclough        19     9
10 kekuasaan         19    10
# … with 837 more rows
```
## Memperoleh Data Stopword / Obtaining Stopword Data
• Setelah memperoleh data frekuensi istilah, selanjutnya adalah proses memperoleh residu data yang tersaring oleh bongkahan kode sebelumnya. Residu ini adalah sebuah data dari stopword beserta frekuensinya. Cara kerja dari bongkahan kode berikut adalah menggabungkan data korpora teks yang belum tersaring stopwordnya dengan data set yang mengandung berbagai stopword dari bahasa Indonesia dan Bahasa Inggris. <br>
• After obtaining term frequency data, the next step is the process of obtaining the remaining data that is filtered by the previous chunk code. This residue is a data from the stopword and its frequency. The way the following code snippets work is to combine text corpora data that has not been filtered for stopwords with a data set that contains various stopwords from Indonesian and English.
```r
textCorpus = Corpus(VectorSource(pdf_text("C:/Users/Rakha Hafish S/Downloads/Pertemuan10.pdf"))) %>%
    tm_map(tolower) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace) %>%
    tm_map(removeNumbers) 

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

MyStopwords = data.frame(c(IDNStop, ENGStop)) %>% 
  rename(term=c.IDNStop..ENGStop.)

StopwordData2 = DataFrame %>% 
  inner_join(MyStopwords, by = NULL)
```
# Kreator / Creator
• Rakha Hafish Setiawan @ Universitas Brawijaya
