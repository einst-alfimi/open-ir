import { afterAll, assertType, beforeAll, describe, expect, test } from 'vitest'
import { setup, $fetch } from '@nuxt/test-utils'
import { PrismaClient, Song } from '@prisma/client'

describe('song api test', async () => {
  await setup({
    // 初期化設定
  })
  beforeAll(async()=>{
    // prismaに初期データ投入
    // TODO 別ファイルに切り出し
    const prisma = new PrismaClient();
    await prisma.song.createMany({
      data: [
        {
          title: 'song title 1',
          subtitle: 'song subtitle 1',
          genre: 'song genre 1',
          artist: 'song artist 1',
          subartist: 'song subartist 1',
          md5: 'e2124646469a59aa35c40abfd460a843',
          sha256: '9032b908f6d2fceb0ec367849da1dba9257a82fc80c216475accff956c2e5438',
          mode: 'SP',
          level: 12,
          lntype: 0,
          judge: 1,
          notes: 2000,
          total: 770,
          minbpm: 150,
          maxbpm: 150,
          hasUndefinedLN : false,
          hasLN: false,
          hasCN: false,
          hasHCN: false,
          hasMine: false,
          hasRandom: false,
          hasStop: false,
        }
      ],
    });
  });
  afterAll(async()=>{
    // prismaデータ削除
    const prisma = new PrismaClient();
    await prisma.song.deleteMany();
  });

  test('song type test', async () => {
    const response = await $fetch('/api/song/9032b908f6d2fceb0ec367849da1dba9257a82fc80c216475accff956c2e5438');
    const {body, headers} = response;
    // TODO いけてない
    const songData = response as Song; 
    expect(songData.title).to.equal('song title 1');
  })
})