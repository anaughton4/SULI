# Goals for Today
* Create a merge request for new GHOSTS profile.
  * Try re-doing the code with an ssh command that is simple so that it works.
  * Maybe try re-doing it with the triple 0 in the credentials file due to json parsing.
* Start multi-level classification federated learning



# Notes
* Changes I want to try before creating a merge request for GHOSTS profile:
  * Try making the credentials password have 000tterTail and change the engineer password back to the original 0tterTail
    * I want to see if the 00 being parsed out in the json formating is what was creating an issue beforehand.
    * That way we can keep the passwords aligned.
  * Make SSH do something much simpler that will actually work.
  * With whatever time I have left, try making the changes that Nic Blair wants from me.

* Results from changes:
  * Changing the password to have 000 did not work.  Still got an incorrect password.

* Make sure to push everything at end of DAY!!!



# What I did Today
* GHOSTS profile is officially done with basic stuff:
  * rdp works
  * sftp works
  * ssh works
* Will try to add Nic Blairs stuff before creating merge request (mostly because I don't know how to do the merge request again and Nic is out of town).
* Federated learning for 3 classes is done
  * Very good results (yay)
  * Keep in mind that each run gave very different results (high variance).
* Started mutli-classification for all scenarios
  * Much more difficult problem