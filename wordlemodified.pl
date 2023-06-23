%------------------------main-------------------------

main:-
	write('Welcome to Pro-Wordle'),nl,
	write('---------------------'),nl,nl,
	build_kb,
	play.

%------------------------Build------------------------
build_kb:-
	write('Please enter a word and its category on seperate lines:'),nl,
	read(Word),
	((Word\==done,read(Category),assert(word(Word,Category)),build_kb);
	(Word==done,nl,write('Done building the words database...'),nl)).

%------------------------Play-------------------------

play:-
category_choice(C),
length_choice(L),
pick_word(W,L,C),
G is L+1,
play_helper(W,L,G).
%-----------------------------
play_helper(W,L,1):-
	word_choice(Word,L,1),
	((Word==W,write('You Won!'));
	(Word\==W,write('You Lost!'))),!.
play_helper(W,L,G):-
	word_choice(Word,L,G),
	((Word==W,write('You Won!'));
	(Word\==W,
	correct_letters_out(Word,W),
	correct_positions_out(Word,W),
	G1 is G-1,
	write('Remaining Guesses are '),write(G1),nl,
	play_helper(W,L,G1))).

%-------------------------Category--------------------

category_choice(Category):-
	nl,write('The available categories are: '),
	categories(L),
	write(L),nl,
	write('Choose a category:'),nl,
	read(C),
	((is_category(C),Category=C);(\+is_category(C),category_choice_again(Category))).
%-----------------------------	
category_choice_again(Category):-
	write('This category does not exist'),nl,
	write('Choose a category:'),nl,
	read(C),
	((is_category(C),Category=C);(\+is_category(C),category_choice_again(Category))).

%-----------------------------------------------------

is_category(C):-
	word(_,C).

%-----------------------------------------------------

categories(L):-
	setof(Category,is_category(Category),L).

%--------------------------length---------------------

length_choice(Length):-
	nl,write('Choose a length:'),nl,
	read(L),
	((available_length(L),Length=L,G is L+1,write('Game started. You have '),write(G),write(' guesses.'),nl);(\+available_length(L),length_choice_again(Length))).
%-----------------------------
length_choice_again(Length):-
	write('There are no words of this length.'),nl,
	length_choice(Length).

%-----------------------------------------------------

available_length(L):-
	word(W,_),
	atom_length(W,L).

%--------------------Word-----------------------------

word_choice(Word,L,G):-
	nl,write('Enter a word composed of '), write(L),write(' letters:'),nl,
	read(W),
	((atom_length(W,L),Word=W);(\+atom_length(W,L),word_choice_again(Word,L,G))).
%-----------------------------
word_choice_again(Word,L,G):-
	write('Word is not composed of '), write(L),write(' letters. Try again.'),nl,
	write('Remaining Guesses are '),write(G),nl,
	word_choice(Word,L,G).

%-----------------------------------------------------

pick_word(W,L,C):-
	word(W,C),
	atom_length(W,L).

%-------------------Correct_Letters-------------------

correct_letters_out(W2,W):-
	atom_chars(W2,W2List),
	atom_chars(W,WList),
	correct_letters(W2List,WList,CL),
	write('Correct letters are: '),write(CL),nl.
	
%-----------------------------------------------------

remove_first(X,[H|T],[H|T1]):-
	H\==X,
	remove_first(X,T,T1).
remove_first(X,[X|T],T).
%-----------------------------
correct_letters([],_,[]).
correct_letters([H|T],L2,[H|T1]):-	
	member(H,L2),
	remove_first(H,L2,L2new),
	correct_letters(T,L2new,T1).
correct_letters([H|T],L2,CL):-
	\+member(H,L2),
	correct_letters(T,L2,CL).

%-------------------Correct_Positions-----------------

correct_positions_out(W2,W):-
	atom_chars(W2,W2List),
	atom_chars(W,WList),
	correct_positions(W2List,WList,CL),
	write('Correct letters in correct positions are: '),write(CL),nl.
	

%--------------------------------

correct_positions([],_,[]).
correct_positions([H|T],[H|T1],[H|T2]):-
	correct_positions(T,T1,T2).
correct_positions([H|T],[H1|T1],CL):-
	H\==H1,
	correct_positions(T,T1,CL).

%-----------------------------------------------------
