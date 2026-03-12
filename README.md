# 🐾 LinguPet: Gamified Indigenous Language Preservation Platform

Welcome to the official repository of **LinguPet**, an innovative platform designed to preserve endangered indigenous and local languages across ASEAN through crowdsourcing and gamification.

By nurturing virtual pets, native speakers contribute audio pronunciations, while language learners use these community-validated recordings and our AI audio processing engine to practice and perfect their speaking skills.

---

## 🔗 Hackathon Quick Links

- **Project Proposal / Report**
- [UI/UX Prototype](https://www.figma.com/proto/9NbVWXm3bbE3eAaMcn7mNM/UI-UX-LINGUPET?node-id=99-1762&t=YtN8oShGdpKLPjhL-1&scaling=scale-down&content-scaling=responsive&page-id=1%3A15493&starting-point-node-id=121%3A2878)
- [Figma Design](https://www.figma.com/design/9NbVWXm3bbE3eAaMcn7mNM/UI-UX-LINGUPET?node-id=1-15493&t=HUBWAlRzhGBjbO9v-1)
- **Demo Video**
- **Live API Deployment:**
  - [Backend API](https://api-lingupet.onrender.com)
  - [AI Service](https://ai-engine-service.onrender.com/docs)

---

## 🌍 1. General Description

### What Our Project Does

LinguPet is an innovative platform designed to preserve endangered indigenous and local languages across ASEAN through crowdsourcing and gamification. By nurturing virtual pets, native speakers contribute audio pronunciations, while language learners use these community-validated recordings and our AI audio processing engine to practice and perfect their speaking skills.

### SDG Addressed

**Goal 11: Sustainable Cities and Communities**
LinguPet directly addresses **Target 11.4** (_"Strengthen efforts to protect and safeguard the world's cultural and natural heritage"_). Language is a fundamental pillar of cultural identity. As communities urbanize and modernize, local dialects risk extinction. LinguPet ensures these languages are digitally documented, preserved, and passed down to future generations, fostering inclusive and culturally sustainable societies.

### Target Users

1. **Native Speakers (Contributors):** Locals, elders, or cultural enthusiasts looking for an engaging way to digitize and preserve their mother tongue.
2. **Language Learners:** Students, expatriates, tourists, or descendants of indigenous communities wanting to learn authentic local dialects with real-time AI pronunciation feedback.

---

## ⚙️ 2. Setup Instructions

### 🛠️ Technology Stack

This project utilizes a modern, decoupled microservices architecture.

- **Frontend (Mobile App):** Flutter, Dart
- **Core Backend API:** Node.js, Express.js, TypeScript, Prisma ORM
- **AI Audio Engine:** Python, FastAPI, Librosa, FastDTW
- **Database & File Storage:** PostgreSQL, Cloudinary
- **Deployment & Infrastructure:** Render

### How to Install & Run (Local Development)

### 1. Core Backend Setup

Navigate to the backend directory, install dependencies, and run the development server.

```Bash
cd backend
npm install
npx prisma generate
npx prisma db push
npm run dev
Note: Ensure you have your .env file configured with DATABASE_URL and JWT_SECRET.
```

### 2. AI Audio Engine Setup

Navigate to the AI service directory and start the FastAPI server.

```Bash
cd ai-service
python -m venv venv
source venv/bin/activate # (Or venv\Scripts\activate on Windows)
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

### 3. Frontend Setup

Navigate to the Flutter directory and run the app on your preferred emulator/device.

```Bash
cd frontend
flutter pub get
flutter run
```

## 🎮 3. How to Interact with Prototype

Step-by-Step Guide for Judges

1. **Access the Prototype:** Download and install the provided APK on an Android device, or run the Flutter frontend locally.

2. **Onboarding:** Create a new account or log in using the provided test credentials:

   ```text
   email: judge@hackathon.com | password: judge123.
   ```

3. **Act as a Contributor (Feed the Pet):**
   - Navigate to the **Home** tab.
   - You will see a "Quick Feed" button.
   - Type in the local word, click the microphone icon, record the suggested word, and submit it to feed and evolve the pet.

4. **Act as a Learner**
   - Navigate to the Learning tab.
   - Select one of your language courses.
   - Do the learning quizzes.
   - Press the microphone to record your own pronunciation.
   - Wait a few seconds for our Python AI Engine to analyze your voice and return a similarity score!

---

## 🧪 Test Cases

For technical judges reviewing our backend and AI engine via Postman or Swagger UI:

### Test Case 1: AI Audio Similarity (FastDTW Engine)

- **Endpoint:** `POST https://ai-engine-service.onrender.com/docs`

- **Action:** Upload two identical audio files (.wav).

- **Expected Result:** The engine successfully processes the MFCCs and returns a similarity_score close to 100.

- **Action 2:** Upload two completely different audio words.

- **Expected Result:** The engine returns a drastically lower similarity_score.

### Test Case 2: Secure Authentication

- **Endpoint:** `POST https://api-lingupet.onrender.com/api/auth/register`

- **Action:** Attempt to register a user with an email that already exists in the database.

- **Expected Result:** Returns a 400 Bad Request with the message "Username atau Email sudah terdaftar!", demonstrating proper database validation.

## 👥 Meet the Team

- **Akbar Hidayatullah** - UI/UX Designer & Fried Food Supplier
- **Nadifah Ramadhani** - UI/UX Designer
- **Rafi Maisshadiq** – Backend & AI Engineer
- **Toni Wildan Akhta** - Technical Writer
- **Zikry Kurniawan** – Frontend & Mobile Developer

_Built with passion for Borneo HackWknd 2026_
