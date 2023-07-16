export default defineEventHandler(async (event) => {
  console.log("score get api index");
  console.log(event.context)
  const query = await getQuery(event);
  console.log(query)
  const prisma = db.getInstance();


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