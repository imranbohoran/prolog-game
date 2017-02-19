/* Treasure hunt, by Imran Bohoran. */

/* Dynamically changable facts */
:-dynamic(pickedup/1).
:-dynamic(ticket_bought/1).

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

path('Entrance hall', 'Too shed').
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


