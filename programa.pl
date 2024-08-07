% ------------------ Predicados --------------------

% ------------ Punto 1 
destinos(dodain, [villaPehuenia, sanMartinDeLosAndes, esquel, sarmiento, camarones, playasDoradas]).
destinos(alf, [bariloche, sanMartinDeLosAndes, elBolson]).
destinos(nico,[marDelPlata]).
destinos(vale, [calafate, elBolson]).

destinos(martu, ListaDestinos):-
    destinos(alf, Lista1),
    destinos(nico,Lista2),
    append(Lista1,Lista2,Lista3),
    list_to_set(Lista3, ListaDestinos). % elimino duplicados

destinos(juan, [villaGesell]).
destinos(juan, [federacion]).

% ------------ Punto 2
% _____ Ejemplos
atracciones(esquel, [parqueNacional(losAlerces), excursion("trochita"), excursion("travelin")]).
atracciones(villaPehuenia, [cerro(bateaMahuida,2000), cuerpoDeAgua(moquehue,sePuedePescar,14), cuerpoDeAgua(alumine,sePuedePescar,19)]).

% _____ Predicados
atraccion(parqueNacional(_)).
atraccion(cerro(_, _)).
atraccion(cuerpoDeAgua(_, _, _)).
atraccion(playa(_)).
atraccion(excursion(_)).



vacacionesCopadas(Persona):-
    destinos(Persona, ListaDestinos),
    forall(member(Destino, ListaDestinos), tieneAtraccionCopada(Destino)).

tieneAtraccionCopada(Destino):-
    atracciones(Destino, ListaAtracciones),
    member(Atraccion, ListaAtracciones),
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
noSeCruzaron(Persona1, Persona2) :-
    destinos(Persona1, ListaDestinos1),
    destinos(Persona2, ListaDestinos2),
    intersection(ListaDestinos1, ListaDestinos2, ListaComun),
    ListaComun = [].

% ------------ Punto 4
costoVida(sarmiento,100).
costoVida(esquel,150).
costoVida(villaPehuenia,180).
costoVida(sanMartinDeLosAndes,150).
costoVida(camarones,135).
costoVida(playasDoradas,170).
costoVida(bariloche,140).
costoVida(elCalafate,240).
costoVida(elBolson,145).
costoVida(marDelPlata,140).

destinoGasolero(Destino) :-
    costoVida(Destino, CostoVida),
    CostoVida < 160.

vacacionesGasoleras(Persona) :-
    destinos(Persona, ListaDestinos),
    forall(member(Destino,ListaDestinos), destinoGasolero(Destino)).

% ------------ Punto 5
itinerariosPosibles(Persona, Itinerarios) :-
    destinos(Persona, ListaDestinos),
    findall(Itinerario, armarItinerario(ListaDestinos,Itinerario), Itinerarios).

armarItinerario(ListaDestinos, Itinerario) :-
    permutation(ListaDestinos, Itinerario).