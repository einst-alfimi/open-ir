import { PrismaClient } from '@prisma/client'

const convertClearType = (clearstr: String) => {
  switch(clearstr) {
    case 'NoPlay': return 0; 
    case 'Failed': return 1;
    case 'AssistEasy': return 2;
    case 'LightAssistEasy': return 3;
    case 'Easy': return 4;
    case 'Normal': return 5;
    case 'Hard': return 6;
    case 'ExHard': return 7;
    case 'FullCombo': return 8;
    case 'Perfect': return 9;
    case 'Max': return 10;
    default: return 0;
  }
};

const calcExscore = (score: any) => {
  return (score.lpg + score.epg) * 2 + score.lgr + score.lgr
}
export default defineEventHandler(async (event) => {
  console.log("song post api")
  
  const body = await readBody(event);
  const header = {
    apiToken: getRequestHeader(event, 'apiToken'),
    jarToken: getRequestHeader(event, 'jarToken'),
    accessToken: getRequestHeader(event, 'accessToken'),
  }
  console.log(header)
  const song = body.model;
  delete song.values; // これなにはいってるのかわからん
  const prisma = db.getInstance();
  const dummyUser = {
    name: 'dummy user1'
  }
  const loginUser = await prisma.user.upsert({
    where: {
      id: 1,
    },
    update: dummyUser,
    create: dummyUser,
  })
  // get Version
  const dummyVersion = {
      name: 'dummy user1',
      versionHash: 'dummyhashhash-dammydammy'
  }
  const playVersion = await prisma.orajaVersion.upsert({
    where: {
      id: 1,
    },
    update: dummyVersion,
    create: dummyVersion,
  })

  // send Song infomation
  const upsertSong = await prisma.song.upsert({
    where: {
      sha256: song.sha256,
    },
    update: song,
    create: song,
  })

  // send Socre
  const score = body.score;
  score.exscore = calcExscore(score)

  delete score.sha256;
  delete score.player;
  delete score.date;
  // set relations
  score.author = {connect : {id: loginUser.id}}
  score.song = {connect : {id: upsertSong.id}}
  score.orajaVersion = {connect : {id: playVersion.id}}
  score.clear = convertClearType(score.clear)
  const updateScore = await prisma.score.create({
      data: score,
  })

  // set achievement
  const currentAchievement = await prisma.songAchievement.findFirst({
    where: {
      authorId: loginUser.id,
      songId: upsertSong.id,
      option: score.option,
    },
    include: {
      bestClear: true,
      bestScore: true,
    },
  })
  // check Score 
  if (currentAchievement) {
    // Score Check
    if (currentAchievement.bestScore && (
      updateScore.exscore > currentAchievement.bestExscore
    )) {
      currentAchievement.bestScoreId = updateScore.id;
      currentAchievement.bestExscore = updateScore.exscore
    }

    // Clear Check
    if (currentAchievement.bestClear && (
      updateScore.clear > currentAchievement.bestClear.clear
    )) {
      currentAchievement.bestClearId = updateScore.id;
    }
    await prisma.songAchievement.update({
      where: {
        id: currentAchievement?.id
      },
      data: {
        bestClearId: currentAchievement.bestClearId,
        bestScoreId: currentAchievement.bestScoreId,
        bestExscore: currentAchievement.bestExscore,
      },
    })
  } else {
    // NewScore
    await prisma.songAchievement.create({
      data: {
        authorId: loginUser.id,
        songId: upsertSong.id,
        option: score.option,
        bestClearId: updateScore.id,
        bestScoreId: updateScore.id,
        bestExscore: updateScore.exscore,
      },
    })
  }

  return {};
})