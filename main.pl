menu :- 
				
		repeat,
		writeln('Choix 1 : consulter le fichier'),
		writeln('Choix 2 : explorer graphe'),
		writeln('Choix 3 : abstracter graphe'),
		writeln('Choix 4 : sauvegarder le ficher'),
		writeln('Choix 5 : Quitter'),
		read(X),
		between(1,5,X),
		option(X),
		X=5.
		
option(1) :- telecharger.
option(2) :- explorer.
option(3) :- abstracter(X,G).
option(4) :- sauvegarder.
option(5) :- !

telecharger :- 	consulte('test.pl').
				
explorer :- 
			listeSommet(Liste),
			listeMotif(Mot),
			sommetAdjaccent(X,ListeAd), 
			degreSommet(X),
			contientmotif(M,Liste),
			.
abstracter(X,G) :-
			
sauvegarder :- 
			
listeSommet(Liste) :- findall(T,sommet([_,[T|_]]),Liste).

sommet_Adjacent(X,L) :- sommet([_,[X|L]]),!.

listeMotif(Mot) :- setof(X,S^appartient(X,S),Liste).

appartient(Motif,Sommet) :- sommet([X,[Sommet|_]]),
							member(Motif,X).

