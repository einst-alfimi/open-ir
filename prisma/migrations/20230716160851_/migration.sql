-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NULL,
    `name` VARCHAR(191) NULL,
    `loginId` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `content` VARCHAR(191) NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Song` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `subtitle` VARCHAR(191) NOT NULL,
    `genre` VARCHAR(191) NOT NULL,
    `artist` VARCHAR(191) NOT NULL,
    `subartist` VARCHAR(191) NOT NULL,
    `md5` VARCHAR(191) NOT NULL,
    `sha256` VARCHAR(191) NOT NULL,
    `mode` VARCHAR(191) NOT NULL,
    `level` INTEGER NOT NULL,
    `lntype` INTEGER NOT NULL,
    `judge` INTEGER NOT NULL,
    `notes` INTEGER NOT NULL,
    `total` INTEGER NOT NULL,
    `minbpm` INTEGER NOT NULL,
    `maxbpm` INTEGER NOT NULL,
    `url` VARCHAR(191) NULL,
    `appendurl` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,
    `hasUndefinedLN` BOOLEAN NOT NULL,
    `hasLN` BOOLEAN NOT NULL,
    `hasCN` BOOLEAN NOT NULL,
    `hasHCN` BOOLEAN NOT NULL,
    `hasMine` BOOLEAN NOT NULL,
    `hasRandom` BOOLEAN NOT NULL,
    `hasStop` BOOLEAN NOT NULL,
    `published` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `Song_sha256_key`(`sha256`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SongAchievement` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `songId` INTEGER NOT NULL,
    `authorId` INTEGER NOT NULL,
    `option` INTEGER NOT NULL,
    `bestClearId` INTEGER NULL,
    `bestScoreId` INTEGER NULL,
    `bestExscore` INTEGER NOT NULL,

    UNIQUE INDEX `SongAchievement_bestClearId_key`(`bestClearId`),
    UNIQUE INDEX `SongAchievement_bestScoreId_key`(`bestScoreId`),
    UNIQUE INDEX `SongAchievement_songId_authorId_option_key`(`songId`, `authorId`, `option`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrajaVersion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `versionHash` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `OrajaVersion_versionHash_key`(`versionHash`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ApiVersion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `versionHash` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `ApiVersion_versionHash_key`(`versionHash`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Score` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `clear` INTEGER NOT NULL,
    `lntype` INTEGER NOT NULL,
    `epg` INTEGER NOT NULL,
    `lpg` INTEGER NOT NULL,
    `egr` INTEGER NOT NULL,
    `lgr` INTEGER NOT NULL,
    `egd` INTEGER NOT NULL,
    `lgd` INTEGER NOT NULL,
    `ebd` INTEGER NOT NULL,
    `lbd` INTEGER NOT NULL,
    `epr` INTEGER NOT NULL,
    `lpr` INTEGER NOT NULL,
    `ems` INTEGER NOT NULL,
    `lms` INTEGER NOT NULL,
    `exscore` INTEGER NOT NULL,
    `maxcombo` INTEGER NOT NULL,
    `notes` INTEGER NOT NULL,
    `passnotes` INTEGER NOT NULL,
    `minbp` INTEGER NOT NULL,
    `option` INTEGER NOT NULL,
    `assist` INTEGER NOT NULL,
    `gauge` INTEGER NOT NULL,
    `deviceType` VARCHAR(191) NOT NULL,
    `judgeAlgorithm` VARCHAR(191) NOT NULL,
    `rule` VARCHAR(191) NOT NULL,
    `ghost` VARCHAR(191) NULL,
    `content` VARCHAR(191) NULL,
    `authorId` INTEGER NOT NULL,
    `orajaVersionId` INTEGER NOT NULL,
    `songId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DifficultyTable` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `content` VARCHAR(191) NULL,
    `url` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DifficultyTableOnSong` (
    `difficultyTableId` INTEGER NOT NULL,
    `songId` INTEGER NOT NULL,

    PRIMARY KEY (`difficultyTableId`, `songId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SongAchievement` ADD CONSTRAINT `SongAchievement_songId_fkey` FOREIGN KEY (`songId`) REFERENCES `Song`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SongAchievement` ADD CONSTRAINT `SongAchievement_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SongAchievement` ADD CONSTRAINT `SongAchievement_bestClearId_fkey` FOREIGN KEY (`bestClearId`) REFERENCES `Score`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SongAchievement` ADD CONSTRAINT `SongAchievement_bestScoreId_fkey` FOREIGN KEY (`bestScoreId`) REFERENCES `Score`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Score` ADD CONSTRAINT `Score_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Score` ADD CONSTRAINT `Score_orajaVersionId_fkey` FOREIGN KEY (`orajaVersionId`) REFERENCES `OrajaVersion`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Score` ADD CONSTRAINT `Score_songId_fkey` FOREIGN KEY (`songId`) REFERENCES `Song`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DifficultyTableOnSong` ADD CONSTRAINT `DifficultyTableOnSong_difficultyTableId_fkey` FOREIGN KEY (`difficultyTableId`) REFERENCES `DifficultyTable`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DifficultyTableOnSong` ADD CONSTRAINT `DifficultyTableOnSong_songId_fkey` FOREIGN KEY (`songId`) REFERENCES `Song`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
