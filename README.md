# Auswertung Kryptowährungen 

Diese Applikation ist im Rahmen des Moduls Datenerfassung und Datenhaltung 2 an der THW-OWL im SS 2022 entstanden.

## Live-Version

Die Website kann Live unter [henjes.net](www.henjes.net) gefunden werden.

## Lokal starten

Sofern die Applikation lokal gestartet werden soll, kann dies mithilfe von docker-compose getan werden. 

```bash
docker-compose up
```
Hierbei werden folgende Services gestartet:  

- Datenbank
- Backend
- Frontend
- Adminer
- Fetcher

Die Datenbank beinhaltet dabei lediglich die Daten der Top 100 Kryptowährungen und erhält über den Fetcher Time Series Daten alle 5 Minuten.  

Das Frontend und Backend jedoch greifen auch bei der Lokal gestarteten Applikation auf die Datenbank, welche auf dem Server zu, da dieser weitaus mehr Daten bereitstellen kann.



