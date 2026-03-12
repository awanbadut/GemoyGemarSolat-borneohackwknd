# 🐾 LinguPet: Gamified Indigenous Language Preservation Platform

Welcome to the official repository of **LinguPet**, an innovative platform designed to preserve endangered indigenous and local languages across ASEAN through crowdsourcing and gamification.

By nurturing virtual pets, native speakers contribute audio pronunciations, while language learners use these community-validated recordings and our AI audio processing engine to practice and perfect their speaking skills.

---

## 🔗 Hackathon Quick Links

- **Project Proposal / Report**
- [UI/UX Prototype](https://www.figma.com/proto/9NbVWXm3bbE3eAaMcn7mNM/UI-UX-LINGUPET?node-id=99-1762&t=YtN8oShGdpKLPjhL-1&scaling=scale-down&content-scaling=responsive&page-id=1%3A15493&starting-point-node-id=121%3A2878)
- [Figma Design](https://www.figma.com/design/9NbVWXm3bbE3eAaMcn7mNM/UI-UX-LINGUPET?node-id=1-15493&t=HUBWAlRzhGBjbO9v-1)
- **Demo Video**
- **Live API Deployment**

---

## 🎯 The Problem & Our Solution

Many local dialects and indigenous languages lack sufficient digital documentation and audio datasets, making them invisible to massive AI models.

**LinguPet** solves this by turning language preservation into a collaborative game:

1. **Gap Analysis (The Hungry Pet):** The system automatically detects missing audio translations compared to a baseline language and prompts native speakers to contribute.

2. **Community Validation:** Audio contributions are peer-reviewed. Approved audios help the virtual pet evolve.
3. **AI-Assisted Learning:** Learners practice speaking by mimicking the validated audio. Our localized AI engine compares their pronunciation wave-forms with the native speaker's audio, providing instant similarity scores.

---

## 🛠️ Technology Stack

This project utilizes a modern, decoupled microservices architecture.

- **Frontend (Mobile App):** Flutter, Dart
- **Core Backend API:** Node.js, Express.js, TypeScript, Prisma ORM
- **AI Audio Engine:** Python, FastAPI, Librosa, FastDTW
- **Database & File Storage:** PostgreSQL, Cloudinary
- **Deployment & Infrastructure:** Render

---

## 📂 Repository Structure

This repository follows a monorepo structure to house all microservices and frontend code in one place for easy review and deployment.

```text
lingupet-hackathon/
├── frontend/             # Flutter mobile application codebase
├── backend/              # Express.js core API, Auth, and Prisma configurations
├── ai-service/           # FastAPI Python engine for audio signal processing
├── .gitignore
└── README.md             # Project documentation and links
```

---

## 🚀 Getting Started (Local Development)

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

---

## ☁️ Deployment Guide

The backend API and database are deployed on Render. Since this is a monorepo, the deployment is configured as follows:

```bash
Build Command: npm install && npm run build

Start Command: npm start

Root Directory: backend (This ensures Render only builds the Express.js API portion of the repository).
```

---

## 👥 Meet the Team

- **Akbar Hidayatullah** - UI/UX Designer & Fried Food Supplier
- **Nadifah Ramadhani** - UI/UX Designer
- **Rafi Maisshadiq** – Backend & AI Engineer
- **Toni Wildan Akhta** - Technical Writer
- **Zikry Kurniawan** – Frontend & Mobile Developer
