from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import shutil
import os
import librosa
import numpy as np
from fastdtw import fastdtw
from scipy.spatial.distance import euclidean

app = FastAPI(title="LinguPet AI Audio Engine")

# Setup CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

UPLOAD_DIR = "temp_audio"
os.makedirs(UPLOAD_DIR, exist_ok=True)

# --- (AUDIO PROCESSING) ---

def extract_mfcc(file_path):
    # Load audio file with librosa, resample ke 16kHz (standards for human voice recognition)
    y, sr = librosa.load(file_path, sr=16000)

    # Extract 13 MFCC features
    mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13)

    # Transpose the matrix so that the format is easy to read by FastDTW (rows = time, columns = features)
    return mfcc.T

def calculate_similarity_score(mfcc_base, mfcc_learn):
    # Calculate DTW distance using the Euclidean formula (straight line)
    distance, path = fastdtw(mfcc_base, mfcc_learn, dist=euclidean)

    # Normalize the distance. Because the longer the duration of speech, the greater the raw distance.
    normalized_distance = distance / len(path)

    # Convert the distance into a score (0-100).
    score = 100.0 - (normalized_distance * 0.5)

    # Make sure the score is not more than 100 and not negative.
    final_score = max(0.0, min(100.0, score))

    return round(final_score, 2), round(normalized_distance, 2)

# --- ENDPOINTS ---

@app.get("/")
def root():
    return {"message": "AI Audio Engine is Running!"}

@app.post("/compare-audio/")
async def compare_audio(
    baseline_audio: UploadFile = File(...),
    learner_audio: UploadFile = File(...)
):
    try:
        baseline_path = f"{UPLOAD_DIR}/base_{baseline_audio.filename}"
        learner_path = f"{UPLOAD_DIR}/learn_{learner_audio.filename}"

        with open(baseline_path, "wb") as buffer:
            shutil.copyfileobj(baseline_audio.file, buffer)

        with open(learner_path, "wb") as buffer:
            shutil.copyfileobj(learner_audio.file, buffer)

        # AI Execution (Librosa + FastDTW)
        mfcc_baseline = extract_mfcc(baseline_path)
        mfcc_learner = extract_mfcc(learner_path)

        final_score, raw_distance = calculate_similarity_score(mfcc_baseline, mfcc_learner)

        # Clean up temporary files
        os.remove(baseline_path)
        os.remove(learner_path)

        return {
            "success": True,
            "similarity_score": final_score,
            "debug_raw_distance": raw_distance,
            "message": "Comparison successful"
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))