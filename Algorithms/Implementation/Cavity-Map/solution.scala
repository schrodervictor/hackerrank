object Solution {

  def main(args: Array[String]) {
    val (n, depths) = readInput()
    val answer = findCavities(n, depths)
    printAnswer(n, answer)
  }

  def findCavities(n: Int, depths: String): String = {
    val maxElem = n*n - 1

    def findCavitiesIter(elem: Int, output: String): String = elem match {
      case _ if elem > maxElem => output
      case _
        // First row
        if elem < n
        // Last row
        || elem > maxElem - n
        // First element of each row
        || elem % n == 0
        // Last element of each row
        || elem % n == n - 1 =>
        findCavitiesIter(elem + 1, output + depths.charAt(elem))
      case _ => {
        val depth: Int = depths.charAt(elem).asDigit
        val up: Int = depths.charAt(elem - n).asDigit
        val left: Int = depths.charAt(elem - 1).asDigit
        val right: Int = depths.charAt(elem + 1).asDigit
        val bottom: Int = depths.charAt(elem + n).asDigit
        if (depth > up && depth > left && depth > right && depth > bottom)
          findCavitiesIter(elem + 1, output + "X")
        else
          findCavitiesIter(elem + 1, output + depth)
      }
    }

    findCavitiesIter(0, "")
  }

  def printAnswer(n: Int, answer: String): Unit = {
    if (answer.length > 0) {
      println(answer.substring(0, n))
      printAnswer(n, answer.substring(n))
    }
  }

  def readInput(): (Int, String) = {
    val scanner = new java.util.Scanner(System.in)
    val n = scanner.nextInt()
    def readInputIter(n: Int, acc: String): String = n match {
      case 0 => acc
      case _ => readInputIter(n - 1, acc + scanner.next())
    }
    (n, readInputIter(n, ""))
  }

}
