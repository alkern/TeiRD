package main.controller

import org.junit.Assert.*
import org.junit.Test
import java.net.MalformedURLException

class UrnTest {

    @Test
    fun testValidUrns() {
        val validUrn = Urn.new("urn:cts:ns:test")
        if (validUrn == null) {
            fail()
            return
        }
        assertEquals("ns", validUrn.namespace)
        assertEquals("test", validUrn.work)
        assertEquals(null, validUrn.passage)
        assertEquals(null, validUrn.subreference)

        val validUrn2 = Urn.new("urn:cts:ns:test:passage")
        if (validUrn2 == null) {
            fail()
            return
        }
        assertEquals("ns", validUrn2.namespace)
        assertEquals("test", validUrn2.work)
        assertEquals("passage", validUrn2.passage)
        assertEquals(null, validUrn2.subreference)

        val validUrn3 = Urn.new("urn:cts:ns:test:passage:sub")
        if (validUrn3 == null) {
            fail()
            return
        }
        assertEquals("ns", validUrn3.namespace)
        assertEquals("test", validUrn3.work)
        assertEquals("passage", validUrn3.passage)
        assertEquals("sub", validUrn3.subreference)
    }

    @Test
    fun testEmptyUrnThrowsException() {
        assertEquals(null, Urn.new(""))
    }

    @Test
    fun testTooShortUrnThrowsException() {
        assertEquals(null, Urn.new("urn:cts"))
    }

    @Test
    fun testMissingUrnThrowsException() {
        assertEquals(null, Urn.new("cts:ns:work:passage"))
    }

    @Test
    fun testMissingctsThrowsException() {
        assertEquals(null, Urn.new("urn:work:passage"))
    }

    @Test
    fun testExampleToString() {
        assertEquals("?request=GetPassage&urn=urn:cts:tg:IbsenHenrik.BrandEindramatischesGedicht:1-5",
                Urn.new("urn:cts:tg:IbsenHenrik.BrandEindramatischesGedicht:1-5")?.getUrlParams())
    }
}