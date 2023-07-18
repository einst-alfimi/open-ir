import { PrismaClient } from "@prisma/client"

export class db {
  private static instance: PrismaClient;
  private constructor() {
  }
  static getInstance() {
    if (!db.instance) {
      db.instance = new PrismaClient();
      return db.instance;
    }
    return db.instance;
  }
}

export async function getUserSession (token?: string){
  const prisma = db.getInstance();
  if (!token) {
    return;
  }

  return await prisma.userSession.findFirst({
    where: {
      token,
      expiredAt:  {
        gte: new Date(),
      },
    },
  })
}

