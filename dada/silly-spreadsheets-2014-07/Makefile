# http://openclipart.org/detail/109129/spreadsheet-by-anonymous-109129
spreadsheet.svg:
	wget http://openclipart.org/download/people/Anonymous/spreadsheet.svg

slides.mdwn:
	echo '<style>img, blockquote, pre { width: 75%; margin-bottom: 50%; font-size: 3em; }</style>' > slides.mdwn
	sed 's/^\([a-zA-Z(<*-]\|\[\[\).*/\n<br\/>/' index.mdwn >> slides.mdwn

slides.html:
	markdown slides.mdwn > slides.html


nicole.jpg:
	wget -O nicole.jpg https://pbs.twimg.com/profile_images/3109685140/4d01018916293ef57c2233df71855a87_bigger.jpeg

noel.jpg:
	wget -O noel.jpg http://farm2.static.flickr.com/1047/799125271_97a7d5fab2.jpg

chris.jpg:
	wget -O chris.jpg http://chrismetcalf.net/images/bio-photo.jpg

tim.jpg:
	wget -O tim.jpg http://timwis.com/images/backgrounds/me.jpg
