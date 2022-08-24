# Lecture 01: The boring stuff

## About this lecture series

This series of lectures offers a brief introduction to Stata. The series consists of 12+1 lectures, including a summary lecture. The structure tries to follow the structure of the book, although there are of course some differences: the main organization principle of the lectures is the logic of Stata, not necessary the logic of the book. After going through the lectures, you will be able to reproduce the results of the first two parts of the book (Data Exploration, and Regression Analysis) in Stata. Moreover, you will hopefully also understand the language of Stata enough to be able to go on in the book, and do the exercises in the second two parts on your own.

Note that in the lectures I use Stata 14, however, all the elements discussed here are compatible forward (and in most cases backward) as well.

This first lecture is boring, but unfortunately unavoidable. I tried to be as brief as possible here.

## Motivation

Building a foundation is boring and its result is invisible since it is covered by the house itself. However, great buildings cannot be built on a weak foundation. So, in this lecture we lay down the necessary foundations in order to be able to build the great walls of Stata. We consider the most important concepts that help us becoming a Stata programmer. This first lecture is boring, but necessary for understanding later building blocks.

## The Stata interface

The Stata interface consists of 6 important elements:
  - At the top, you can find the Menu and the Toolbar that can be used for communicating with Stata (see later).
  - The Output Window is in the middle. All the results are presented here.
  - In the top right corner, the Variable Window can be found that presents the variables of the dataset that is currently in the memory.
  - The Properties Window in the bottom right corner contains some information about the dataset and the variables. 
  - At the bottom, you can find the Command Window that is another tool for communication (also see later).
  - Finally, the window on the left is the Command History Window that contains all the commands you executed before.

The position of the windows can be changed, and some of them can also be removed, or shrunk.

## Communicating with Stata

There are three ways to communicate with Stata:
  - Using the clicking method: you can use the Menu or the Toolbar and their pop-up windows to make Stata do something. This method is useful only at the very beginning, later it should be avoided since it is not reproducible.
  - Using the command window: When you know the very basics of the Stata language, you can type the syntaxes into the command window. Also should be avoided later.
  - Using .do files: A .do file is a collection of commands that can be executed easily. It is the preferred way of communication, since it is reproducible. We will use .do files throughout this series of lectures.

## The .do file

The .do file is a collection of commands; the most efficient way of Stata programming. If you do your analysis in a .do file, it is easy to follow, generalize, and reproduce. The main logic of the .do file is that one line contains one command. 

You can also put comments into your .do file:
  - A star (*) at the beginning of the line makes Stata ignore the whole line and interpret it a comment.
  - You can put three slashes (///) anywhere, and so Stata ignores everything after that.
  - You can also indicate a comment using the slash-star (/*) star-slash (*/) combination, and so Stata ignores everything between them.

The .do file editor can be opened from the Toolbar with the New Do-file Editor button, or by typing doedit into the Command Window. The .do file can be executed by clicking the Execute (do) button or using the Ctrl+D hotkey. The use of .do files is highly recommended to maintain reproducibility and traceability.

##  The general syntax of Stata

All the syntaxes follow the same logic in Stata, as there is a general structure of them, which is the following:

[prefix:] command [varlist] [=exp] [if exp] [in range] [weight] [using filename] [, options]

The command is the hearth of the syntax, it orders Stata to do something, so this is a compulsory element of the syntax. All the other elements are optional for most of the commands, and basically just alter somehow the main output of the command.
  - A prefix (the most important ones are by and bysort, which we are going to discuss in Lecture 5) should be followed by a colon (:), and then comes the command. 
  - varlist defines the variable or variables to which Stata should apply the command.
  - exp is a definition of mathematical or textual relations. Functions and other expressions can be defined here.
  - if defines condition(s). Stata will consider those observations which the condition(s) is (are) true for.
  - in defines a range of observations that should be considered by the command.
  - weight helps us to give different weights to different observations.
  - using refers to filenames we would like to use. 
  - options alter and/or supplement the command. Options should be preceded by a comma (,). In case of using more options, their order is irrelevant.

A detailed description of the Stata language can be read in the User�s Guide, in [Chapter 11](https://www.stata.com/manuals/u11.pdf).

## Stata�s own file extensions

  - .ado file: An .ado file is a text file which defines a Stata command. Do not confuse it with the .do file that is a collection of commands.
  - .dta file: Stata stores datasets in .dta files.
  - .gph file: Stata's interactively editable graphical files.
  - .hlp file: Stata provides a description for all the commands, which are the help files, stored as .hlp.
  - .smcl file: Stata's log files are stored as .smcl files.

## Getting help

There are many ways to get help if you stall. Stata has a great help menu (you can open the help menu of a command typing help and the name of the command, or you can also look for keywords or whole sentences using the search command). Stata also presents error messages and error codes if something goes wrong. You can also find an infinite amount of [documentation](https://www.stata.com/features/documentation/) and other [resources](https://www.stata.com/links/) on Stata's website, and the official [Youtube](https://www.youtube.com/user/statacorp) page of Stata is also really helpful.