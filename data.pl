qtd_sintomas(leptospirose, 6).
qtd_sintomas(influenza, 5).
qtd_sintomas(tuberculose, 4).
qtd_sintomas(sarampo, 6).
qtd_sintomas(poliomielite, 11).
qtd_sintomas(febre_maculosa, 11).
qtd_sintomas(coronavirus, 7).
qtd_sintomas(caxumba, 8).
qtd_sintomas(catapora, 7).
qtd_sintomas(dengue, 7).

chances(leptospirose, 0.04).
chances(influenza, 0.4).
chances(tuberculose, 0.05).
chances(sarampo, 0.06).
chances(poliomielite, 0.03).
chances(febre_maculosa, 0.02).
chances(coronavirus, 0.1).
chances(caxumba, 0.03).
chances(catapora, 0.07).
chances(dengue, 0.2).

leptospirose("Febre").
leptospirose("Dor de Cabeca").
leptospirose("Dor Muscular").
leptospirose("Falta de Apetite").
leptospirose("Nauseas").
leptospirose("Vomitos").

influenza("Febre").
influenza("Dor de Garganta").
influenza("Tosse").
influenza("Dor no Corpo").
influenza("Dor de Cabeca").

tuberculose("Febre Vespertina").
tuberculose("Sudorese Noturna").
tuberculose("Emagrecimento").
tuberculose("Fadiga").

sarampo("Febre").
sarampo("Tosse").
sarampo("Irritacao nos Olhos").
sarampo("Nariz Escorrendo").
sarampo("Nariz Entupido").
sarampo("Mal-estar").

poliomielite("Febre").
poliomielite("Mal-estar").
poliomielite("Dor de Cabeca").
poliomielite("Dor de Garganta").
poliomielite("Dor no Corpo").
poliomielite("Vomitos").
poliomielite("Diarreia").
poliomielite("Constipacao").
poliomielite("Espasmos").
poliomielite("Rigidez na Nuca").
poliomielite("Meningite").

febre_maculosa("Febre").
febre_maculosa("Febre Súbita").
febre_maculosa("Cefaleia").
febre_maculosa("Hiperemia Conjuntival").
febre_maculosa("Dor Muscular").
febre_maculosa("Dor Articular").
febre_maculosa("Mal-estar").
febre_maculosa("Dores Abdominais").
febre_maculosa("Vomitos").
febre_maculosa("Diarreia").
febre_maculosa("Exantema").

coronavirus("Tosse").
coronavirus("Dor de Garganta").
coronavirus("Coriza").
coronavirus("Nariz Entupido").
coronavirus("Perda de Olfato").
coronavirus("Dores Abdominais").
coronavirus("Fadiga").

caxumba("Inchaco nas Glândulas Salivares").
caxumba("Dor nas Glândulas Salivares").
caxumba("Febre").
caxumba("Dor de Cabeca").
caxumba("Fadiga").
caxumba("Perda de Apetite").
caxumba("Dor ao Mastigar e Engolir").

catapora("Manchas Vermelhas no Corpo").
catapora("Bolhas no Corpo").
catapora("Mal-estar").
catapora("Fadiga").
catapora("Dor de Cabeca").
catapora("Perda de Apetite").
catapora("Febre").

dengue("Febre").
dengue("Dor Muscular").
dengue("Dor ao Movimentar os Olhos").
dengue("Mal-estar").
dengue("Perda de Apetite").
dengue("Dor de Cabeca")
dengue("Manchas Vermelhas no Corpo").

todas_doencas(A) :- A = [dengue, catapora, caxumba, coronavirus, febre_maculosa, poliomielite, sarampo, tuberculose, influenza, leptospirose].