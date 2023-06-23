# Word Game in Prolog

This project is a word game made with Prolog, as a practice to explore logical programming. The game involves guessing a word based on its category and length. The game is entirely text-based and requires the user to input their guesses and actions.

## Getting Started

To get started with the project, follow these steps:

1. Install SWI-Prolog on your machine.
2. Clone the repository to your local machine.
3. Open the project in your preferred text editor.
4. Run the game by typing `main.` in the Prolog console.

## Predicates

The game includes the following predicates:

### is_category/1

`is_category(C)` succeeds if `C` is an available category in the knowledge base.

Examples:
```
?- is_category(animals).
true.

?- is_category(C).
C=animals;
C=greetings;
C=fruits;
C=collections.
```

### categories/1

`categories(L)` succeeds if `L` is a list containing all the available categories without duplicates.

Examples:
```
?- categories(L).
L=[animals,greetings,fruits,collections].
```

### available_length/1

`available_length(L)` succeeds if there are words in the knowledge base with length `L`.

Examples:
```
?- available_length(5).
true.
```

### pick_word/3

`pick_word(W, L, C)` succeeds if `W` is a word in the knowledge base with length `L` and category `C`.

Examples:
```
?- pick_word(W, 5, animals).
W=horse;
W=panda;
W=bison.
```

### correct_letters/3

`correct_letters(L1, L2, CL)` succeeds if `CL` is a list containing the letters in both `L1` and `L2`.

Examples:
```
?- correct_letters([h,e,l,l,o],[h,o,r,s,e],CL).
CL=[h,o,e].
```

### correct_positions/3

`correct_positions(L1, L2, CP)` succeeds if `CP` is a list containing the letters that occur in both `L1` and `L2` in the same positions.

Examples:
```
?- correct_positions([h,e,l,l,o],[h,o,r,s,e],CP).
CP=[h].
```

### build_kb/0

`build_kb` is responsible for the knowledge base building phase. It reads a file containing words and their categories, length, and letters, and stores them in the knowledge base.

### play/0

`play` is responsible for the game play phase. It selects a word from the knowledge base based on the user's input of category and length and prompts the user to guess the word. It provides feedback on the correctness of the guess and prompts the user to keep guessing until the word is correctly guessed.

### main/0

`main` is the main predicate that will be queried to initiate the knowledge base building phase and then the game play phase.

Find more details in the report pdf
