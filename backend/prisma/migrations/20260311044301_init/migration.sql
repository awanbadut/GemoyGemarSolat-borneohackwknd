-- CreateEnum
CREATE TYPE "Role" AS ENUM ('LEARNER', 'CONTRIBUTOR', 'REVIEWER');

-- CreateEnum
CREATE TYPE "WordStatus" AS ENUM ('EMPTY', 'NEEDS_AUDIO', 'COMPLETED');

-- CreateEnum
CREATE TYPE "ContributionStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'LEARNER',

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Language" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_baseline" BOOLEAN NOT NULL DEFAULT false,
    "pet_exp" INTEGER NOT NULL DEFAULT 0,
    "pet_level" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterWord" (
    "id" SERIAL NOT NULL,
    "word_text" TEXT NOT NULL,
    "category" TEXT NOT NULL,

    CONSTRAINT "MasterWord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LanguageWord" (
    "id" SERIAL NOT NULL,
    "language_id" INTEGER NOT NULL,
    "master_word_id" INTEGER NOT NULL,
    "translated_text" TEXT,
    "audio_url" TEXT,
    "status" "WordStatus" NOT NULL DEFAULT 'EMPTY',

    CONSTRAINT "LanguageWord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contribution" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "language_word_id" INTEGER NOT NULL,
    "submitted_audio_url" TEXT NOT NULL,
    "status" "ContributionStatus" NOT NULL DEFAULT 'PENDING',
    "upvotes" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Contribution_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Language_name_key" ON "Language"("name");

-- AddForeignKey
ALTER TABLE "LanguageWord" ADD CONSTRAINT "LanguageWord_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LanguageWord" ADD CONSTRAINT "LanguageWord_master_word_id_fkey" FOREIGN KEY ("master_word_id") REFERENCES "MasterWord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contribution" ADD CONSTRAINT "Contribution_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contribution" ADD CONSTRAINT "Contribution_language_word_id_fkey" FOREIGN KEY ("language_word_id") REFERENCES "LanguageWord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
