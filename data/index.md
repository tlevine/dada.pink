# What is data, and what is a data scientist?
Data science is a very new field that we are still figuring out how to
talk about. As such, it has taken a little while for us to make sense of
all of the. Having worked in data science for a few years, I finally think
I have a good understanding of the field, and I present for you my definitions
of the following terms

* data
* big data
* data science
* data scientist
* data visualization developer
* data visualization engineer
* software engineer (in the context of data science)
* data engineer

## The field of data
"Big data", "data science", and plain "data" all allude to a recent phenomenon
related to a decrease in the cost of computers. As computation and digital
storage gets cheaper, we can more whimsically put insane amounts of computing
power towards studies of how the world works.

The various practices of the contemporary data field stem from this happening.

### Store everything
Storage is cheap, so you should store everything that is easy to collect.
In data science, we instinctively store data in the most raw form that is
convenient, and don't worry very much about how or even whether we're going
to analyze it. One of the aspects of data science is the collection and
management of huge quantitaties of data, before we even consider really
looking at it.

### Anything can be quantified
Everything can be turned into a number, and computers can compute numbers
much more cheaply than humans can. After we have quantified things, we can
process them with our powerful and cheap computers In data science, we look
for numbers in everything, because we need to turn stuff into numbers in
order for our computers to process them.

### Boring work should be sent to robots
Within the context of data analysis, there are some much more practical reasons
for this. A typical boring task might be drawing a new graph every time some
dataset is updated. A robot will do this with substantially more
consistency/accuracy and for a substantially lower cost.

So here are some mindsets that follow from the aforementioned data science mindset.

* Data collection should be automatic and unobtrusive; questionnaires and lab
    studies are too much work.
* I don't need a full-fleged research plan before you start collecting data;
    I'll record everything that is convenient, and I'll store it in the most raw form.
* All analyses should be scripted.

To say this more explosively, I value laziness.

### Focus on connecting datasets rather than on tuning models
In a conventional statistics class, you'll learn a lot about how to choose
analysis methods that are appropriate for your data collection approach and how
to tune the models for a specific dataset. That way of thinking is not new.

Here's the new thing. Now that we have hoards of inexpensive data, it's not
worth worrying so much about making the best use out of one dataset; it's better
to use a range of datasets, and especially to connect one dataset to lots of
other datasets. To use machine learning speak, you should focus more on collecting
features rather than on tuning your model.

Relating this to the earlier point that you should store everything, here are
some of my mindsets that follow from the original mindset.

* When I'm asked a question about the world, I adapt the question so that it can
    be approximately answered with an existing and convenient dataset.
* I look for opportunities to use existing stores of data in unintended ways.

## Tools
Since I have the aforementioned mindset and the consequential mindsets, I wind
up learning a bunch of tools that align with that mindset. For example, I know
how to collect lots of data continuously, how to store it, how to get it out of
storage, how to have a computer analyze datasets that I can't fit in my head,
how to convert paper documents into data tables, how to get the computer to tell
me something that I and other people understand, and how to make all of this run
fast enough that I don't get tired of waiting.

Properly discussing these relevant tools would take a while, but here's a small
thought: You don't need to know much math to do data science. Loads of wonderful
algorithms have already been implemented for you, and simple algorithms work quite
well. The more important tools are "plumbing" that connects different datasets and systems.





## Skills
Two defining components of data science are quantitative abilities and
an interest or ability to do research. Before we discuss the different
sorts of people who work in data science, we need to discuss these key
skills.

### Quanitative abilities
Data science is big on quantitative skills, and people who work in data science
are classified based on their quantitative skills.
A person is considered to have strong quantitative skills if most he or she
meets most of the following criteria.

* He or she presents believes that her work is very sophisticated or
  complicated.
* He is male, or she conducts herself very masculinely.
* He or she presents her work in ways that are difficult for most
  people to understand.

### Research

## People in data
Now that I have discussed the general field of data, I can tell you
about the different sorts of people that we find within the field.

### Data scientists
The main personification of the field of data science is the data scientist.

Data scientists are people who want to feel like they are conducting
novel research (by their own definitions of "research"), were unable
to get jobs in academia, managed to find work in the field of data,
and are considered to posess strong quantitative skills.

The specific work that they do is quite varied, but it usually gets
packaged as the creation of new knowledge, rather than as the creation
of new software.

### Data visualization developer
A data visualization developer is person who meets all of the
above criteria for being a data scientist except that he or she is
thought to lack the quantitative skills necessary for data scientist. That is,

* He or she is female.
* He or she presents her work in ways that broad audiences can understand it.
* He or she is less concerned about the sophistication/complexity of her work
  than a data scientist would be.

A data visualization developer packages his or her work as novel research,
just like a data scientist, but the work usually gets distributed to a wide
and distant audience. For example, while a data scientist would report his
findings to a small committee within a company, a data visualization developer
would report her findings to the public at large.

### Software engineers
Software engineers are people who work in data and have strong quantitative
skills but did not previously consider work in academia or do not feel the
need to conduct novel research.

### Data engineers
An additional *data engineer* role is sometimes present. It describes
someone that is between a software engineer and a data scientist.

A data engineer is usually the same as a software engineer, but with
different branding. The name "software engineer" alludes to a time before
the recent interest in data, and the name "data engineer" alludes to recent
times. Data engineers are often younger than software engineers and tend to
conduct themselves less conservatively than data engineers. Software
engineers bring wisdom from a earlier times, and data engineers bring
youthful creativity and aspirations.

Data engineer are sometimes more like data scientists, however.
This is most likely to happen if the data scientist had previously
aspired to work in
computer science, or another field with "computer" in the name. If the
person previously sought out academic work in ecology, for example,
he or she is most likely to be considered a data scientist.

If a company has both software engineers and data engineers, then the
data engineers usually develop tools for data scientists or data analysts,
based on data generated by the core product, and the software engineers
focus on developing the core product.

### Data visualization engineer
A data visualization engineer is person who meets all of the
criteria for being a software/data engineer except that he or she is
thought to lack the quantitative skills necessary for data scientist.
In contrast to the software/data engineer,

* He or she is female.
  designs software for people
  mostly male
* He or she presents her work in ways that broad audiences can understand it.
* He or she is less concerned about the sophistication/complexity of her work
  than a data scientist would be.

## The future
The trend towards more data will continue, and the field of data will
thus be around in some form for a reasonably long time. The people in this
field, on the other hand, may change somewhat as data science becomes
established as a formal academic discipline. People who work as data
scientists really want to work as academic researchers. When data science
becomes a formal academic discipline and data scientists finally find
jobs as academics, we might have to come up with a new name for the people
who want to be academics but can't find work.
