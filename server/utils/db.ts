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
  