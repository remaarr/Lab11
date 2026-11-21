% Lab 9 - The Name Game
% The user starts with a set of letters (a, b, c) and can add,
% delete or move letters to build his/her name.
% Run it by typing:  start.
% Type every answer followed by a full stop, e.g.  1.   or   m.

% letter/1 changes while the program runs, so it must be dynamic
:- dynamic letter/1.

% The starting set of letters
letter(a).
letter(b).
letter(c).

% Welcome message, then the menu
start :-
    nl,
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

% Print the menu, read the choice and act on it
menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    choice(Choice).

% 1 - Display the current set of letters
choice(1) :- !,
    display_letters,
    menu.

% 2 - Add a letter (assert adds it as the last clause)
choice(2) :- !,
    write('Enter the letter you want to add:'), nl,
    read(L),
    assert(letter(L)),
    write('The letter has been added.'), nl,
    menu.

% 3 - Add a letter at the top (asserta)
choice(3) :- !,
    write('Enter the letter you want to add at the top:'), nl,
    read(L),
    asserta(letter(L)),
    write('The letter has been added at the top.'), nl,
    menu.

% 4 - Add a letter at the bottom (assertz)
choice(4) :- !,
    write('Enter the letter you want to add at the bottom:'), nl,
    read(L),
    assertz(letter(L)),
    write('The letter has been added at the bottom.'), nl,
    menu.

% 5 - Delete one letter (retract removes the first match)
choice(5) :- !,
    write('Enter the letter you want to delete:'), nl,
    read(L),
    (   retract(letter(L))
    ->  write('The letter has been deleted.')
    ;   write('This letter is not in the set.')
    ),
    nl,
    menu.

% 6 - Delete all letters (retractall always succeeds)
choice(6) :- !,
    retractall(letter(_)),
    write('All letters have been deleted.'), nl,
    menu.

% 7 - Exit
choice(7) :- !,
    write('Goodbye!'), nl.

% Any other input
choice(_) :-
    write('Wrong choice, please enter a number from 1 to 7.'), nl,
    menu.

% Display all letters using a fail loop
display_letters :-
    \+ letter(_), !,
    write('The set is empty.'), nl.
display_letters :-
    write('The current set of letters: '),
    letter(X),
    write(X), write(' '),
    fail.
display_letters :-
    nl.
