# http://openclipart.org/detail/109129/spreadsheet-by-anonymous-109129
spreadsheet.svg:
	wget http://openclipart.org/download/people/Anonymous/spreadsheet.svg

slides.html:
	echo '<style>img, blockquote, pre { width: 75%; margin-bottom: 50%; font-size: 3em; }</style>' > slides.html
	sed 's/^\([a-zA-Z(<*-]\|\[\[\).*/\n<br\/>/' index.mdwn | markdown >> slides.html

