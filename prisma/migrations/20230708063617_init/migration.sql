/*
  Warnings:

  - You are about to drop the column `best` on the `Score` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "SongAchievement" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "songId" INTEGER NOT NULL,
    "option" INTEGER NOT NULL,
    "bestClearId" INTEGER,
    "bestScoreId" INTEGER,
    "bestExscore" INTEGER NOT NULL,
    CONSTRAINT "SongAchievement_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "SongAchievement_bestClearId_fkey" FOREIGN KEY ("bestClearId") REFERENCES "Score" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "SongAchievement_bestScoreId_fkey" FOREIGN KEY ("bestScoreId") REFERENCES "Score" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Score" (
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
    "exscore" INTEGER NOT NULL,
    "maxcombo" INTEGER NOT NULL,
    "notes" INTEGER NOT NULL,
    "passnotes" INTEGER NOT NULL,
    "minbp" INTEGER NOT NULL,
    "option" INTEGER NOT NULL,
    "assist" INTEGER NOT NULL,
    "gauge" INTEGER NOT NULL,
    "deviceType" TEXT NOT NULL,
    "judgeAlgorithm" TEXT NOT NULL,
    "rule" TEXT NOT NULL,
    "ghost" TEXT,
    "content" TEXT,
    "authorId" INTEGER NOT NULL,
    "orajaVersionId" INTEGER NOT NULL,
    "songId" INTEGER NOT NULL,
    CONSTRAINT "Score_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Score_orajaVersionId_fkey" FOREIGN KEY ("orajaVersionId") REFERENCES "OrajaVersion" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Score_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Score" ("assist", "authorId", "clear", "content", "deviceType", "ebd", "egd", "egr", "ems", "epg", "epr", "exscore", "gauge", "ghost", "id", "judgeAlgorithm", "lbd", "lgd", "lgr", "lms", "lntype", "lpg", "lpr", "maxcombo", "minbp", "notes", "option", "orajaVersionId", "passnotes", "rule", "songId") SELECT "assist", "authorId", "clear", "content", "deviceType", "ebd", "egd", "egr", "ems", "epg", "epr", "exscore", "gauge", "ghost", "id", "judgeAlgorithm", "lbd", "lgd", "lgr", "lms", "lntype", "lpg", "lpr", "maxcombo", "minbp", "notes", "option", "orajaVersionId", "passnotes", "rule", "songId" FROM "Score";
DROP TABLE "Score";
ALTER TABLE "new_Score" RENAME TO "Score";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "SongAchievement_bestClearId_key" ON "SongAchievement"("bestClearId");

-- CreateIndex
CREATE UNIQUE INDEX "SongAchievement_bestScoreId_key" ON "SongAchievement"("bestScoreId");
