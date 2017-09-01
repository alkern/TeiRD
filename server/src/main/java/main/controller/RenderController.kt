package main.controller

import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.net.MalformedURLException

@RestController
class RenderController {

    private val INVALID_URN = "invalid urn"

    @RequestMapping("/render/{urn}")
    fun render(@PathVariable urn: String): String {
        try {
            val urnResouce = Urn.new(urn)
        } catch (e: MalformedURLException) {
            return INVALID_URN
        }

        return urn
    }
}

data class Urn(val namespace: String, val work: String, val passage: String = "", val subreference: String = "") {
    companion object {
        fun new(urn: String): Urn {
            val parts = urn.split(":")
            if (parts.size !in 4..6) throw MalformedURLException("Invalid URN $urn")
            if (parts[0] != "urn" || parts[1] != "cts") throw MalformedURLException("Invalid URN $urn")

            val namespace = parts[2]
            val work = parts[3]
            val passage = if (parts.size > 4) parts[4] else ""
            val subreference = if (parts.size > 5) parts[5] else ""

            return Urn(namespace, work, passage, subreference)
        }
    }
}
