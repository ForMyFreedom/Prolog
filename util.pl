% ----------------- E/S ----------------- %

true_read(A):-
    read_string(user_input, "\n", "\r\t ", _, A).

representation(Codes, Result) :-
    atom_codes(X, Codes),
    term_to_atom(Result, X).

stream_read(Input, Lines) :-
    read_line_to_codes(Input, Line),
    (   Line == end_of_file
    ->  Lines = []
    ;   representation(Line, FinalLine),
        Lines = [FinalLine | FurtherLines],
        stream_read(Input, FurtherLines) ).

stream_write(_,[]).
stream_write(Output, [F0|FR]) :-
    term_to_atom(F0, X),
    write(Output, X),
    write(Output, '\n'),
    stream_write(Output, FR),!.

read_facts(A) :-
    open('pacientes.txt',read,In),
    stream_read(In,A),
    close(In).

write_facts(A) :-
    open('pacientes.txt',write,Out),
    stream_write(Out, A),
    close(Out).

print_odds([],[]).
print_odds([X0|XR],[Y0|YR]) :-
    NewY is Y0*100,
    format("~w: ~2f%", [X0, NewY]),
    nl,
    print_odds(XR, YR).

mostrar_todos_fatos_(X) :-
    Function =.. [X,A],
    call(Function),
    print(A),
    nl.

mostrar_todos_fatos(X):-
    mostrar_todos_fatos_(X),false.

mostrar_todos_lista([]).
mostrar_todos_lista([X0|XR]) :-
    print(X0),nl,
    mostrar_todos_lista(XR).

mostrar_todos_fatos_em_lista([],_).
mostrar_todos_fatos_em_lista([D0|DR],Sintoma) :-
    Function =.. [D0, Sintoma],
    ( call(Function) ->
        print(D0),nl
    ;
        true
    ),
    mostrar_todos_fatos_em_lista(DR, Sintoma).


mostrar_em_comum(Elem,Lista) :-
    mostrar_comum_(Elem, Lista, true), false.

mostrar_nao_em_comum(Elem,Lista) :-
    mostrar_comum_(Elem, Lista, false), false.

mostrar_comum_(Elem, Lista, Em_Comum) :-
    Function =.. [Elem,A],
    call(Function),
    ( xnor(memberchk(A, Lista), Em_Comum) ->
        print(A),nl
    ).

% ----------------- LOGIC ----------------- %

xnor(A,B) :- ((\+A,\+B);(A,B)),!.

switch(X, [Val:Goal|Cases]) :-
    ( X=Val ->
        call(Goal)
    ;
        switch(X, Cases)
    ).

% ----------------- LISTS ----------------- %

merge_list([],L,L ).
merge_list([H|T],L,[H|M]):-
    merge_list(T,L,M).

append_facts(A) :-
    read_facts(B),
    merge_list(B,[A],C),
    write_facts(C).

insert(A, [B|C], [B|D]) :- A @< B, !, insert(A, C, D).
insert(A, C, [A|C]).

ordenar_lista([A|B], S) :- ordenar_lista(B, SR), insert(A, SR, S).
ordenar_lista([], []).

remove_in_list(_, [], B, B).
remove_in_list(Nome, [A0|AR], B, AccB) :-
    (   (Nome, _, _) = A0
    ->  remove_in_list(Nome,AR, B, AccB)
    ;   append(B,[A0],NewB),
        remove_in_list(Nome, AR, NewB, AccB)),!.

find_in_list(_, [], _).
find_in_list(Nome, [A0|AR], Paciente) :-
    (   (Nome, _, _) = A0
    ->  Paciente = A0
    ;   find_in_list(Nome, AR, Paciente)),!.
