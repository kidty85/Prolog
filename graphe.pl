lire :- consult('test.pl').

ecrire :- tell('resultat.dot'),
	writeln('graph G'),
	writeln('{'),
	parcourGraphe(Liste),
	dessinerRelation(Liste),
	writeln('}'),		
	told.						

parcourGraphe(Liste) :- findall(T,sommet([_,[T|_]]),Liste),
			ecrireSommets(Liste).
			
ecrireSommets([]):- nl.
ecrireSommets([X|L]):- write('	'),write(X),write(';'),nl,ecrireSommets(L).

dessinerRelation([]).
dessinerRelation(H) :- parcourLiaison([H]).
dessinerRelation([H|T]) :- parcourLiaison([H]),
						dessinerRelation(T).
parcourLiaison([]). 						
parcourLiaison([H]) :- 	listeAdjacent(H,L),
			 			ecrireLiaison(H,L).
			 			
ecrireLiaison(_,[]):- nl.
ecrireLiaison(H,[X|Xs]):- write('	'),write(H), write('   --   '),
			write(X),write(';'),nl,ecrireLiaison(H,Xs).
			
listeSommet(Liste) :- findall(T,sommet([_,[T|_]]),Liste).

listeMotif(Liste) :- setof(Motif,Sommet^appartient(Motif,Sommet),Liste),!.

sommetAdjacent(Sommet,Successeurs) :- sommet([_,[Sommet|Successeurs]]),!.

listeAdjacent(Sommets,LA) :- setof(S,Sommets^liaison(Sommets,S),LA),!.

liaison(X,N) :- sommetAdjacent(X,L), member(N,L).


appartient(Motif,Sommet) :- sommet([X,[Sommet|_]]),
			member(Motif,X).

chercherMotif([A],S) :- appartient(A,S).
chercherMotif(A,[S]) :- appartient(A,S).
chercherMotif([H|T],S) :- appartient(H,S), chercherMotif(T,S).
chercherMotif(S,[H|T]) :- appartient(S,H), chercherMotif(S,T).

sousGraphe(Motif,Resul) :- setof(Sommet,Motif^chercherMotif(Motif,Sommet),Resul),
							composantConnex(Resul),!.							
degreSommet(Sommet,X) :- sommet([_,[Sommet|T]]), taille(T,X).

taille([],0).
taille([_],1).
taille([_|T],X) :- taille(T,Xs), X is Xs + 1.

composantConnex([X,Y]) :- liaison(X,Y).							
composantConnex([X,Xs|Y]) :- liaison(X,Xs),composantConnex(Y).
					

			

verifierDegre(Degre,[H|T],Resultat) :- 
										listeSommet([H|T]),
										degreSommet(H,A),
										A < Degre, 
										

								 
