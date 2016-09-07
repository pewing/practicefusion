What you need to run this:

$ bundle install

$ rake db:migrate

$ rake db:seed

$ ruby ewing_coding_challenge.rb


Then open http://localhost:4567/similar1, http://localhost:4567/similar2,
and http://localhost:4567/similar3 to see the three tests I created

So basically my function will take any number of parameters, and return a json of every doctor that shares the given attribute with the original doctor. If no parameters are given, it will return EVERY parameter. I decided on Sinatra because it's very lightweight and easy to understand, plus it takes no time to set up

If I had more time, I would do a few things differently:

First, more thorough testing.

I wasn't sure if you were looking for just the doctor names, or each doctor object, but that is a very easy change.

Obviously the seed is pretty simple, but I needed something fast because of the time limit.

I'm not satisfied with efficiency for sorting through each similarity, so I'd take a better look at it. This is still querying the database each time, as opposed to loading it all in memory (despite my comment to the contrary)
