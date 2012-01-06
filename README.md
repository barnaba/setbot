# Setbot

## Podstawowe działanie

Setbot rozpoznaje ciągi znaków zaczynające się `@` jako oznaczenie poszukiwanego numeru zestawu.
Przykładowe zapytania o zestawy to `@1234`, `@1234-1`.

## Opcje zaawansowane

### Rodzaj odpowiedzi

Po numerze zestawu można podać jeden z operatorów `+` bądź `=`.

Użycie operatora `+` będzie skutkowało połączeniem sformatowanych odpowiedzi (i oddzieleniem ich przecinkami).

        +barnex> @1234+
        +__setbot__> Gear Wheel Assortment, Letter Bricks, Replacement Gearbox for Electric, Motor 4.5V/12V Type II 12 x 4 x 3 1/3

Użycie operatora `=` będzie skutkowało wypisaniem każdej sformatowanej odpowiedzi w nowej linii wraz z odpowiadającym jej numerem zestawu.

        +barnex> @1234
        +__setbot__> 1234-1  Gear Wheel Assortment
        +__setbot__> 1234-2  Letter Bricks
        +__setbot__> 1234-3  Replacement Gearbox for Electric, Motor 4.5V/12V Type II 12 x 4 x 3 1/3

### Formatery

Setbot udostępnia różne sposoby formatowania odpowiedzi.
Sposób formatowania należy podać po operatorze rodzaju odpowiedzi.

Przykładowe zapytania zmieniające sposób formatowania to `@1234+n`, `@1234=bs`.

#### Formater `to_s`

Używany domyślnie, podaje nazwę zestawu,

#### Formater `long`

Zwraca nazwę zestawu wraz z nazwą kategorii z której pochodzi zestaw.

#### Formater `bl`

Zwraca link do zestawu na portalu [bricklink](http://www.bricklink.com).

#### Formater `bli`

Zwraca link do zdjęcia zestawu na portalu [bricklink](http://www.bricklink.com).
Formater preferuje link do zdjęcia pudełka jeśli jest dostępne.

#### Formater `bs`

Zwraca link do zestawu na portalu [brickset](http://brickset.com).

#### Formater `bs`

Zwraca link do zdjęcia zestawu na portalu [brickset](http://brickset.com).
Jeżeli nie ma obrazka, zwraca `--`

#### formater `n`

Zwraca sam numer zestawu.

### Info

Link do tego repozytorium można uzyskać wpisując `!help`, `!pomoc` lub `!setbot`.
Informacje o stanie bazy danych wyswietla polecenie `!baza`.

## Dotacje

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=Barnaba&url=http://github.com/barnaba/setbot&title=Setbot&language=&tags=github&category=software) 
