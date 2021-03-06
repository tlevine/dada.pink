# What is data, and what is a data scientist?
You may have heard something about data science. You may have even heard
that Tom is a data scientist. Perhaps you are wondering what data science is.
Unfortunately, it is hard to get a clear answer.

**Data science is chaotic.**
Data science is a very new field, and different people have their own ideas
about what data science should be. Also, data science is a very hot field, so
people often rebrand their existing work as being data science.

**But it also has order!**
Even with all this chaos, it turns out that there is some consistency in
the data science terminology. I have worked in data science for a few years
in multiple organizations. I have met data scientists from several countries
and have read even more of their work on the internet. Everyone has his or her
on idea as to what data science is, but some clear trends emerge.

## Things I discuss in this article
Based on the patterns I have seen, I have come up with definitions of the
following terms.

* data
* big data
* data science
* data scientist
* data visualization developer
* data visualization engineer
* software engineer (in the context of data science)
* data engineer
* big data engineer

I seek to produce descriptive definitions of these terms, rather than
prescriptive definitions. I am trying to come up with a "common denominator"
definition that matches most of the different definitions that I have seen.
If you use these terms differently, your usage is perfectly acceptable, and
my definitions are incomplete.

After defining these terms, which are mostly roles within an organization,
I will discuss how people move between roles.

I'll end with a thought on how data science is going to change in the future.

## The field of data
As computation and digital storage gets cheaper, we can more whimsically put
insane amounts of computing power towards studies of how the world works.
The various practices of the contemporary data field stem from this happening.

"Big data", "data science", and plain "data" all refer to the practice of
putting using this insane degree of computing power to study stuff. These terms
in fact mean different things to different people, but they consistently allude
to this recent perspective on research that stems from a decrease in the cost
of computers.

The various practices/values within the data field all follow naturally from
this defining feature. I discuss some of these practices/values below.

### Store everything
Storage is cheap, so aim to store everything that is easy to collect.
In data science, we instinctively store data in the most raw form that is
convenient, and don't worry very much about how or even whether we're going
to analyze it. One of the aspects of data science is the collection and
management of huge quantities of data, before we even consider really
looking at it.

### Anything can be quantified
Everything can be turned into a number, and computers can compute numbers
much more cheaply than humans can. In data science, we look
for numbers in everything, because we need to turn stuff into numbers in
order for our computers to process them.

### Repetitive tasks should be automated
Data science is all about replacing expensive human thought with inexpensive
computers. In data science, we make the following sorts of decisions.

* Data collection should be automatic and unobtrusive; questionnaires and lab
    studies are too much work.
* Collect any data that might be useful later or that are just easy to collect.
    Don't wait until you have a full-fledged research plan.
* All analyses should be scripted.

### Focus on connecting datasets rather than on tuning models
In a conventional statistics class, you'll learn a lot about how to choose
analysis methods that are appropriate for your data collection approach and how
to tune the models for a specific dataset. That way of thinking is not new.

Here's the new thing. Now that we have hoards of inexpensive data, it's not
worth worrying so much about making the best use out of one dataset; it's better
to use a range of datasets, and especially to connect one dataset to lots of
other datasets. To use machine learning speak, you should focus more on collecting
features rather than on tuning your model.

## Rhetoric
Two defining components of data science are quantitative abilities and
an interest or ability to do research. Before we discuss the different
sorts of people who work in data science, we need to discuss these key
skills.

### Research
We often talk about "research" in data science. The meaning of "research"
in this context is very similar to academic research. The definitions I found
in the "[research](https://en.wikipedia.org/wiki/Research)" article on
Wikipedia seem pretty good.

> Research comprises "creative work undertaken on a systematic basis in order
> to increase the stock of knowledge, including knowledge of humans, culture
> and society, and the use of this stock of knowledge to devise new
> applications."

In data science, research is implicitly *scientific* research.

> Scientific research is a systematic way of gathering data and harnessing
> curiosity. This research provides scientific information and theories for the
> explanation of the nature and the properties of the world. It makes practical
> applications possible.

In data science we are usually concerned with addressing very specific issues,
such as the specific practices of a particular company, rather than making
general conclusions about the world at large, so we do not need the same degree
as rigor as we would in an academic setting; we aim instead for speed and
cost-effectiveness in our research.

<h3 id="quantitative-abilities">Quantitative abilities</h3>
In data science, we talk a lot about quantitative skills. The idealized
data science work is thought to involve lots of math. We thus use phrases
like "quantitative ability" or "analysis skills" to talk about a person's
social status within the context of data science.

Within the context of data science, people with higher social status are
considered to have higher quantitative ability. ("Quantitative ability"
might have a different meaning in other fields.)

Within the context of data science, a person is considered to have high
quantitative abilities if he or she meets most of the following criteria.

* He is male, or she conducts herself very masculinely.
* He or she has a masters or doctoral degree in a science, technology,
  engineering, or math (STEM) field
* She believes that her work is very sophisticated or complicated.
* He or she presents her work to people of high social class.

To be clear, anyone who is working in the field of data needs to have some
understanding of numbers in order to be useful, and that is *not* what people
are talking about when they discuss "quantitative ability";
"quantitative ability" is the data science jargon for social class.

## People in data
Now that I have discussed the general field of data, I can tell you
about the different sorts of people that we find within the field.

<h3 id="data-scientists">Data scientists</h3>
The main personification of the field of data science is the data scientist.

Data scientists are people who want to feel like they are conducting
novel research, failed to find work in academia, managed to find work
in the data field, and are of high quantitative ability (social class).

The specific work that they do is quite varied, but it usually gets
packaged as the creation of new knowledge, rather than as the creation
of new software. They present their work to small groups of high-class
people, such as managers or executives within a company.

### Data visualization developer
A data visualization developer is person who meets all of the
above criteria for being a data scientist except that he or she is
of lower social class. That is,

* He or she is female.
* He or she presents her work in ways that broad audiences can understand it.
* He or she is less concerned about the sophistication/complexity of her work
  than a data scientist would be.

A data visualization developer may package his or her work as novel research,
similar to the data scientist, except that his or her work considered to be
of a lower grade (less classy or less quantitative) than that of the data
scientist. His or her work usually gets distributed to people of lower social
class, such as the public at large. He or she must work with a data scientist
if his or her work is to be distributed to a group of high social status.

### Software engineers
Software engineers are people who work in data and have strong quantitative
skills but did not previously consider work in academia or do not feel the
need to conduct novel research. They may have a range of social classes
(quantitative abilities).

### Data engineers and big data engineers
A *data engineer* or *big data engineer* role is someone who writes software
to support the data scientists' work.

If a company has both software engineers and data engineers, then the
(big) data engineers usually develop tools for data scientists or data analysts,
and the software engineers focus on developing the core product.

The term "data engineer" is more common in small companies, and the term
"big data engineer" is more common in large companies.

### Data visualization engineer
An additional *data visualization engineer* role is sometimes present.
A data visualization engineer is a software engineer who focuses on the
creation of graphs (plots) as a feature of a data analysis software
product. That is, the graph itself is a core part of the product.

### Other terms
I have focused on the terms for people who work closely in the data aspects
of the data field. Roles that are present in other fields, such as
salesperson or executive, don't have special definitions within the context
of data.

I have left out any discussion of "designers" in the above discussion. In at
least some cases, designers in the field of data are like designers outside
of the field of data, but it may be that they have a special place in data.

## Advancing to a higher-class role
One advances to a higher-class role by becoming closer to people of that
role. The means of advance can be broken into two components.

1. Become more quantitative, as discussed in the section on
    [quantitative skills](#quantitative-abilities)
2. Make friends with people in the higher social class.

The highest class is the data scientist, so people usually want to become
closer to that. For example, if you are a software engineer and you want to
advance, your next step is to become a (big) data engineer.

### Advancing in quantitative ability
Depending on where
you're starting from in terms of quantitative skills, you may need to do some
of the following.

* Conduct yourself more [masculinely](https://en.wikipedia.org/wiki/Masculinity).
* Get a degree in a field that is more "quantitative".
* Take a corporate training in data science.
* Convince yourself that the work you do is more sophisticated.
* Present your work to people of higher class.

### Associating with higher class people
In order to advance within the data field, you must associate with higher-class
people. These higher-class people could be data scientists (the highest class
within the field of data) or other high-class people, such as business
executives, politicians, or rich people.

In the case of a software engineer becoming a data engineer, a good route is 
to associate with data engineers or data scientists. Here are some common ways
to do that.

* Take a corporate training in data science.
* Write about data science on the internet.
* Speak at a data conference.

Advance along these two components happens in small steps. For example, as you
conduct yourself more masculinely or get further training, you become more
comfortable with the idea of associating with data scientists. Similarly, as
you associate with more data scientists, you become more convinced that your
work is very sophisticated.

## Data science trainings
Prominent data scientists (like me?) usually give a lot of introductory
data science trainings, and I get the sense that this makes up a substantial
chunk of their income.

I'm slightly different from the type that I put forth above. I give trainings,
but they serve more as marketing; after seeing one of my trainings or reading
one of my tutorials, people sometimes contact me about consulting work of
various sorts.

Perhaps it's obvious, but the audience for such trainings is lower-class
people who want to advance towards the high-class data science role. These
could be lower-class data professionals, university students, or non-data
professionals who want to move into data.

It's a bit odd that such introductory trainings are given by such knowledgable
data scientists. Aren't they too busy doing data science themselves? Why can't
less knowledgeable data scientists give these trainings? I see a few reasons.

1. It turns out that trainings by less prominent data scientists are starting
    to happen, as several data science bootcamps are springing up.
2. While people want to be [data scientists](#data-scientists), there isn't
    much business demand for them. Thus, it's cheap and easy to hire the most
    prominent ones.
3. The main purpose of the training is to associate students with the
    high-class instructor; the learning is secondary.
4. If you are coming from a completely different field, it's hard to
    distinguish real stuff from complete hogwash. In such a case, taking a
    course from a very prominent and well respected instructor is a decent idea.

## The future
The trend towards more data will continue, and the field of data will
thus be around in some form for a reasonably long time. The people in this
field, on the other hand, may change somewhat as data science becomes
established as a formal academic discipline. People who work as data
scientists really want to work as academic researchers. When data science
becomes a formal academic discipline and data scientists finally find
jobs as academics, we might have to come up with a new name for the people
who want to be academics but can't find work.

Also, I imagine that these dynamics within data science exist in other hot
fields, so we can probably forsee the changes in data science by looking at
patterns in other fields.

## See also

* [Social Class in the United States](https://en.wikipedia.org/wiki/Social_class_in_the_United_States),
    by Wikipedia Contributors.
* [The 3-ladder system of social class in the U.S.](https://michaelochurch.wordpress.com/2012/09/09/the-3-ladder-system-of-social-class-in-the-u-s/),
    by Michael O Church. I have no idea how Michael comes up with stuff like
    this, but it always sounds so right.
