/*
  Warnings:

  - The primary key for the `SongAchievement` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `SongAchievement` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_SongAchievement" (
    "songId" INTEGER NOT NULL,
    "authorId" INTEGER NOT NULL,
    "option" INTEGER NOT NULL,
    "bestClearId" INTEGER,
    "bestScoreId" INTEGER,
    "bestExscore" INTEGER NOT NULL,

    PRIMARY KEY ("songId", "authorId", "option"),
    CONSTRAINT "SongAchievement_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "SongAchievement_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "SongAchievement_bestClearId_fkey" FOREIGN KEY ("bestClearId") REFERENCES "Score" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "SongAchievement_bestScoreId_fkey" FOREIGN KEY ("bestScoreId") REFERENCES "Score" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_SongAchievement" ("authorId", "bestClearId", "bestExscore", "bestScoreId", "option", "songId") SELECT "authorId", "bestClearId", "bestExscore", "bestScoreId", "option", "songId" FROM "SongAchievement";
DROP TABLE "SongAchievement";
ALTER TABLE "new_SongAchievement" RENAME TO "SongAchievement";
CREATE UNIQUE INDEX "SongAchievement_bestClearId_key" ON "SongAchievement"("bestClearId");
CREATE UNIQUE INDEX "SongAchievement_bestScoreId_key" ON "SongAchievement"("bestScoreId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;