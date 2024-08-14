% ------------------ Predicados --------------------

% ------------ Punto 1 

destino(dodain, villaPehuenia).
destino(dodain, sanMartinDeLosAndes).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, bariloche).
destino(alf, sanMartinDeLosAndes).
destino(alf, elBolson).

destino(nico, marDelPlata).

destino(vale, calafate).
destino(vale, elBolson).

destino(martu, Destino):-
    destino(alf, Destino).
destino(martu, Destino):-
    destino(nico, Destino).

/*

Defino los hechos necesarios para todas aqullas cosas que sean verdades absolutas, 
como que Alf se va a Bariloche o que Dodain va a Playas Doradas. 

No genero hechos para Carlos porque para que algo se considere falso, 
es decir él no yendose de vacaciones, basta con que no aparezca en la base de conocimientos
debido a que esta base en Prolog se basa en el Principio de Universo Cerrado 
donde todo aquello que no aparece en la base de conocimientos se considera falso. 

No genero hechos para Juan tampoco porque, como dije antes, solo se coloca en la base de 
conocimientos las verdades absolutas. Juan todavía no sabe, entonces no se coloca. 

*/

% ------------ Punto 2

% parqueNacional(nombre).
% cerro(nombre, altura).
% cuerpoDeAgua(nombre, sePuedePescar, temperatura).
% playa(nombre, dif promedio).
% excursion(nombre).

atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion("trochita")).
atraccion(esquel, excursion("travelin")).

atraccion(villaPehuenia, cerro(bateaMahuida, 2000)).
atraccion(villaPehuenia, cuerpoDeAgua(moquehue, sePuedePescar, 14)).
atraccion(villaPehuenia, cuerpoDeAgua(alumine, sePuedePescar, 19)).

atraccion(sanMartinDeLosAndes, parqueNacional(lanin)).
atraccion(sanMartinDeLosAndes, cerro(chapelco, 1980)).
atraccion(sanMartinDeLosAndes, cuerpoDeAgua(lagoLacar, noSePuedePescar, 12)).
atraccion(sanMartinDeLosAndes, playa(quilquihue, 3.1)).
atraccion(sanMartinDeLosAndes, excursion("Trekking en el Bosque")).

atraccion(sarmiento, parqueNacional(bosquePetrificado)).
atraccion(sarmiento, cerro(laMata, 1750)).
atraccion(sarmiento, cuerpoDeAgua(lagoColhueHuapi, sePuedePescar, 8)).

atraccion(camarones, parqueNacional(monteLeon)).
atraccion(camarones, playa(costaAzul, 4.2)).
atraccion(camarones, excursion("Avistaje de Ballenas")).

atraccion(playasDoradas, cuerpoDeAgua(rioNegro, sePuedePescar, 18)).
atraccion(playasDoradas, playa(playaBonita, 3.5)).

atraccion(bariloche, parqueNacional(nahuelHuapi)).
atraccion(bariloche, cerro(cerroCatedral, 2388)).
atraccion(bariloche, cuerpoDeAgua(lagoNahuelHuapi, sePuedePescar, 9)).

atraccion(elBolson, parqueNacional(piltriquitron)).
atraccion(elBolson, cuerpoDeAgua(rioAzul, sePuedePescar, 11)).
atraccion(elBolson, excursion("Caminata por el Bosque Tallado")).

atraccion(marDelPlata, cuerpoDeAgua(lagunaDeLosPadres, sePuedePescar, 16)).
atraccion(marDelPlata, excursion("Paseo en Catamaran")).

atraccion(calafate, parqueNacional(losGlaciares)).
atraccion(calafate, cuerpoDeAgua(lagoArgentino, noSePuedePescar, 4)).
atraccion(calafate, playa(playaDeLosGorriones, 1.7)).
atraccion(calafate, excursion("Navegacion por el Perito Moreno")).

vacacionesCopadas(Persona):-
    destino(Persona, _),
    forall(destino(Persona, Destino), tieneAtraccionCopada(Destino)).

tieneAtraccionCopada(Destino):-
    atraccion(Destino, Atraccion),
    esCopada(Atraccion).

esCopada(cerro(_,Altura)) :-
    Altura > 2000.

esCopada(cuerpoDeAgua(_,sePuedePescar,_)).
esCopada(cuerpoDeAgua(_,_,Temp)) :-
    Temp > 20.

esCopada(playa(Diferencia)) :-
    Diferencia < 5.

esCopada(excursion(Nombre)) :-
    string_length(Nombre, Long),
    Long > 7.

esCopada(parqueNacional(_)).

% ------------ Punto 3
noSeCruzaron(P1, P2) :-
    destino(P1, _),
    destino(P2, _),
    P1 \= P2,
    not((destino(P1, D), destino(P2, D))).

% ------------ Punto 4
costoVida(sarmiento, 100).
costoVida(esquel, 150).
costoVida(villaPehuenia, 180).
costoVida(sanMartinDeLosAndes, 150).
costoVida(camarones, 135).
costoVida(playasDoradas, 170).
costoVida(bariloche, 140).
costoVida(elCalafate, 240).
costoVida(elBolson, 145).
costoVida(marDelPlata, 140).

vacacionesGasoleras(Persona) :-
    destino(Persona, _),
    forall(destino(Persona, Destino), destinoGasolero(Destino)).

destinoGasolero(Destino) :-
    costoVida(Destino, CostoVida),
    CostoVida < 160.

% ------------ Punto 5

itinerariosPosibles(Persona, Itinerarios) :-
    findall(Destino, destino(Persona, Destino), ListaDestinos),
    findall(Itinerario, permutation(ListaDestinos, Itinerario), Itinerarios).

