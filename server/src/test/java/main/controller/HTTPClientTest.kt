package main.controller

import org.junit.Assert.*
import org.junit.Test

class HTTPClientTest {

    @Test
    fun testBrandExample() {
        val res = HTTPClient().get("cts", "textgrid", Urn.new("urn:cts:tg:IbsenHenrik.BrandEindramatischesGedicht:1-5")!!)
        print(res)
    }
}