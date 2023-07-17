export default defineEventHandler(async (event) => {
  console.log("get Song API")
  const sha256 = event.context.params?.sha256 ;
  const prisma = db.getInstance();
  const query = getQuery(event);
  console.log(query);
  const song = await prisma.song.findFirst({
    where: { sha256 } });
  return song;
})