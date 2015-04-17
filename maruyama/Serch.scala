/**
 * main
 */
object Search {
  def main(args: Array[String]) = {

    if(args.length != 1){
      println("検索語を引数に一つだけ指定してください。")
      System.exit(0)
    }

    val i = new Indexing("chaps/")

    val d = i.makeInvertedIndex

    d.foreach{ case (s, a) =>
        println("(" + s + ", " + a.deep + ")")
    }
    println("-----------------")

    println(args(0) + " : ")
    d.get(args(0)) match {
      case Some(a) => a.foreach(s => print(s + ", "))
        println("\n辞書内の語数： " + d.keySet.size)
        println("出現回数： " + a.length)
      case None => println("この単語の出現する文書は見つかりませんでした。")
    }
  }
}
