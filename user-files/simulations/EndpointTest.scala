package loadtest

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.core.feeder._
import scala.concurrent.duration._

class multiurl extends Simulation {

  val nbUsers = System.getProperty("users", "10").toInt
  val nbDuration = System.getProperty("duration", "10").toDouble
  val env = System.getProperty("env", "/").toString
  val base = System.getProperty("base", "URL").toString
  val csvFeeder = csv("endpointlist.csv").random


  val httpProtocol = http
    .baseUrl(base + env) // Here is the root for all relative URLs
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8") // Here are the common headers
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20100101 Firefox/16.0")
  
    val scn = scenario("Load test")
      .forever() {
        exec(
          feed(csvFeeder)
            .exec(
              http(base + env + "${Urls}")
                .get("${Urls}")
            ).pause(1)
        )
      }

  setUp(
    scn.inject(
      atOnceUsers(nbUsers)
    )
  )
  .protocols(httpProtocol)
  .maxDuration(nbDuration seconds)
}
