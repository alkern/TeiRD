package main.controller

import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.io.File
import java.io.FileInputStream
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMResult
import javax.xml.transform.stream.StreamSource

@RestController
class RenderController {

    private val INVALID_URN = "invalid urn"

    @RequestMapping("/render/{urn}")
    fun render(@PathVariable urn: String, @RequestParam(defaultValue = "default") style: String = "default"): String {
        val urnResource = Urn.new(urn)
        if (urnResource == null) return INVALID_URN

        val loader = FileLoader()

        val source = loader.getXmlSource(urnResource)
        val target = XslTransformator().transform(source)

        val stylesheet = loader.loadStylesheet(style)
        //TODO add css-stylesheet to html

        return "$urn $stylesheet" //TODO return rendered html
    }
}

data class Urn(val namespace: String, val work: String, val passage: String = "", val subreference: String = "") {
    companion object {
        fun new(urn: String): Urn? {
            val parts = urn.split(":").filter { it != "" }
            if (parts.size !in 4..6) return null
            if (parts[0] != "urn" || parts[1] != "cts") return null

            val namespace = parts[2]
            val work = parts[3]
            val passage = if (parts.size > 4) parts[4] else ""
            val subreference = if (parts.size > 5) parts[5] else ""

            return Urn(namespace, work, passage, subreference)
        }
    }
}

class FileLoader {
    fun getXmlSource(urnResource: Urn): Source {
        //TODO get xml from cts
        return StreamSource(FileInputStream(File("out/production/resources/brand.xml")))
    }

    fun loadStylesheet(style: String): String {
        return "$style.css" //TODO load external stylesheet
    }
}

class XslTransformator {
    fun transform(xmlSource: Source): Result {
        //TODO transform xml to html
        val transformer = TransformerFactory.newInstance().newTransformer()
        val result = DOMResult()
        transformer.transform(xmlSource, result)
        return result
    }

}