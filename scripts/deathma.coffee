# Description:
#   デスマコロシアム未挑戦言語出力
#
#   第n回デスマコロシアムで挑戦者０名の言語を指定数分ランダムに出力します
#
# Commands:
#   deathma n count - 第 n 回で挑戦者０名の言語を count 個ランダムに出力する
#
# Author:
#   suppy193
module.exports = (robot) ->
  robot.respond /deathma (\d+) (\d+)$/i, (msg) ->
    n = msg.match[1]
    count = msg.match[2]
    # 『第n回デスマコロシアム』問題 集計報告 のトップページ
    robot.brain.set 'deathma8', "http://tbpgr.hatenablog.com/entry/20141129/1417276802"
    robot.brain.set 'deathma7', "http://tbpgr.hatenablog.com/entry/20140906/1410014282"
    robot.brain.set 'deathma6', "http://tbpgr.hatenablog.com/entry/20140726/1406388500"
    robot.brain.set 'deathma5', "http://tbpgr.hatenablog.com/entry/20140615/1402853082"
    robot.brain.set 'deathma4', "http://tbpgr.hatenablog.com/entry/20140525/1401011965"
    robot.brain.set 'deathma3', "http://tbpgr.hatenablog.com/entry/20140429/1398790099"
    robot.brain.set 'deathma2', "http://tbpgr.hatenablog.com/entry/20140405/1396714344"
    robot.brain.set 'deathma1', "http://tbpgr.hatenablog.com/entry/20140318/1395147131"
    url = robot.brain.get('deathma' + n)
    msg.send 'CodeIQ名物'
    msg.send '第' + n + '回デスマコロシアム'
    if url is null
      msg.send 'まだ開催されていません'
    else
      # 『第n回デスマコロシアム』問題 集計報告 のトップページを取得します
      robot.http(url)
      .get() (err, res, body) ->
        msg.send '今日挑戦するプログラム言語は'
        lang_list = body.split(/<\/?pre.*>/)[1].split("\n")
        challenge_lang = []
        if count > lang_list.length
          count = lang_list.length
        for i in [1..count]
          index = msg.random([0..lang_list.length-1])
          challenge_lang.push(lang_list[index])
          lang_list.splice(index, 1)
        msg.send challenge_lang.join('と')
        msg.send 'にしましょう！'
# Examples:
#Hubot> hubot deathma 8 3
#Hubot> CodeIQ名物
#Hubot> 第8回デスマコロシアム
#Hubot> 今日挑戦するプログラム言語は
#Hubot> UnlambdaとObjective-CとAda
#Hubot> にしましょう！
#Hubot> hubot deathma 8 9
#Hubot> CodeIQ名物
#Hubot> 第8回デスマコロシアム
#Hubot> 今日挑戦するプログラム言語は
#Hubot> ScalaとFalconとVB.NETとSQLとAdaとProlog (swi)とTclとUnlambdaとOz
#Hubot> にしましょう！
#Hubot> hubot deathma 1 3
#Hubot> CodeIQ名物
#Hubot> 第1回デスマコロシアム
#Hubot> 今日挑戦するプログラム言語は
#Hubot> bcとCLIPS
#Hubot> にしましょう！
#Hubot> hubot deathma 9 3
#Hubot> CodeIQ名物
#Hubot> 第9回デスマコロシアム
#Hubot> まだ開催されていません

