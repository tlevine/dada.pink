Perhaps you like `importXML` from Google Sheets but want something
that you can run on more URLs. It's pretty to implement a similar
function in other languages. For example, here it is in Python. ::

    import lxml.html
    def importXML(url, xpath):
        return lxml.html.parse(url).xpath(xpath)[0]

You could run that on all of your URLs and then open the result in Google Sheets. ::

    for url in urls:
        print(importXML(url))

