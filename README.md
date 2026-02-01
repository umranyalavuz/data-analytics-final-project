# data-analytics-final-project
# Havacılık Değişkenlerinin Ekonomik Entegrasyon Üzerindeki Etkileri

Bu depo, **Veri Analitiği** dersi kapsamında hazırlanmış olan veri analizi çalışmasını içermektedir.

Bu çalışmanın temel amacı, **2000–2024** döneminde seçili Avrupa ülkelerinde **havacılıkla ilişkili değişkenlerin ekonomik entegrasyon üzerindeki etkilerini**, makine öğrenmesi tabanlı bir yaklaşımla analiz etmektir.

---

## 📊 Veri Seti

Çalışmada kullanılan veri seti, seçili Avrupa ülkelerine ait panel verilerden oluşmakta olup aşağıdaki değişkenleri içermektedir:

- **Havayolu Kargo Taşımacılığı (Freight)** – Bağımlı değişken  
- **Yolcu Sayısı (Passengers)**  
- **Kişi Başına GSYH**  
- **Enflasyon Oranı**  
- **Ticaret Hacmi**

---

## ⚙️ Yöntem

Analiz süreci aşağıdaki adımlardan oluşmaktadır:

- Veri ön işleme  
  - Eksik değerlerin giderilmesi  
  - IQR yöntemi ile aykırı değer analizi  
  - Değişkenlerin 0–1 aralığında normalize edilmesi
- Keşifsel veri analizi
- Makine öğrenmesi ile modelleme

Verilerin doğrusal olmayan bir yapı sergilemesi nedeniyle, geleneksel doğrusal modeller yerine **Random Forest** algoritması tercih edilmiştir.

---

## 📌 Temel Bulgular

- Yolcu trafiği, havayolu kargo taşımacılığı üzerinde **en etkili değişken** olarak belirlenmiştir.
- Elde edilen sonuçlar, Avrupa’daki kargo faaliyetlerinin büyük ölçüde **yolcu uçaklarının gövde altı kapasitesi (belly cargo)** üzerinden yürütüldüğünü göstermektedir.
- Model, havacılık ve ekonomik değişkenler arasındaki karmaşık ve doğrusal olmayan ilişkileri başarılı bir şekilde ortaya koymuştur.

---

## 🛠️ Kullanılan Araçlar

- Python  
- Pandas  
- NumPy  
- Scikit-learn  
- Matplotlib / Seaborn  

---

## 📄 Makale

Bu çalışmaya ait makale metni, depoda **PDF formatında** yer almaktadır.

---

## 👥 Çalışma Arkadaşlarım

- İlhami Yefa Yener  
- Tuğçe Nur Yaygun  

---


Bu çalışma, üniversite dersi kapsamında **eğitim amaçlı** olarak hazırlanmıştır.  
Veri seti ve analiz sürecine ilişkin detaylar, ilgilenenlerle paylaşılabilir.
