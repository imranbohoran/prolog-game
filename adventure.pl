/* Treasure hunt, by Imran Bohoran. */

/* Dynamically changable facts */
:-dynamic(pickedup/1).
:-dynamic(ticket_bought/1).
:-dynamic(current_location/1).
:-dynamic(game_started/1).

/** Facts **/
room('Entrance hall').
room('Tool shed').
room('Dake cave').
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

challange('Dark cave', 'It''s dark in here. Swith on the light').
challange('Challange room', 'Distracted by light, what can you use').
challange('Lego city replica', 'Fill in the blanks "Everything is _____"').
challange('Puzzle room', 'If you find 20 coins in the treasure, and you have 4 friends, how much will each get?').

challange_answer('Dark caev', 'Torch').
challange_answer('Puzzle room', '4').
challange_answer('Lego city replica', 'awsome').

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

pickedup('Nothing').

ticket_bought('no').

current_location('Entrance hall').

game_started(false).

path('Entrance hall', 'Tool shed').
path('Tool shed', 'Entrance hall').
path('Tool shed', 'Dark cave').
path('Dark cave', 'Resting place').
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
	current_location(Place),
	write('You are at the '), write(Place).

look :-
	current_location(Place),
	tab(2), write('You are at the '), write(Place), nl,
	tab(2), write('You can see : '), nl,
	notice_objects_at(Place), nl,
	tab(2), write('You can go to : '), nl,
	where_to_go(Place).


move(Place) :-
	current_location(Here),
	go(Here, Place),
	winner.

move(_) :-
	write('You can''t move that way.').

go(Here, There) :-
	path(Here, There),
	retract(current_location(Here)),
	assert(current_location(There)),
	look.

go(_) :-
	write('You can''t go that way.').


winner :-
	current_location('Treasure room'),
	found_treasure.


notice_objects_at(Place) :-
	things_available(X, Place),
	tab(3),
	write('There is a '), write(X), write(' here.'), nl,
	fail.
notice_objects_at(_).


where_to_go(Place) :-
	path(Place, X),
	tab(3),
	write(X),
	nl.

where_to_go(_).


found_treasure :-
	current_location('Treasure room'),
	tab(2), write('Congratulations, you''ve found the treasure'),nl,
	tab(2), write('Go forth and prospoer!!!').


show_commands :-
	tab(3), 
	write('move(Place). -- Go to a place'),nl,
	tab(3), 
	write('look. -- Look around the current place'),nl,
	tab(3),
	write('hint. -- Get some hints on what to do'),nl,
	tab(3),
	write('take(Object). -- To pick up an object'),nl,
	tab(3),
	write('drop(Object). -- To drop an object'),nl,
	tab(3),
	write('finish. -- Finish the game'),nl.

intro_message :- 
	write('Welcome to a Treasure hunt with a twist'),nl,
  	nl,
  	write('You will enter the treasure hunt by going through the Entrance hall.'),nl,
  	write('And from there, you will navigate to different rooms to find the treasure.'),nl,
  	nl,
  	write('You will type in a set of commands to navigate and perform tasks.'), nl,
  	write('Here are the available commands at your disposal: '),nl,
  	show_commands,
  	nl,nl,
  	write('Enjoy the hunt!!'),nl.

finish :- 
	nl,
	write('You have ended the game.'),
	fail.

start :- start_game.

start_game :- 
	intro_message,
	nl,
	retract(game_started(false)),
	assert(game_started(true)),
	write('You''re entering the Entrance hall'),
	go('Entrance hall').

