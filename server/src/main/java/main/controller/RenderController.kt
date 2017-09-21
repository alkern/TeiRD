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

    @RequestMapping("/{server}/{urn:.+}")
    fun render(@PathVariable server: String, @PathVariable urn: String,
               @RequestParam(defaultValue = "default") style: String): String {
        val loader = FileLoader()

        val source = loader.getXmlSource(server, urn)
        val xsltStylesheet = loader.loadTransformationStylesheet()
        val target = XslTransformator(xsltStylesheet).transform(source)

        val stylesheet = loader.loadStylesheet(style)

        return target.replaceFirst("TOREPLACE", stylesheet)
    }

    @RequestMapping("/styles")
    fun getStyles(): String {
        val builder = StringBuilder()
        builder.append("<title>CTS-Renderer Styles</title>")
        builder.append("Usable Styles:<br/>")
        val folder = File("/var/lib/tomcat7/webapps/renderer")
        folder.listFiles()
                .map { it.name }
                .filter { it.endsWith(".css") }
                .map { it.replace(".css", "") }
                .forEach { builder.append(it + "<br/>") }
        return builder.toString()
    }
}

class FileLoader {
    fun getXmlSource(server: String, urnResource: String): Source {
        val xmlSource = HTTPClient().get(server, urnResource)
        return StreamSource(ByteArrayInputStream(xmlSource.toByteArray(StandardCharsets.UTF_8)))
    }

    fun loadTransformationStylesheet(): StreamSource {
        return StreamSource(File("webapps/renderer/WEB-INF/classes/template.xsl"))
    }

    fun loadStylesheet(style: String): String {
        return "../../$style.css"
    }
}

class HTTPClient {
    private val rest: RestTemplate = RestTemplate()
    private val headers: HttpHeaders = HttpHeaders()

    init {
        headers.add("Content-Type", "application/xml;charset=UTF-8")
        headers.add("Accept", "*/*")
    }

    fun get(server: String, urnResource: String): String {
        val uri = generateURI(server, urnResource)
        val requestEntity = HttpEntity<String>("", headers)
        val responseEntity = rest.exchange(uri, HttpMethod.GET, requestEntity, String::class.java)
        return responseEntity.body.toString()
    }

    private fun generateURI(server: String, urn: String): String {
        return "http://cts.informatik.uni-leipzig.de/$server/cts/" +
                "?request=GetPassage&urn=$urn&configuration=divs=true_escapepassage=false"
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
