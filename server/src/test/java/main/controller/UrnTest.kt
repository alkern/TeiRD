package main.controller

import org.junit.Assert.*
import org.junit.Test
import java.net.MalformedURLException

class UrnTest {

    @Test
    fun testValidUrns() {
        val validUrn = Urn.new("urn:cts:ns:test")
        assertEquals("ns", validUrn.namespace)
        assertEquals("test", validUrn.work)
        assertEquals("", validUrn.passage)
        assertEquals("", validUrn.subreference)

        val validUrn2 = Urn.new("urn:cts:ns:test:passage")
        assertEquals("ns", validUrn2.namespace)
        assertEquals("test", validUrn2.work)
        assertEquals("passage", validUrn2.passage)
        assertEquals("", validUrn2.subreference)

        val validUrn3 = Urn.new("urn:cts:ns:test:passage:sub")
        assertEquals("ns", validUrn3.namespace)
        assertEquals("test", validUrn3.work)
        assertEquals("passage", validUrn3.passage)
        assertEquals("sub", validUrn3.subreference)
    }

    @Test(expected = MalformedURLException::class)
    fun testEmptyUrnThrowsException() {
        Urn.new("")
    }

    @Test(expected = MalformedURLException::class)
    fun testTooShortUrnThrowsException() {
        Urn.new("urn:cts")
    }

    @Test(expected = MalformedURLException::class)
    fun testMissingUrnThrowsException() {
        Urn.new("cts:ns:work:passage")
    }

    @Test(expected = MalformedURLException::class)
    fun testMissingctsThrowsException() {
        Urn.new("urn:work:passage")
    }
}