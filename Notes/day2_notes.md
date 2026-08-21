Process for Connecting to Cyber Range:

Steps already completed (Not needed to do again):
* Generate SSH Key.
  * Paste this into terminal "ssh-keygen -f ~/<keyname> -t ed25519" (replace "<keyname> with whatever name you want)
  * Create both a key for igor and for dgx-spark
  * Create a directory called ".ssh" and move both the private and public key into this directory.
* Grab public key info and use it to create an igor-ssh key on the Vault (https://vault.range.nrel.gov/ui/vault/dashboard)
  * Use nrel credentials to sign into the Vault under the LDAP.
  * Click on "igor-ssh/" and then move over to create secret.
  * Enter info here.  Name the key whatever you want.
  * You can now view your key under the "view secrete" tab after you enter your key's name.  You can also create another key under this as well.
* Go to Igor Cyber Range (https://igor.range.nrel.gov)
* Create a reservation utilizing the latest Distro.  Enter a number in the "count" box to be assigned a random node.
  * Under the "reservations" tab, you can create your reservation.
* Select your prefered end-time of the reservation (choose as long as possible ideally) and then hit submit.
* After about 10 minutes, your node will be reserved under your reservation name.  Click on link to phenix UI website to work with node (https://igor.range.nrel.gov/igor/anres/phenix/experiments).


Steps needed to run again each day:
* Open Visual Studio Code
* Press the two arrows in the bottom left corner.
* Press "Connect to Host"
  * Connect to both your node and the port in two separate windows of vsc
    * Port SSH has a password "Ground-Wild-Lettuce!"
* This is where I don't remember what to do next...



Key specific names for my info:
* Key secret on the Vault
  * my_key
* Reservation name:
  * anres
* Node number
  * crn149