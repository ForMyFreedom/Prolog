:- [data].
:- [util].

avaliar_sintomas :-
    print("Insira seus sintomas separados por virgula (E coloque por fim um ponto final): "),
    read(X),
    comma_list(X, Sintomas),
    todas_doencas(Doencas),
    sintomas_sobre_doencas(Doencas, Sintomas, Odds, []),
    ordenar_lista(Odds, SortedOdds, Doencas, SortedDoencas),
    print_odds(SortedDoencas, SortedOdds),
    print("O resultado do protótipo é apenas informativo. O paciente deve consultar um médico para obter um diagnóstico correto e preciso."),nl,
    mais_informacoes(SortedDoencas, Sintomas).

sintomas_sobre_doencas([], _, X, X).
sintomas_sobre_doencas([Doenca0|DoencaR], Sintomas, Odds, AccOdds) :-
    qtd_sintomas(Doenca0, QTD),
    chances(Doenca0, REGULAR_ODD),
    listar_sintomas(Sintomas, Doenca0, QTD_SINTOMAS_BATENDO, 0),
    ChancesDessaDoenca is QTD_SINTOMAS_BATENDO/QTD*REGULAR_ODD,
    append(AccOdds, [ChancesDessaDoenca], NewOds),
    sintomas_sobre_doencas(DoencaR, Sintomas, Odds, NewOds).

listar_sintomas([], _, X, X) :- !.
listar_sintomas([Sintoma0|SintomaR], Doenca, QTD_SINTOMAS_BATENDO, Acc):-
    Function =.. [Doenca,Sintoma0],
    call(Function),
    NewAcc is Acc+1,
    listar_sintomas(SintomaR, Doenca, QTD_SINTOMAS_BATENDO, NewAcc),
    !.
listar_sintomas([Sintoma0|SintomaR], Doenca, QTD_SINTOMAS_BATENDO, Acc):-
    Function =.. [Doenca,Sintoma0],
    \+ call(Function),
    listar_sintomas(SintomaR, Doenca, QTD_SINTOMAS_BATENDO, Acc).

mais_informacoes(Doencas, Sintomas) :-
    print("Gostaria de saber algo mais?"),nl,
    print("(a). Por que essa é a doença mais provavel?"),nl,
    print("(b). Por que não é outra doença?"),nl,
    print("(c). Quais doenças possuem um certo sintoma meu?"),nl,
    print("(d). Encerrar interação"),nl,
    read(Desejo),
    switch(Desejo, [
        a : porque_da_doenca(Doencas, Sintomas),
        b : porque_nao_doenca(Doencas, Sintomas),
        c : porque_sintoma(Doencas),
        d : false
    ]),
    nl,nl,nl,
    mais_informacoes(Doencas, Sintomas).

porque_da_doenca([D|_], SintomasDoPaciente):-
    print("Essa Doença está associada aos seguintes sintomas:"),nl,
    (mostrar_todos_fatos(D);true),
    nl,print("Ao passo que seus sintomas foram:"),nl,
    mostrar_todos_lista(SintomasDoPaciente),
    nl,print("Sendo os sintomas em comum:"),nl,
    (mostrar_em_comum(D, SintomasDoPaciente);true).

verificar_se_e_mais_comum(DoencaOriginal, DoencaQuestionada) :-
    FunctionA =.. [chances, DoencaOriginal, A],
    call(FunctionA),
    FunctionB =.. [chances, DoencaQuestionada, B],
    call(FunctionB),
    ( A>B ->
        print("A Doença determinada pelo sistema é mais comum na média"), nl
    ;
        true
    ).

porque_nao_doenca([DoencaOriginal|DR], SintomasDoPaciente):-
    print("Qual doenca?"),
    read(DoencaQuestionada),
    ( memberchk(DoencaQuestionada, DR) ->
        verificar_se_e_mais_comum(DoencaOriginal,DoencaQuestionada),
        print("Você não possui os seguintes sintomas dessa doença: "),nl,
        (mostrar_nao_em_comum(DoencaQuestionada, SintomasDoPaciente);true)
    ;
        print("Doenca invalida para seu questionamento")
    ).

porque_sintoma(Doencas):-
    print("Qual sintoma?"),
    read(Sintoma),
    print("As seguintes doenças possuem esse sintoma:"), nl,
    mostrar_todos_fatos_em_lista(Doencas, Sintoma).

% ----------------- OPERAÇÕES COM PACIENTES ----------------- %

adicionar_paciente :-
    print("Insira o nome do Paciente: "),
    true_read(Nome),
    print("Insira a idade do Paciente: "),
    true_read(Idade),
    print("Insira o gênero do Paciente: "),
    true_read(Genero),
    Z = (Nome, Idade, Genero),
    append_facts(Z),
    print("Paciente adicionado com sucesso").

remover_paciente :-
    print("Insira o nome do Paciente a ser removido: "),
    true_read(Nome),
    read_facts(A),
    remove_in_list(Nome, A, [], B),
    ( A==B
    ->  print("Paciente não existe")
    ;   write_facts(B),
        print("Paciente removido com sucesso") ).

print_paciente(Paciente) :-
    (Nome, Idade, Genero) = Paciente,
    print("Nome: "),print(Nome),nl,
    print("Idade: "),print(Idade),nl,
    print("Genero: "),print(Genero),nl.

consultar_paciente :-
    print("Insira o nome do Paciente a ser consultado: "),
    true_read(Nome),
    read_facts(A),
    find_in_list(Nome, A, Paciente),
    ( var(Paciente)
    ->  print("Paciente não existe")
    ;   print_paciente(Paciente) ).

alterar_paciente :-
    print("Insira o nome do Paciente a ser alterado: "),
    true_read(Nome),
    read_facts(A),
    remove_in_list(Nome, A, [], B),
    ( A==B
    ->  print("Paciente não existe")
    ;   write_facts(B), adicionar_paciente ).
