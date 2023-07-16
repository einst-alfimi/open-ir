-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT,
    "name" TEXT,
    "content" TEXT
);

-- CreateTable
CREATE TABLE "Song" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "subartist" TEXT NOT NULL,
    "md5" TEXT NOT NULL,
    "sha256" TEXT NOT NULL,
    "mode" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "lntype" INTEGER NOT NULL,
    "judge" INTEGER NOT NULL,
    "notes" INTEGER NOT NULL,
    "total" INTEGER NOT NULL,
    "minbpm" INTEGER NOT NULL,
    "maxbpm" INTEGER NOT NULL,
    "hasUndefinedLN" BOOLEAN NOT NULL,
    "hasLN" BOOLEAN NOT NULL,
    "hasCN" BOOLEAN NOT NULL,
    "hasHCN" BOOLEAN NOT NULL,
    "hasMine" BOOLEAN NOT NULL,
    "hasRandom" BOOLEAN NOT NULL,
    "hasStop" BOOLEAN NOT NULL,
    "published" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "OrajaVersion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "versionHash" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Score" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clear" INTEGER NOT NULL,
    "lntype" INTEGER NOT NULL,
    "epg" INTEGER NOT NULL,
    "lpg" INTEGER NOT NULL,
    "egr" INTEGER NOT NULL,
    "lgr" INTEGER NOT NULL,
    "egd" INTEGER NOT NULL,
    "lgd" INTEGER NOT NULL,
    "ebd" INTEGER NOT NULL,
    "lbd" INTEGER NOT NULL,
    "epr" INTEGER NOT NULL,
    "lpr" INTEGER NOT NULL,
    "ems" INTEGER NOT NULL,
    "lms" INTEGER NOT NULL,
    "maxcombo" INTEGER NOT NULL,
    "notes" INTEGER NOT NULL,
    "passnotes" INTEGER NOT NULL,
    "minbp" INTEGER NOT NULL,
    "option" INTEGER NOT NULL,
    "assist" INTEGER NOT NULL,
    "gauge" INTEGER NOT NULL,
    "deviceType" INTEGER NOT NULL,
    "judgeAlgorithm" TEXT NOT NULL,
    "rule" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "scoreType" TEXT NOT NULL,
    "ghost" TEXT,
    "valid" INTEGER NOT NULL,
    "content" TEXT,
    "authorId" INTEGER NOT NULL,
    "orajaVersionId" INTEGER NOT NULL,
    "songId" INTEGER NOT NULL,
    CONSTRAINT "Score_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Score_orajaVersionId_fkey" FOREIGN KEY ("orajaVersionId") REFERENCES "OrajaVersion" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Score_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DifficultyTable" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "content" TEXT,
    "url" TEXT
);

-- CreateTable
CREATE TABLE "DifficultyTableOnSong" (
    "difficultyTableId" INTEGER NOT NULL,
    "songId" INTEGER NOT NULL,

    PRIMARY KEY ("difficultyTableId", "songId"),
    CONSTRAINT "DifficultyTableOnSong_difficultyTableId_fkey" FOREIGN KEY ("difficultyTableId") REFERENCES "DifficultyTable" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "DifficultyTableOnSong_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Song_sha256_key" ON "Song"("sha256");
