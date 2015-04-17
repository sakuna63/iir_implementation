import scala.io.Source
import java.io._

/**
 * インデックス化のクラス
 * @constructor 指定されたディレクトリ内のファイルを読み込む
 * @param dirPath インデックスを作るファイルが入ったディレクトリ名
 */
class Indexing(dirPath: String) {

  private val files = new File(dirPath).listFiles

  /**
   * HTMLファイルを文字列にして返す
   * @param filePath HTMLファイルのパス
   * @return 変換後の文字列
   */
  def HTML2String(filePath: String): String = {
    val file = Source.fromFile(filePath)

    try
      file.getLines.mkString(" ")
    finally
      file.close
  }

  /**
   * ファイルの内容の中で必要な部分だけ切り出す
   * => bodyタグの中の<!--End of Navigation Panel-->と<!--Navigation Panel-->の間
   * @param filePath
   * @return 必要な部分の文字列
   */
  def extractContent(filePath: String): String = {
    val fileContent = HTML2String(filePath)

    """<!--End of Navigation Panel-->.*<!--Navigation Panel-->""".r
      .findAllMatchIn(fileContent).mkString
  }

  /**
   * 文字列内のタグを取り除く
   * @param content
   * @return タグを取り除いた文字列
   */
  def removeHTMLTag(content: String): String =
    content.replaceAll("<.*?>", "")

  /**
   * 文字列を単語に分ける
   * @param content
   * @return 単語の配列
   */
  def toTerms(content: String): Array[String] =
    """[a-zA-Z]+""".r.findAllMatchIn(content)
      .map(_.toString).toArray

  /**
   * 文字列を単語に分け、小文字に直して返す
   * @param content
   * @return 単語の配列
   */
  def toLowerTerms(content: String): Array[String] =
    """[a-zA-Z]+""".r.findAllMatchIn(content)
      .map(_.toString.toLowerCase).toArray

  /**
   * 転置インデックスを作る
   * 文書IDは1.1, 1.2.3,...のような形
   * @return 転置インデックス（単語と文書IDの配列のMap）
   */
  def makeInvertedIndex: Map[String, Array[String]] = {
    //文書の章ごとの全ての単語を取得
    val allTerms: Array[Array[String]] = files.map(_.getPath)
                                        .map(extractContent(_))
                                        .map(removeHTMLTag(_))
                                        .map(toLowerTerms(_))

    //文書IDとのペアを作成
    files.map(_.getName.split(".[h]")(0)) //章番号を取得 ex. 1.1.html -> 1
      .zip(allTerms) //単語とセットでペアにする ex. [(1, allTerms(0)), (1, allTerms(1)), ...]
      .map(_.swap) //(単語, ID)の順にする
      .flatMap { case (t, n) => //Array[Array[String], Int]からArray[String, Int]に変換
        t.map(new Tuple2(_, n))
    }.groupBy(_._1).mapValues(_.map(_._2).distinct.sorted) //(単語, DocID[1, 2, 3,...])の組を作る
  }

  /**
   * filesプロパティのゲッター
   * @return files
   */
  def getFiles: Array[File] = files
}
