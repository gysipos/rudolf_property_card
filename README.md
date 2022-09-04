# property_card

Realmonitor próba feladat.

Flutter widget-et renderel, amelyhez az adatokat egy távoli szerverről szedi le.

A szerveren fent lévő JSON **idő- és letöltésszám korlátos**! (24 óra és maximum 100 letöltés.)

Amennyiben az adat már nem elérhető, [újra fel kell tölteni](https://jsonbin.io/quick-store) vagy át kell állítani a kódot, hogy a beégetett teszt adattal dolgozzon. Ehhez a `main.dart`-ban az `initState()` metódusban ki kell cserélni az api hívást erre:

    api.getSettings().then((value) { ... }

## Továbbfejlesztési lehetőségek

* Felkészíteni arra a UI-t, hogy több kártyát is tudjon renderelni, amennyiben több figyelést is rögzített a felhasználó
* Lokalizálás, a jelenlegi beégetett szövegek eltűntetése a kódból
* Ikonok eseménykezelői (törlés, szerkesztés)
* Loading indikátor
* Dedikált `TextStyle`-ok
* BLoC használata
* Hibakezelés, hiba visszajelzés a felhasználó felé
