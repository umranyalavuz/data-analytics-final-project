library(readxl)
dataset <- read_xlsx("C:/data/dataset1.xlsx")
View(dataset)
head(dataset)
install.packages("cluster")
install.packages("factoextra")
library(tidyverse)  # Veri i??leme ve g??rselle??tirme
library(caret)      # Veri b??lme ve model de??erlendirme
library(cluster)    # Silhouette skoru 
library(factoextra)
set.seed(123)
sum(is.na(dataset)) 
dataset[dataset == ".."] <- NA

dataset$Freight <- as.numeric(as.character(dataset$Freight))
dataset$`Passengers Carried` <- as.numeric(as.character(dataset$`Passengers Carried`))
dataset$`GDP per capita` <- as.numeric(as.character(dataset$`GDP per capita`))
dataset$`Inflation, consumer prices` <- as.numeric(as.character(dataset$`Inflation, consumer prices`))
dataset$Trade <- as.numeric(as.character(dataset$Trade))
# ortalama ile doldurma
dataset$Freight[is.na(dataset$Freight)] <- mean(dataset$Freight, na.rm = TRUE)

dataset$`Passengers Carried`[is.na(dataset$`Passengers Carried`)] <- mean(dataset$`Passengers Carried`, na.rm = TRUE)

dataset$`GDP per capita`[is.na(dataset$`GDP per capita`)] <- mean(dataset$`GDP per capita`, na.rm = TRUE)

dataset$`Inflation, consumer prices`[is.na(dataset$`Inflation, consumer prices`)] <- mean(dataset$`Inflation, consumer prices`, na.rm = TRUE)
#normal da????l??p da????lmad??????n?? kontrol etme
hist(dataset$Freight, main="Histogram of Freight", col="pink", xlab="Values")
qqnorm(dataset$Freight, main="Q-Q Plot of Freight")
qqline(dataset$Freight, col = "purple")

hist(dataset$`Passengers Carried`, main="Histogram of Passengers Carried", col="lightblue", xlab="Values")
qqnorm(dataset$`Passengers Carried`, main="Q-Q Plot of Passengers Carried")
qqline(dataset$`Passengers Carried`, col = "purple")

hist(dataset$`GDP per capita`, main="Histogram of GDP per capita", col="lightgreen", xlab="Values")
qqnorm(dataset$`GDP per capita`, main="Q-Q Plot of GDP per capita")
qqline(dataset$`GDP per capita`, col = "purple")


hist(dataset$`Inflation, consumer prices`, main="Histogram of Inflation", col="orchid1", xlab="Values")
qqnorm(dataset$`Inflation, consumer prices`, main="Q-Q Plot of Inflation")
qqline(dataset$`Inflation, consumer prices`, col = "purple")

hist(dataset$Trade, main="Histogram of Trade", col="lightyellow", xlab="Values")
qqnorm(dataset$Trade, main="Q-Q Plot of Trade")
qqline(dataset$Trade, col = "purple")

#Her bir de??i??ken i??in ayr?? ayr?? boxplot 
boxplot(dataset$Freight, main="Boxplot of Freight", col="pink", horizontal=FALSE)

boxplot(dataset$`Passengers Carried`, main="Boxplot of Passengers", col="lightblue", horizontal=FALSE)

boxplot(dataset$`GDP per capita`, main="Boxplot of GDP", col="lightgreen", horizontal=FALSE)

boxplot(dataset$`Inflation, consumer prices`, main="Boxplot of Inflation", col="orchid1", horizontal=FALSE)

boxplot(dataset$Trade, main="Boxplot of Trade", col="lightyellow", horizontal=FALSE)

# IQR hesaplama
Q1 <- quantile(dataset$Freight, 0.25, na.rm = TRUE)
Q3 <- quantile(dataset$Freight, 0.75, na.rm = TRUE)
IQR_degeri <- IQR(dataset$Freight, na.rm = TRUE)


alt_sinir <- Q1 - 1.5 * IQR_degeri
ust_sinir <- Q3 + 1.5 * IQR_degeri

# ayk??r?? de??erleri belirleme

aykiri_degerler_iqr <- dataset$Freight[dataset$Freight < alt_sinir | dataset$Freight > ust_sinir]
print("Freight ????in IQR ile Tespit Edilen Ayk??r?? De??erler:")
print(aykiri_degerler_iqr)

# ayk??r?? olmayan de??erlerin ortalamas??n?? hesaplama

ortalama_iqr <- mean(dataset$Freight[dataset$Freight >= alt_sinir & dataset$Freight <= ust_sinir], na.rm = TRUE)

# ayk??r?? de??erleri ortalama ile doldurma

dataset$Freight[dataset$Freight < alt_sinir | dataset$Freight > ust_sinir] <- ortalama_iqr

print("Freight ????in Ayk??r?? De??erler Ortalama ile Doldurulduktan Sonra:")
print(dataset$Freight)

#freight i??in ayk??r?? de??erimiz yok.

Q1 <- quantile(dataset$`Passengers Carried`, 0.25, na.rm = TRUE)
Q3 <- quantile(dataset$`Passengers Carried`, 0.75, na.rm = TRUE)
IQR_degeri <- IQR(dataset$`Passengers Carried`, na.rm = TRUE)

alt_sinir <- Q1 - 1.5 * IQR_degeri
ust_sinir <- Q3 + 1.5 * IQR_degeri

aykiri_degerler_iqr <- dataset$`Passengers Carried`[dataset$`Passengers Carried` < alt_sinir | dataset$`Passengers Carried` > ust_sinir]
print("Passengers Carried ????in Tespit Edilen Ayk??r?? De??erler:")
print(aykiri_degerler_iqr)

ortalama_iqr <- mean(dataset$`Passengers Carried`[dataset$`Passengers Carried` >= alt_sinir & dataset$`Passengers Carried` <= ust_sinir], na.rm = TRUE)

dataset$`Passengers Carried`[dataset$`Passengers Carried` < alt_sinir | dataset$`Passengers Carried` > ust_sinir] <- ortalama_iqr

print("Passengers Carried ????in G??ncel Veri Seti:")
print(dataset$`Passengers Carried`)

Q1 <- quantile(dataset$`GDP per capita`, 0.25, na.rm = TRUE)
Q3 <- quantile(dataset$`GDP per capita`, 0.75, na.rm = TRUE)
IQR_degeri <- IQR(dataset$`GDP per capita`, na.rm = TRUE)

alt_sinir <- Q1 - 1.5 * IQR_degeri
ust_sinir <- Q3 + 1.5 * IQR_degeri

aykiri_degerler_iqr <- dataset$`GDP per capita`[dataset$`GDP per capita` < alt_sinir | dataset$`GDP per capita` > ust_sinir]
print("GDP per capita ????in Tespit Edilen Ayk??r?? De??erler:")
print(aykiri_degerler_iqr)

ortalama_iqr <- mean(dataset$`GDP per capita`[dataset$`GDP per capita` >= alt_sinir & dataset$`GDP per capita` <= ust_sinir], na.rm = TRUE)

dataset$`GDP per capita`[dataset$`GDP per capita` < alt_sinir | dataset$`GDP per capita` > ust_sinir] <- ortalama_iqr

print("GDP per capita G??ncellendi:")
print(dataset$`GDP per capita`)

Q1 <- quantile(dataset$`Inflation, consumer prices`, 0.25, na.rm = TRUE)
Q3 <- quantile(dataset$`Inflation, consumer prices`, 0.75, na.rm = TRUE)
IQR_degeri <- IQR(dataset$`Inflation, consumer prices`, na.rm = TRUE)

alt_sinir <- Q1 - 1.5 * IQR_degeri
ust_sinir <- Q3 + 1.5 * IQR_degeri

aykiri_degerler_iqr <- dataset$`Inflation, consumer prices`[dataset$`Inflation, consumer prices` < alt_sinir | dataset$`Inflation, consumer prices` > ust_sinir]
print("Inflation ????in Tespit Edilen Ayk??r?? De??erler:")
print(aykiri_degerler_iqr)

ortalama_iqr <- mean(dataset$`Inflation, consumer prices`[dataset$`Inflation, consumer prices` >= alt_sinir & dataset$`Inflation, consumer prices` <= ust_sinir], na.rm = TRUE)

dataset$`Inflation, consumer prices`[dataset$`Inflation, consumer prices` < alt_sinir | dataset$`Inflation, consumer prices` > ust_sinir] <- ortalama_iqr

print("Inflation Sonu??lar??:")
print(dataset$`Inflation, consumer prices`)

Q1 <- quantile(dataset$Trade, 0.25, na.rm = TRUE)
Q3 <- quantile(dataset$Trade, 0.75, na.rm = TRUE)
IQR_degeri <- IQR(dataset$Trade, na.rm = TRUE)

alt_sinir <- Q1 - 1.5 * IQR_degeri
ust_sinir <- Q3 + 1.5 * IQR_degeri

aykiri_degerler_iqr <- dataset$Trade[dataset$Trade < alt_sinir | dataset$Trade > ust_sinir]
print("Trade ????in Tespit Edilen Ayk??r?? De??erler:")
print(aykiri_degerler_iqr)

ortalama_iqr <- mean(dataset$Trade[dataset$Trade >= alt_sinir & dataset$Trade <= ust_sinir], na.rm = TRUE)

dataset$Trade[dataset$Trade < alt_sinir | dataset$Trade > ust_sinir] <- ortalama_iqr

print("Trade S??tunu Son Durum:")
print(dataset$Trade)

#normalizasyon(min-max)

min_max_normalizasyon <- function(x) {
  x_min <- min(x, na.rm = TRUE)
  x_max <- max(x, na.rm = TRUE)
  return((x - x_min) / (x_max - x_min))
}


dataset$Freight_norm <- min_max_normalizasyon(dataset$Freight)
dataset$Passengers_norm <- min_max_normalizasyon(dataset$`Passengers Carried`)
dataset$GDP_norm <- min_max_normalizasyon(dataset$`GDP per capita`)
dataset$Inflation_norm <- min_max_normalizasyon(dataset$`Inflation, consumer prices`)
dataset$Trade_norm <- min_max_normalizasyon(dataset$Trade)

print("--- Normalizasyon Sonras?? Ozet Bilgiler ---")
print("Min degerlerin 0, Max degerlerin 1 olmas?? gerekiyor:")
summary(dataset[, c("Freight_norm", "Passengers_norm", "GDP_norm", "Inflation_norm", "Trade_norm")])

#korelasyon

kor_matrisi <- cor(dataset[, c("Freight_norm", "Passengers_norm", "GDP_norm", "Inflation_norm", "Trade_norm")])

print(kor_matrisi)
#kor matrisi g??rselle??tirme
install.packages("ggcorplot")
library(ggcorrplot)
ggcorrplot(kor_matrisi, method = "circle", lab = TRUE)

library(car)

#VIF modeli
vif_model <- lm(Freight_norm ~ Passengers_norm + GDP_norm + Inflation_norm + Trade_norm, data = dataset)


vif_sonuclari <- vif(vif_model)


print("Degiskenlerin VIF Degerleri:")
print(vif_sonuclari)

yuksek_vif <- vif_sonuclari[vif_sonuclari > 5]
if(length(yuksek_vif) > 0) {
  print("Dikkat! ??oklu Do??rusal Ba??lant?? Problemi Olabilir:")
  print(yuksek_vif)
} else {
  print("Harika! De??i??kenler aras??nda ciddi bir ??oklu do??rusal ba??lant?? sorunu g??r??nm??yor.")
}


summary(vif_model)
print("VIF De??erleri:")
print(vif_model)


install.packages("randomForest")
install.packages("caret") 
install.packages("dplyr")
install.packages("MASS")
install.packages("MLmetrics")

library(randomForest)
library(caret) # Veri b??lme ve de??erlendirme i??in
library(dplyr) # Veri manip??lasyonu i??in
library(MASS) #Modern Uygulamal?? ??statistik
library(MLmetrics) #Makine ????renimi modellerinin performans??n?? de??erlendirmek i??in ??e??itli metrikler sa??lar.

set.seed(123) # sonu??lar??n her seferinde ayn?? ????kmas?? i??in
trainIndex <- createDataPartition(dataset$Freight_norm, p = 0.8, list = FALSE)
train_data <- dataset[trainIndex, ]
test_data  <- dataset[-trainIndex, ]

set.seed(123)
rf_proje <- randomForest(Freight_norm ~ Passengers_norm + GDP_norm + Inflation_norm + Trade_norm, 
                         data = train_data, 
                         ntree = 500,       
                         importance = TRUE) 
print(rf_proje)

# Test seti ??zerinde tahmin yapma 
tahminler <- predict(rf_proje, test_data)

# 1. Ortalama Kare Hata (MSE) hesaplama

mse <- mean((test_data$Freight_norm - tahminler)^2)
cat("Ortalama Kare Hata (MSE):", mse, "\n")

# 2. Ortalama Mutlak Hata (MAE) hesaplama

# Tahminlerin ger??ek de??erlerden ne kadar sapt??????n?? ??l??er.
mae <- mean(abs(test_data$Freight_norm - tahminler))
cat("Ortalama Mutlak Hata (MAE):", mae, "\n")

# 3. R Kare (R2) skoru hesaplama

r2 <- 1 - (sum((test_data$Freight_norm - tahminler)^2) / 
             sum((test_data$Freight_norm - mean(test_data$Freight_norm))^2))
cat("R Kare (R2):", r2, "\n")

# 4. Hata Da????l??m Grafi??i (Hocan??n notundaki g??rselle??tirme)
# Noktalar k??rm??z?? ??izgiye ne kadar yak??nsa model o kadar ba??ar??l??d??r.

plot(test_data$Freight_norm, tahminler, 
     main = "Tahmin vs Ger??ek", 
     xlab = "Gercek Degerler (Freight_norm)", 
     ylab = "Tahmin Degerleri", 
     col = "blue", pch = 19)

abline(0, 1, col = "red", lwd = 2)

#de??i??ken analizi

print(importance(rf_proje))

varImpPlot(rf_proje, main = "De??i??kenlerin ??nem D??zeyi")

# De??i??ken ??nemini g??rselle??tir
varImpPlot(rf_proje, 
           main = "De??i??kenlerin Onem Siralamasi",
           col = "red", 
           pch = 16)

cat("Modelin Ba??ar?? Skoru (R2):", r2, "\n")

#  Hatalar?? (Residuals) hesapla
hatalar <- test_data$Freight_norm - tahminler

#  Hata Da????l??m Grafi??i (Histogram)
hist(hatalar, breaks = 20, main = "Hata Da????l??m?? (Residuals)", 
     xlab = "Hata Miktar??", col = "skyblue", border = "white")
abline(v = 0, col = "red", lwd = 2, lty = 2)

