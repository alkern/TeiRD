package main.controller

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.PropertySource
import org.springframework.context.annotation.PropertySources
import org.springframework.core.io.Resource
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
import java.util.*
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMResult
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource

val FOLDER = "WEB-INF/classes"

@RestController
class RenderController {

    private val props = Properties()

    init {
        val propFile = File(this::class.java.classLoader.getResource("config.properties").file)
        props.load(FileInputStream(propFile))
    }

    @RequestMapping("/{server}/{urn:.+}")
    fun render(@PathVariable server: String, @PathVariable urn: String,
               @RequestParam(defaultValue = "default") style: String): String {
        val loader = FileLoader(props)

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
        builder.append("Verfügbare Styles:<br/>")
        val folder = File("${props.read(Config.DIR)}/${props.read(Config.APP)}")
        folder.listFiles()
                .map { it.name }
                .filter { it.endsWith(".css") }
                .map { it.replace(".css", "") }
                .forEach { builder.append(it + "<br/>") }
        return builder.toString()
    }
}

class FileLoader(private val props: Properties) {
    fun getXmlSource(server: String, urnResource: String): Source {
        val xmlSource = HTTPClient(props).get(server, urnResource)
        return StreamSource(ByteArrayInputStream(xmlSource.toByteArray(StandardCharsets.UTF_8)))
    }

    fun loadTransformationStylesheet(): StreamSource {
        val path = "${props.read(Config.DIR)}/${props.read(Config.APP)}/$FOLDER/template.xsl"
        return StreamSource(File(path))
    }

    fun loadStylesheet(style: String): String {
        return "../$style.css"
    }
}

class HTTPClient(private val props: Properties) {
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
        return "http://${props.read(Config.SERVER)}:${props.read(Config.PORT)}/$server/cts/" +
                "?request=GetPassage&urn=$urn&configuration=divs=true_escapepassage=false"
    }
}

class XslTransformator(private val style: StreamSource) {
    fun transform(xmlSource: Source): String {
        val transformer = TransformerFactory.newInstance().newTransformer(style)
        val stream = ByteArrayOutputStream()
        val result = StreamResult(stream)
        transformer.transform(xmlSource, result)
        return stream.toString(StandardCharsets.UTF_8.name())
    }
}

enum class Config(val value: String) {
    SERVER("server-path"),
    PORT("server-port"),
    DIR("webapps-dir"),
    APP("app-name")
}

fun Properties.read(conf: Config): String {
    return getProperty(conf.value)
}