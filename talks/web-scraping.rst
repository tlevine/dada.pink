Outlining a short course on web scraping...

1. Theatrical performance of a good system for acquiring data with
    and without using computers (about 10 minutes), including

  * distinguishing between receiving (downloading) and reading (parsing)
  * assertion that the process doesn't change much when you
      switch humans for computers
  * discussion of how to develop the computer process iteratively

2. Downloading a web page with python-requests
3. Saving a web page to a file in Python

  * pickle-warehouse (https://pypi.python.org/pypi/pickle-warehouse)
  * File-like objects

4. Loading a web page into lxml, and querying it with css
5. Saving the data as a table. The easiest things would be
    DumpTruck (https://pypi.python.org/pypi/dumptruck) or 
    dataset (https://pypi.python.org/pypi/dataset), but I'd
    rather do this all in Python 3.... We could just save as
    JSON....
6. Equivalent libraries in other languages

  * HTTP clients
  * HTML/XML manipulators
  * Database thingies and other serialization libraries

7. Other good things to know about

  * unidecode
  * pdfs

    * http://thomaslevine.com/!/parsing-pdfs
    * https://www.meetup.com/Data-Wranglers-DC/events/160592492/

  * XPath
  * regular expressions
  * strptime
