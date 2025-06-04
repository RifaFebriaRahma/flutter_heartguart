import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
import joblib
import sys

try:
    # Load dataset dengan delimiter titik koma
    df = pd.read_csv("heart_disease_uci.csv", sep=";")

    # Cek kolom
    print("Kolom dataset:", df.columns.tolist())
    if "num" not in df.columns:
        print("[ERROR] Kolom 'num' tidak ditemukan di dataset.")
        sys.exit(1)

    # Hapus kolom yang tidak relevan
    df = df.drop(columns=["id", "dataset"])

    # Encoding kolom kategorikal
    df['sex'] = df['sex'].map({'Male': 0, 'Female': 1})

    # Mengubah kolom 'cp', 'restecg', dan 'thal' menjadi numerik
    df['cp'] = df['cp'].map({0: 0, 1: 1, 2: 2, 3: 3})  # Kolom cp sudah numerik, hanya memastikan
    df['restecg'] = df['restecg'].map({'normal': 0, 'st-t abnormality': 1, 'left ventricular hypertrophy': 2})
    df['thal'] = df['thal'].map({3: 0, 6: 1, 7: 2})  # Menyusun kode untuk 'thal'

    # Mengonversi kolom 'slope' (misalnya 'flat' menjadi angka)
    df['slope'] = df['slope'].map({'upsloping': 0, 'flat': 1, 'downsloping': 2})

    # Pastikan kolom 'ca' dan kolom numerik lainnya tidak memiliki data string
    df['ca'] = df['ca'].map({0: 0, 1: 1, 2: 2, 3: 3, 4: 4})  # Kolom 'ca' adalah numerik

    # Fitur dan target
    X = df.drop("num", axis=1)
    y = (df["num"] > 0).astype(int)

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Latih model
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    # Evaluasi
    y_pred = model.predict(X_test)
    print("\n=== Classification Report ===")
    print(classification_report(y_test, y_pred))

    # Simpan model
    joblib.dump(model, "heartguard_model.pkl")
    print("\n✅ Model berhasil disimpan sebagai 'heartguard_model.pkl'")

except FileNotFoundError:
    print("[ERROR] File 'heart_disease_uci.csv' tidak ditemukan.")
except Exception as e:
    print(f"[ERROR] Terjadi kesalahan: {e}")
