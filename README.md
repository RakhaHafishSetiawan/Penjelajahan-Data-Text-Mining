![Screenshot (420)](https://user-images.githubusercontent.com/102712597/204098419-b783a61e-5490-4745-97a5-36bb80298739.png)

# Analisis Teks / Text Analysis
• Repositori ini berisi hasil dari penjelajahan data hasil text mining dari sebuah artikel ilmiah yang berjudul "Paradigma Analisis Wacana dalam Memahami Teks dan Konteks Untuk Meningkatkan Kemampuan". <br>
• This repository contains the results of text mining data exploration from a scientific article entitled "Paradigm of Discourse Analysis in Understanding Text and Context to Improve Ability"

# Aplikasi / Tools
• R Language <br>
• Microsoft Power BI

# Pengolahan Data / Data Processing

## Library yang Dibutuhkan / Required Libraries
 • Untuk dapat mengubah data yang tidak terstruktur, seperti file .pdf menjadi kumpulan data terstruktur, selain menggunakan sistem yang biasa, saya harus menggunakan library R seperti pdftools untuk mengubah file .pdf menjadi korpora teks dan tm untuk membersihkan dan mengubah kumpulan teks menjadi bingkai data yang dapat dikelola. <br>
• To be able to transform an unstructured data, such as the .pdf file into a structured data set, besides using the usual tidyverse, i had to use R libraries such as pdftools to convert .pdf file into a textcorpora and tm to clean and transform the text corpora into a manageable data frame.

```r
library(dplyr)
library(magrittr)
library(pdftools)
library(tm)
```

## Kode Transformasi Data / Data Transformation Code
• Dalam pengubahan file .pdf yang termasuk dalam jenis data tidak terstruktur menjadi data yang terstruktur, pdftools digunakan untuk membaca format file .pdf, setelah itu digunakan tm untuk membersihkan korpora teks dari residu-residu data yang tidak diinginkan seperti kata angka dan kata konjungsi.<br>
• In converting .pdf files belonging to the unstructured data type into structured data, pdftools was used to read files in .pdf format, after which tm is used to clean the text corpora from unwanted data residues such as numbers and conjunctions. <br>

```r
textCorpus = Corpus(VectorSource(pdf_text("C:/Users/Rakha Hafish S/Downloads/Proposal.pdf"))) %>%
    tm_map(tolower) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace) %>%
    tm_map(removeNumbers) %>%
    tm_map(removeWords, IDNStop) %>%
    tm_map(removeWords, ENGStop)
    
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

# Kreator / Creator
• Rakha Hafish Setiawan @ Universitas Brawijaya
