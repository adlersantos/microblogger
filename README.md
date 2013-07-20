JumpstartLab MicroBlogger
=========================

In this multi-phase project, I built a client that interacts with the Twitter messaging service. The client both mimics functionality found through the Twitter web interface, but only done through the command line.

The instructions for this project is given at <a>http://tutorials.jumpstartlab.com/projects/microblogger.html</a>.

To start the program, simply run the ```micro_blogger.rb``` on the command line (requires the ```jumpstart_auth``` and ```bitly``` gems):

```
$ ruby path_to_microblogger/microblogger.rb
```

Upon first run, you will need to login to your Twitter account and use the 10-digit pin that will be given to you.

The list of available commands are as follows:

- ```t (message)``` - posts the message as a tweet 
- ```dm (username) (message)``` - send a direct message to a Twitter account via its username
- ```elt``` - outputs a list of all the tweets of all the users you are following
- ```spam (message)``` - sends the message as a direct message to all your followers (LOL)
- ```turl (message) (URL)``` - tweet with a URL that will be shortened via bit.ly
- ```q``` - quits the program