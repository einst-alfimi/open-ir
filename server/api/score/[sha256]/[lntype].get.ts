import { Prisma } from "@prisma/client"

export default defineEventHandler(async (event) => {
  console.log("get Score API")
  const sha256 = event.context.params?.sha256 ;
  const prisma = db.getInstance();
  const query = getQuery(event);
  console.log(query)
  const song = await prisma.song.findFirst({
    where: { sha256 } });
  if (song) {
    // クエリはかなりUNKOである
    const score = await prisma.$queryRaw(Prisma.sql`
    SELECT a.*, bc.clear as bestClear FROM Score a
    left JOIN SongAchievement am
    on a.songId = am.songId AND a.authorId = am.authorId AND a.option = am.option
    left JOIN Score bc
    on am.bestClearId = bc.id 
    WHERE 
    a.songId = ${song.id}
    and am.bestScoreId is not null
    and NOT EXISTS (
        SELECT 1
        FROM Score b
        WHERE a.authorId = b.authorId
        AND a.songId = b.songId
        AND (a.exscore < b.exscore)
    );`)
    return score;
  }
  return [// dummydata
  { 
      "player": "dummy player 1",
      "epg": "2",
      "lpg": "2",
      "egr": "2",
      "lgr": "2",
      "egd": "2",
      "lgd": "2",
      "ebd": "2",
      "lbd": "2",
      "epr": "2",
      "lpr": "2",
      "ems": "2",
      "lms": "2",
  },]  
})