package wvlet.lang.native
import wvlet.airframe.codec.MessageCodec
import wvlet.log.LogSupport
import scala.scalanative.unsafe.*

object WvcLib extends LogSupport:
  /**
    * Run WvcMain with the given arguments
    * @param argJson
    *   json string representing command line arguments ["arg1", "arg2", ...]
    * @return
    */
  @exported("wvlet_compile_main")
  def compile_main(argJson: CString): Int =
    try
      val json = fromCString(argJson)
      trace(s"args: ${json}")
      val args = MessageCodec.of[Array[String]].fromJson(json)
      WvcMain.main(args)
      0
    catch
      case e: Throwable =>
        warn(e)
        1

  /**
    * Compile a Wvlet query and return the SQL as a string
    * @param queryJson
    *   json string representing query string
    * @return
    *   generated SQL as a CString
    */
  @exported("wvlet_compile_query")
  def compile_query(queryJson: CString): CString =
    try
      val json = fromCString(queryJson)
      trace(s"query: ${json}")
      val query = MessageCodec.of[String].fromJson(json)
      val args = Array("-q", query, "-x")
      val (sql, _) = WvcMain.compileWvletQuery(args)
      toCString(sql)
    catch
      case e: Throwable =>
        warn(e)
        toCString("")
