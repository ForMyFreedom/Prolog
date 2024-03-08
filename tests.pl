:- [main].

%% verificar_se_e_mais_comum is semidet
% verdadeiro se a chance da DoencaQuestionada occorrer é maior que a da DoencaOriginal
:- begin_tests(verificar_se_e_mais_comum).
test(mais_comum1) :- verificar_se_e_mais_comum(influenza, tuberculose).
test(mais_comum2) :- verificar_se_e_mais_comum(leptospirose, poliomielite).
:- end_tests(verificar_se_e_mais_comum).

%% xnor is semidet
% verdadeiro se A e B são iguais logicamente
:- begin_tests(xnor).
test(xnor0) :- xnor(true, true).
test(xnor1) :- xnor(false, false).
test(xnor2, [fail]) :- xnor(true, false).
test(xnor3, [fail]) :- xnor(false, true).
:- end_tests(xnor).

%% merge_list is nondet
% verdadeira se lista M é a concatenação da T com L
:- begin_tests(merge_list).
test(m0) :- merge_list([1,2],[3,4,5],[1,2,3,4,5]).
test(m1, [nondet, T==[1,2,4]]) :- merge_list(T,[3],[1,2,4,3]).
test(m2, L==[4,3]) :- merge_list([1,2],L,[1,2,4,3]).
test(m3, all(p(T,L)==[p([],[1,2,3]),p([1],[2,3]),p([1,2],[3]),p([1,2,3],[])])) :- merge_list(T,L,[1,2,3]).
:- end_tests(merge_list).