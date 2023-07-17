

// TODO Anyではないですが…
// セッション管理は他の方法を検討
const setUserSession = async (user: any) => {
  const prisma = db.getInstance();

  // Token生成
  let chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let token = '';
  for ( var i = 0; i < 8; i++ ) {
    token += chars.charAt(Math.floor(Math.random() * chars.length));
  }

  // 日付生成
  const date= new Date();
  const expiredAt = new Date(date.setDate(date.getDate()+1));

  return await prisma.userSession.create({
    data: {
      userId: user.id,
      token,
      expiredAt 
    }
  })
}

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  console.log(body);
  const prisma = db.getInstance();
  const userParams = {
    name: String(body.id).trim(),
    loginId: String(body.id).trim(),
    password: String(body.password).trim(),
  }
  if (!userParams.loginId || !userParams.password) {
    return;
  }

  // ID確認
  const loginUser = await prisma.user.findFirst({
    where: { loginId: body.id }
  })

  if (loginUser) {
    // パスワード認証NG
    if (body.password != loginUser.password) {
      return ;
    }
    const session = await setUserSession(loginUser)

    return {
      "id": loginUser.name,
      "unique": "uniquetag----TODO----",
      "version": "versiontag----TODO----",
      "accessToken": session.token,
    } 
  } else {
    // テスト用にとりあえず新規ユーザ作る
    // 将来的に別窓口にする
    const newUser = await prisma.user.create({
      data: userParams,
    })
    const session = await setUserSession(newUser)
    return {
      "id": newUser.name,
      "unique": "uniquetag----TODO----",
      "version": "versiontag----TODO----",
      "accessToken": session.token,
    } 
  }

})