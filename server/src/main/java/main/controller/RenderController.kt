package main.controller

import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.client.RestTemplate
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileInputStream
import java.nio.charset.StandardCharsets
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMResult
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource

@RestController
class RenderController {

    private val INVALID_URN = "invalid urn"

    @RequestMapping("/render/{cts}/{urn:.+}")
    fun render(@PathVariable cts: String, @PathVariable urn: String, @RequestParam(defaultValue = "default") style: String = "default"): String {
        val urnResource = Urn.new(urn)
        if (urnResource == null) return INVALID_URN

        val loader = FileLoader()

        val source = loader.getXmlSource(cts, urnResource)
        val xsltStylesheet = loader.loadTransformationStylesheet()
        val target = XslTransformator(xsltStylesheet).transform(source)

        val stylesheet = loader.loadStylesheet(style)
        //TODO add css-stylesheet to html

        return target
    }
}

data class Urn(val namespace: String, val work: String, val passage: String = "", val subreference: String?) {
    companion object {
        fun new(urn: String): Urn? {
            val parts = urn.split(":").filter { it != "" }
            if (parts.size !in 4..6) return null
            if (parts[0] != "urn" || parts[1] != "cts") return null

            val namespace = parts[2]
            val work = parts[3]
            val passage = if (parts.size > 4) parts[4] else ""
            val subreference = if (parts.size > 5) parts[5] else null

            return Urn(namespace, work, passage, subreference)
        }
    }

    fun getUrlParams(): String {
        var result = "?request=GetPassage&urn=urn:cts:$namespace:$work:$passage"
        if (this.subreference != null) result + ":${this.subreference}"
        return result
    }
}

class FileLoader {
    fun getXmlSource(cts: String, urnResource: Urn): Source {
        val xmlSource = HTTPClient().get(cts, urnResource)
        return StreamSource(ByteArrayInputStream(xmlSource.toByteArray(StandardCharsets.UTF_8)))
    }

    fun loadTransformationStylesheet(): StreamSource {
        return StreamSource(File("out/production/resources/template.xsl"))
    }

    fun loadStylesheet(style: String): String {
        return "$style.css" //TODO load external stylesheet
    }
}

class HTTPClient {
    private val rest: RestTemplate = RestTemplate()
    private val headers: HttpHeaders = HttpHeaders()

    init {
        headers.add("Content-Type", "application/xml;charset=UTF-8")
        headers.add("Accept", "*/*")
    }

    fun get(cts: String, urnResource: Urn): String {
        val uri = "http://$cts.informatik.uni-leipzig.de/pbc/cts/${urnResource.getUrlParams()}&&configuration=divs=true_escapepassage=false"
        val requestEntity = HttpEntity<String>("", headers)
        val responseEntity = rest.exchange(uri, HttpMethod.GET, requestEntity, String::class.java)
        return responseEntity.body.toString()
    }
}

class XslTransformator(val style: StreamSource) {
    fun transform(xmlSource: Source): String {
        val transformer = TransformerFactory.newInstance().newTransformer(style)
        val stream = ByteArrayOutputStream()
        val result = StreamResult(stream)
        transformer.transform(xmlSource, result)
        return stream.toString(StandardCharsets.UTF_8.name())
    }

}