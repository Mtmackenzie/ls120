**What is OOP and why is it important?**
Object oriented programming is a paradigm for dealing with the complexity of large programs. One problem with a large program is that one small change can affect the whole program. OOP deals with this by encapsulating code and reducing dependencies between different parts of code, so that changes in one part of the program won't break the program somewhere else. The other problem with a large program is repetitive code: OOP uses polymorphism to reduce the amount of repetitive code in a program. Encapsulation is achieved through the use of objects, classes, and a variety of variables and methods that are encapsulated through their different levels of scope, and the ability to make methods public, protected, or private, depending on if/how you want objects to interact with those methods, and how much of the program you want to be available to the user through the public interface.

**What is a spike?**
A spike is a rough draft of the program that involves writing a description of the program, then pulling out the nouns/verbs and deciding how they will interact with each other in a program by making a rough skeleton of where each noun and verb should go logically, without actually writing any implementation code. Nothing is set in stone; the programmer begins to see what the main problems are and how to break them down into solvable pieces of code.

**When writing a program, what is a sign that you’re missing a class?**
Repetitive nouns in method names indicate that maybe it would be a good idea to move those methods and that logic into its own class, to both DRY up the code and encapsulate it to protect it from unwanted changes.

**What are some rules/guidelines when writing programs in OOP?**
Explore the problem with a spike, make instance or class method names without including the class in the name (for example, `Player#player_move` should just be `Player#move`), move logic into its own class if the nouns in method names become repetitive, avoid long method chaining to avoid unexpected return values somewhere in the chain because this is hard to debug, and don't worry yet about optimization.
