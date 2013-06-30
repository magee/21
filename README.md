21
================

Twenty-one was a project I worked on with a partner at Hack Reactor.  The task was to use Coffeescript and Backbone to write a Blackjack game implementing basic rules found here: http://www.blackjackinfo.com/blackjack-rules.php.  We also wrote the unit tests for the application.

The entire interface is created using CSS.  In particular, the suits on the cards are ASCII characters styled to sit in the center of each card.  We also experimented with CSS transforms to add the background image to the cards and to implement their flip behavior.

My contribution:  I coded the application jointly with my partner.  We also wrote the unit tests for it.  In addition, we discussed some of the interface choices -- in particular using transforms for the backs of the cards.  We then styled the application completely using CSS.  I "prettied" is up by adding colors, designing card face attributes and adding flip transform.

To run the game
-----------------------

Copy the game to your local computer by cloning the repository:

    $ git clone https://github.com/magee/21.git

Change to the new 21 directory and open index.html.

Game play
--------------

The goal is to score as close to 21 as possible without going over.  Winner has the closest score among all players.  For more information, visit this site: http://www.blackjackinfo.com/blackjack-rules.php

Player and dealer are each dealt two cards.  Player can only see one up-facing card for the dealer.  Player asks the dealer for a new card by pressing the Hit button.  When he is satisified with his hand, he presses "Stand."  The dealer then deals cards to himself.

When the dealer has completed his own deal, the game ends and the scores evaluated to determine who is the winner.

To play a new game, refresh the browser window.  In Chrome on Mac, press Command-R.

Stack
-----------------------

coffeescript
backbone
jquery
underscore
jasmine


Copyright 2013, [Hack Reactor, LLC](http://hackreactor.com). All rights reserved.
