data-table-1.png:
	wget -O data-table-1.png http://www.datakind.org/static/media/uploads/blog/Screen%20Shot%202013-10-31%20at%202.07.37%20PM.png

data-table-2.png:
	wget -O data-table-2.png http://www.datakind.org/static/media/uploads/blog/Screen%20Shot%202013-10-31%20at%202.07.46%20PM.png

data-table-3.png:
	wget -O data-table-3.png http://www.datakind.org/static/media/uploads/blog/Screen%20Shot%202013-10-31%20at%202.07.52%20PM.png

slides.html:
	echo '<style>img, blockquote, pre { width: 75%; margin-bottom: 50%; font-size: 3em; }</style>' > slides.html
	grep -v '^[a-zA-Z(<*-]' index.mdwn | markdown >> slides.html
