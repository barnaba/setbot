# Setbot

## Przykłady

    <barnex> 2222
    <__setbot__> 2222-1: Tunnel Fun http://j.mp/AddYoG

    <barnex> 2222?
    <__setbot__> 2222-1: Tunnel Fun http://j.mp/AddYoG

    <barnex> kupiłem na allegro @2222
    <__setbot__> 2222-1: Tunnel Fun http://j.mp/AddYoG

    <barnex> kupiłem na allegro zestaw 2222
    <__setbot__> 2222-1: Tunnel Fun http://j.mp/AddYoG

## Podstawowe działanie

Setbot rozpoznaje ciągi znaków zaczynające się od `!`, `@`, `#` lub słowa `zestaw` jako oznaczenie poszukiwanego numeru zestawu.

Jeżeli w linii znajduje się tylko numer zestawu, to też zostanie rozpoznany.

Można pytać o zestaw szczegółowo (podając numer zestawu po myślniku) lub nie. W tym drugim przypadku zostaną zwrócone wszystkie pasujące zestawy.

Skrócony link na końcu prowadzi do strony zestawu na bricklinku.

Bawić się setbotem można zarówno na kanale jak i na prvie, do czego gorąco zachęcam.

Setbot odpowiada na polecenie `ping`, ale tylko na privie.


### Info

Link do tego repozytorium można uzyskać wpisując `!help`, `!pomoc` lub `!setbot`.

Informacje o stanie bazy danych wyswietla polecenie `!baza`.

### Kodowanie

Setbot pozwala też sprawdzić, czy ustawiłeś poprawne kodowanie polskich znaków.

    <barnex> -!ogonki zażółć gęślą jaźń
    <__setbot__> Znalazłem następujące ogonki: zażółć gęślą jaźń

Poprawnie zakodowane znaki zostaną podświetlone na zielono.

## Dotacje

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=Barnaba&url=http://github.com/barnaba/setbot&title=Setbot&language=&tags=github&category=software) 


<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
  <input type="hidden" name="cmd" value="_s-xclick">
    <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
  ">
  <input type="image" src="https://www.paypalobjects.com/pl_PL/PL/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal — Płać wygodnie i bezpiecznie">
  <img alt="" border="0" src="https://www.paypalobjects.com/pl_PL/i/scr/pixel.gif" width="1" height="1">
</form>


