/*
  Warnings:

  - A unique constraint covering the columns `[versionHash]` on the table `OrajaVersion` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "OrajaVersion_versionHash_key" ON "OrajaVersion"("versionHash");
