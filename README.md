# FirstPresidentialDebate2020
Text Analysis of the earliest youtube comments of the First Presidential Debate of 2020 US elections. Held on Sept 29th.


Downloaded all the comments from https://www.youtube.com/watch?v=Y4HQzeI8F_U : 

Debate date, time: Sept 29, 9:00 PM EDT

6736 comments

Stored in yt_pre_debate_0053sep30.txt

Wrote a script to understand what is up: youtube_comments_trump_biden.R

Top 20 words here are: 
Word | Frequency
------------ | -------------
trump | 2277
biden | 1175
debate | 428
joe | 314
people | 308
’s | 303
will | 302
one | 299
president | 291
can | 237
even | 235
2020 | 212
time | 195
think | 187
moderator | 186
know | 181
america | 178
vote | 176
lol | 171
wallace | 170

![GitHub Logo](/images/mostfrequsedwords.png)



Learning: People care much more about Trump(either in support or in opposition) than Biden(almost twice as much). 


Take a look at the word cloud:

![GitHub Logo](/images/trump_biden_wordcloud.png)



Questions that need answering:
*How many times was “trump2020” or “Trump 2020” commented? 
*How many comments indicate affinity with Trump?
*How many comments indicate resistance against Trump?
*How many comments indicate affinity with Biden?
*How many comments indicate resistance against Biden?



Technical challenges:
*How to isolate each comment in my text file?
*How to perform sentiment analysis on each comment in my file?
*How to do a contains(trump/biden) + sentiment analysis?
