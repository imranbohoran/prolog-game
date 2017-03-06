/* Treasure hunt, by Imran Bohoran. */

/* Dynamically changable facts */
:-dynamic(pickedup/1).
:-dynamic(ticket_bought/1).
:-dynamic(current_location/1).
:-dynamic(game_started/1).
:-dynamic(in_the_bag/1).
:-dynamic(completed_challange_for/1).

/** Facts **/
room('Entrance hall').
room('Tool shed').
room('Dark cave').
room('Secret passage').
room('Resting place').
room('Challange room').
room('Lego city replica').
room('Puzzle room').
room('Treasure room').

things_available('Ticket counter', 'Entrance hall').
things_available('Ladder', 'Tool shed').
things_available('Torch', 'Dark cave').
things_available('Rope', 'Tool shed').
things_available('Apple', 'Resting place').
things_available('Carrots', 'Resting place').
things_available('Water', 'Resting place').
things_available('Pear', 'Resting place').
things_available('Grapes', 'Resting place').
things_available('Dragon', 'Challange room') .
things_available('Lego people', 'Lego city replica').
things_available('Lego houses', 'Lego city replica').
things_available('Lego cars', 'Lego city replica').
things_available('Lego trees', 'Lego city replica').
things_available('Treasure room', 'Treasure Treasure Treasure').

challange('Entrance hall', 'CHALLANGE: You can''t leave this place without something: ''Buy or not-buy, that is the question''').
challange('Dark cave', 'CHALLANGE: It''s dark in here. What will you use?').
challange('Challange room', 'CHALLANGE: You can swing past the dragon, what can you use?').
challange('Lego city replica', 'CHALLANGE: Fill in the blanks "Everything is _____"').
challange('Puzzle room', 'CHALLANGE: If you find 20 coins in the treasure, and you have 4 friends, how much will each get?').

challange_answer('Entrance hall', 'Ticket').
challange_answer('Dark cave', 'Torch').
challange_answer('Challange room', 'Rope').
challange_answer('Puzzle room', '5').
challange_answer('Lego city replica', 'awsome').

challange_requirements('Entrance hall', 'Money').
challange_requirements('Dark cave', 'Torch').
challange_requirements('Challange room', 'Rope').
challange_requirements('Puzzle room', 'Money').
challange_requirements('Lego city replica', 'Money').

challange_hit('Entrance hall', 'You might have to ''Buy'' something. Look around, what can you buy?').
challange_hit('Dark cave', 'Oh darkness, what can rid that. Look around what you could find that you can pickup.').
challange_hit('Challange room', 'Was there something in the tool shed that you might or might not have picked up?').
challange_hit('Puzzle room', 'Sharing is caring, and you should do it equally.').
challange_hit('Lego city replica', 'What''s that song they always play?').

completed_challange_for().

can_pickup('Ladder').
can_pickup('Torch').
can_pickup('Rope').
can_pickup('Water').

food_not_allowed('Apple').
food_not_allowed('Carrots').
food_not_allowed('Pear').
food_not_allowed('Grapes').

edible('Apple').
edible('Carrots').
edible('Pear').
edible('Grapes').

drinkable('Water').

ticket_bought('no').

current_location('Entrance hall').
in_the_bag('Money').

game_started(false).

treasure_in('Treasure room').

path('Entrance hall', 'Tool shed').
path('Tool shed', 'Entrance hall').
path('Tool shed', 'Dark cave').
path('Dark cave', 'Resting place').
path('Dark cave', 'Tool shed').
path('Resting place', 'Dark cave').
path('Resting place', 'Secret passage').
path('Secret passage', 'Resting place').
path('Secret passage', 'Lego city replica').
path('Lego city replica', 'Secret passage').
path('Lego city replica', 'Challange room').
path('Resting place', 'Challange room').
path('Challange room', 'Resting place').
path('Challange room', 'Puzzle room').
path('Puzzle room', 'Challange room').
path('Puzzle room', 'Treasure room').

where_am_i :-
	write('||------------------------------------------------------'),nl,
	current_location(Place),
	write('||'), tab(2),write('>> You are at the : '), write(Place),nl,
	write('||------------------------------------------------------').


look :-
	current_location(Place),
	write('||------------------------------------------------------'),nl,
	write('||'),tab(2), write('>> You are at the '), write(Place), nl,
	write('||'),tab(2), write('>> You can see : '), nl,
	notice_objects_at(Place), nl,
	write('||'),tab(2), write('>> You can go to : '), nl,
	where_to_go(Place),
	write('||------------------------------------------------------').

path_unchallanged('Tool shed', 'Entrance hall').
path_unchallanged('Tool shed', 'Dark cave').
path_unchallanged('Dark cave', 'Tool shed').
path_unchallanged('Resting place', 'Secret passage').
path_unchallanged('Resting place', 'Dark cave').
path_unchallanged('Secret passage', 'Resting place').
path_unchallanged('Secret passage', 'Lego city replica').
path_unchallanged('Lego city replica', 'Secret passage').
path_unchallanged('Resting place', 'Challange room').
path_unchallanged('Challange room', 'Resting place').
path_unchallanged('Puzzle room', 'Challange room').


challange_completed(Place) :-
	completed_challange_for(Place),nl.

challange_completed(_) :- 
	current_location(Here),
	show_leave_challange(Here),
	fail.

show_leave_challange(Place) :-
	challange(Place, X),
	write('||------------------------------------------------------'),nl,
	write('||'), tab(2), write(X),nl,
	write('||'), tab(2), write('Use command: answer(''the answer'' to answer the challange.'),nl,
	write('||------------------------------------------------------').


answer(Answer) :-
	current_location(Here),
	challange_requirements(Here, Thing),
	thing_in_bag(Thing),
	challange_answer(Here, Answer),
	assert(completed_challange_for(Here)),
	write('||------------------------------------------------------'),nl,
	write('|| That is the correct answer. Now try moving again.'),nl,
	write('||------------------------------------------------------').

answer(_) :-
	write('||------------------------------------------------------'),nl,
	write('|| ERROR: Wrong answer buddy. Try again'),nl,
	write('||------------------------------------------------------'),
	fail.

move(Place) :-
	current_location(Here),
	path_unchallanged(Here, Place),
	go(Here, Place),
	winner(Place).

move(Place) :-
	current_location(Here),
	challange_completed(Here),
	go(Here, Place),
	winner(Place).

move(_) :-
	current_location(Here),
	write('||'),nl,
	write('|| ERROR: Move failed from '), write(Here),nl,
	write('||').


go(Here, There) :-
	path(Here, There),
	retract(current_location(Here)),
	assert(current_location(There)),
	look.

go(_) :-
	write('You can''t go that way.').


winner(Place) :-
	current_location(Place),
	found_treasure(Place).

winner(_) :-
	nl, write('||'), nl,
	write('|| Treasure yet to be found').

notice_objects_at(Place) :-
	things_available(X, Place),
	write('||'),tab(3),
	write('* '), write(X), write(' here.'), nl,
	fail.

notice_objects_at(_).


where_to_go(Place) :-
	path(Place, X),
	write('||'),tab(3),
	write('->'),write(X),nl,
	fail.

where_to_go(_).


take(Thing) :-
	write('||------------------------------------------------------'),nl,
	allowed_to_take(Thing),
	take_thing(Thing),
	write('||------------------------------------------------------').

allowed_to_take(Thing) :-
	current_location(Place),
	things_available(Thing, Place).
allowed_to_take(Thing) :-
	nl, write('|| ERROR: There is no '), write(Thing), write(' here'),nl,
	fail.

take_thing(Thing) :-
	write('|| You''re taking : '), write(Thing), write('...'),nl,
	asserta(in_the_bag(Thing)),
	write('|| Take over complete'), nl.

drop(Thing) :-
	write('||------------------------------------------------------'),nl,
	allowed_to_drop(Thing),
	drop_thing(Thing),
	write('||------------------------------------------------------').

allowed_to_drop(Thing) :-
	write('|| Checking if you have '), write(Thing), nl,
	in_the_bag(Thing).

can_drop(Thing) :-
	write('|| You don''t have '), write(Thing), write(', to drop it'), nl,
	fail.

drop_thing(Thing) :- 
	write('|| You''re dropping '), write(Thing), nl,
	retract(in_the_bag(Thing)),
	write('|| Drop done'),nl.

what_i_have :- 
	write('||------------------------------------------------------'),nl,
	write('|| You have : '), nl,
	list_bagged_things,
	write('||------------------------------------------------------'),nl,
	fail.

what_i_have.

things_to_pickup(Here) :-
	things_available(Thing, Here),
	can_pickup(Thing),
	write('||'),tab(2), write(Thing),nl,
	fail.

things_to_pickup(_) :-
	fail.

what_can_i_take :-
	current_location(Here),
	write('||------------------------------------------------------'),nl,
	write('|| You can pickup'),nl,
	things_to_pickup(Here),
	write('||------------------------------------------------------'),nl.
what_can_i_take.

list_bagged_things :-
	in_the_bag(X),
	write('||'), tab(2), write(X),nl,
	fail.
list_bagged_things.

thing_in_bag(Thing) :-
	in_the_bag(Thing).

thing_in_bag(_) :-
	fail.


found_treasure(Place) :-
	treasure_in(Place),nl,
	write('||*****************************************************'),nl,
	write('||'), tab(2), write('Congratulations, you''ve found the treasure !!!!!!'),nl,
	write('||'), tab(2), write('Go forth and prospoer!!!'),nl,
	write('||*****************************************************').


show_commands :-
	write('||'),
	tab(3), 
	write('move(Place). -- Go to a place'),nl,
	write('||'),
	tab(3), 
	write('look. -- Look around the current place'),nl,
	write('||'),
	tab(3),
	write('where_am_i. - Find out where you are'),nl,
	write('||'),
	tab(3),
	write('hint. -- Get some hints on what to do'),nl,
	write('||'),
	tab(3),
	write('take(Object). -- To pick up an object and put it in the bag'),nl,
	write('||'),
	tab(3),
	write('drop(Object). -- To drop an object from your bag'),nl,
	write('||'),
	tab(3),
	write('what_i_have. -- To list out what you have bagged already'),nl,
	write('||'),
	tab(3),
	write('what_can_i_take. -- To list out what you can take from the current location'),nl,
	write('||'),
	tab(3),
	write('answer(''the answer''). -- When you see a CHALLANGE, then answer the challage with this command'),nl,
	write('||'),
	tab(3),
	write('help. -- See the available commands'),nl,
	write('||'),
	tab(3),
	write('finish. -- Finish the game'),nl.

intro_message :- 
	write('||------------------------------------------------------'),nl,
	write('|| Welcome to a Treasure hunt with a twist'),nl,write('||'),nl,
  	write('|| You will enter the treasure hunt by going through the Entrance hall.'),nl,
  	write('|| And from there, you will navigate to different rooms to find the treasure.'),nl,write('||'),nl,
  	write('|| You will type in a set of commands to navigate and perform tasks.'), nl,
  	write('|| Here are the available commands at your disposal: '),nl,write('||'),nl,
  	show_commands,
  	write('||'),nl,
  	write('|| Enjoy the hunt!!'),nl,
	write('||------------------------------------------------------'),nl.

finish :- 
	nl,
	write('You have ended the game.'),
	fail.

help :-
	write('||------------------------------------------------------'),nl,
	write('||'),nl,
	write('|| Following are the commands you could use to find your treasure...'),nl,
	show_commands,
	write('||------------------------------------------------------').

hint :-
	current_location(Here),
	challange_hit(Here, TheHint),
	write('||------------------------------------------------------'),nl,
	write('||'), write(TheHint),nl,
	write('||------------------------------------------------------').

start :- start_game.

initialise_game :- 
	ticket_bought('no'),
	current_location('Entrance hall'),
	in_the_bag('Money'),
	retract(game_started(false)),
	assert(game_started(true)),
	asserta(completed_challange_for('Tool shed')),
	asserta(completed_challange_for('Secret passage')),
	asserta(completed_challange_for('Resting place')),
	asserta(completed_challange_for('Treasure room')).

start_game :- 
	intro_message,
	nl,
	write('>> You''re entering the Entrance hall'),
	initialise_game,nl,
	write('>> You are now at the Entrance hall').

