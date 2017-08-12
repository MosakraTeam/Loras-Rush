# Loras-Rush

----------------------------------------------------
TODO: ----------------------------------------------
----------------------------------------------------

1. System znajdowania przeciwnika oparty na threat (wściekłość):
  Każdy npc (bohater czy wróg) powinien mieć nadaną wartość threat (początkowo wpisaną z łapy, potem obliczaną).
  Npc powinien przeskanować swoich wrogów pod względem threatu i zaatakować wybranego wg wzorca:
    a. Najpierw atakuje przeciwnika z podobną do swojej wartością threatu.
    b. Jeżeli warunek a nie może być spełniony atakuje przeciwnika z najwyższym threatem.
    c. Wyjątek następuje, jeżeli threat przeciwnika jest duużo większy od threatu npc (wtedy ucieka - pomysł na to jak ma wyglądać ucieczka przyjdzie z czasem).
    
2. System ucieczki:
  Aktualnie brak pomysłu
  
3. Atak typu mele (z bliska):
  Najprostrzy możliwy atak. Postać po dotarciu do celu atakuje z axa. Do zrobienia w pierwszej kolejności.
  
4. Atak typu hit-scan (jakieś pistolety itp)
  Zmodyfikowana wersja ataku mele. Trzeba stworzyć nowy sposób poruszania, który uwzględnia range (zasięg) w jakim npc powinien być od swojego wroga, by zacząć strzelać. Reszta zostaje taka jak w mele.
  
5. Atak typu prodżektajl (pocisk)
  Tak jak w hit-scanie atakujący dociera w zasięg ataku i wypuszcza pocisk. Ten powinien lecieć do celu, i gdy w niego trafi zadaje mu obrażenia. Zaawansowana wersja może sprawdzać, czy pocisk nie udeżył w przeszkode, wroga itp i wtedy zadać obrażenia, bądź zniknąć :)
  
6. Ataki AoE (obszarowe)
  Brak jakiejkolwiek koncepcji :) Prawdopodobnie będzie ich kilka rodzajów zależnych od kształtu obszaru (koło, prostokąt, trójkąt itp).
  
7. System wyliczania dmg u npc.
  Czyli ogarnięcie wszystkich wzmocnień, boostów, leveli itp. 
  Wyliczanie powinno być tylko na początku walki.
  
8. System wyliczania threatu.
  Znając dps danego npc możemy wyliczyć wściekłość na niego. Trzeba to dogłębnie przemyśleć. Czy liczyć tylko dmg. Czy dać współczynnik bazowy mnożony przez dmg i inne wartości (wtedy tank może mieć go więcej pomimo małego dmg). Threat będzie trzeba liczyć inaczej dla bohaterów gracza i inaczej dla mobów (one mają tylko lvl bez dodatkowych boostów w postaci broni).
