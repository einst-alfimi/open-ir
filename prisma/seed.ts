import { PrismaClient, Prisma } from '@prisma/client'
const prisma = new PrismaClient()

const songData: Prisma.SongCreateInput[] = [
  {
    title: '(^^) -BGA-',
    subtitle: '',
    genre: 'foon',
    artist: 'Yamajet / BGA:cyclia',
    subartist: '',
    md5: '27ca62af26e0eca732ed0852887333ac',
    sha256: '75d62857cfa42ca6ae22ca3fcfa891f93a1b6ed64de072cd26fa1f031794c974',
    mode: 'BEAT_5K',
    level: 1,
    lntype: 0,
    judge: 25,
    notes: 9,
    total: 83,
    minbpm: 140,
    maxbpm: 140,
    url: null,
    appendurl: null,
    description: null,
    hasUndefinedLN: false,
    hasLN: false,
    hasCN: false,
    hasHCN: false,
    hasMine: false,
    hasRandom: false,
    hasStop: false,
    published: false
  }
]

const main = async () => {
  // Add Song
  songData.forEach(async (s) => {
    await prisma.song.upsert({
      where: {sha256: s.sha256},
      create: s,
      update: s,
    })
  })

}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })