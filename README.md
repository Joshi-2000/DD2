# Auswertung Kryptowährungen 

Diese Applikation ist im Rahmen des Moduls Datenerfassung und Datenhaltung 2 an der [TH-OWL](https://www.th-owl.de/) im Sommersemester 2022 entstanden.

## Live-Version

Die Website kann Live unter [henjes.net](http://henjes.net/) gefunden werden.

## Lokal starten

Sofern die Applikation lokal gestartet werden soll, kann dies mithilfe von [docker-compose](https://docs.docker.com/desktop/install/windows-install/) getan werden. 

```bash
docker-compose up
```
Hierbei werden folgende Services auf den entsprechenden Ports gestartet:  

| Service   | Port |
|-----------|------|
| Datenbank | 5432 |
| Backend   | 8000 |
| Frontend  | 80   |
| Adminer   | 8080 |
| Fetcher   | -    |

So kann z.B. Adminer über die URL [localhost:8080](http://localhost:8080/) aufgerufen werden.

Die Datenbank beinhaltet dabei lediglich die Daten der Top 100 Kryptowährungen und erhält über den Fetcher Zeitreihen-Daten alle 5 Minuten.  

Das Frontend und Backend jedoch greifen auch bei der lokal gestarteten Applikation auf die Datenbank, welche auf dem Server liegt, zu, da dieser weitaus mehr Daten bereitstellen kann.



