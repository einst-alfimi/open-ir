export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  console.log(body);
  // const prisma = db.getInstance();

  return {
    "id": "id dog",
    "unique": "unique dog",
    "version": "version dog",
    "accessToken": "access token dog",
  } 
})