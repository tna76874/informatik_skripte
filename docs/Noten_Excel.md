```python
!pip uninstall notenbildung -y > /dev/null 2>&1
!pip install git+https://github.com/tna76874/notentransparenz.git@ca994fb7dcc88400c4ba2851b48fc0627329bf9f > /dev/null 2>&1

from notenbildung.excel import *
```


```python
ExcelFileLoader("meine_notenliste.xlsx").export()
```

    sid: 1
    vorname: Max
    nachname: Mustermann
    Warnung: Zu wenige Leistungen: [<class 'notenbildung.nvo.LeistungKA'>]: Anzahl der Leistungen 1<4
    sid: 2
    vorname: Mini
    nachname: Musterfrau
    Warnung: Zu wenige Leistungen: [<class 'notenbildung.nvo.LeistungKA'>]: Anzahl der Leistungen 1<4
    sid: 3
    vorname: Peter
    nachname: Pan
    Warnung: Zu wenige Leistungen: [<class 'notenbildung.nvo.LeistungKA'>]: Anzahl der Leistungen 1<4

