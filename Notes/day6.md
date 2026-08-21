
*** EVERYDAY, DO AT BEGINNING:
  git pull "gitlab link"


* The master run is now complete.  Choose build to build a new copy.  Make sure to run delete to get rid of an old copy before you build a new one.
* Openclaw is pretty slow.  Timeout time has been extended to 20 minutes.  May have to be extended indefinitely for larger tasks that take time.
* Putting the model on think=high and reasoning=on makes it take longer, but you get more context from the AI:
  * Think allows it to run more complex tasks, but will generally take longer.
  * Reasoning simply reports what it is doing with each command you give it.  It will explain its reasoning in an easy to read way for humans.
    * Similar to reasoning.md but more readable.



* For a future model to try, we can try AutoEncoders.  This takes only data that is normal and trains the model to reconstruct the data its given and see if it matches the normal versions.  If it runs into a threat, it will have a tough time re-constructing, resulting in a flag.
* The three datasets that we created as synthetic datasets are the following:
  * Normal RIC data.  No anamolies.
  * RIC data with normal and anamolies.
  * EU data with normal and anamoly data.
* All the datapoints should be possible to collect in a real-world scenario (especially the RIC data).


Pushing stuff to the badgers-based-lab:
* git add . (period to push everything)
* git add ('filename') to push a specific file
* git commit -m "message for push"
* git push
  * Finnal commit to push


* Possible fix for nemoclaw involves telling it to build code using its native coding system rather than trying to do everything through javascript.  You would put this in the directive to see if that makes everything run more smoothly.