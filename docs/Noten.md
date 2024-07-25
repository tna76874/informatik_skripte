```python
!pip uninstall notenbildung -y > /dev/null 2>&1
!pip install git+https://github.com/tna76874/notentransparenz.git@ca994fb7dcc88400c4ba2851b48fc0627329bf9f > /dev/null 2>&1

from notenbildung.models import *
```

Noten zwischen den Notensystemen N und NP umgerechnet werden.


```python
eine_note = NoteEntity(15,system = SystemNP)
print(eine_note)
eine_note.to(SystemNPS)
print(eine_note)
eine_note.to(SystemN)
print(eine_note)
eine_note.to(SystemNORM)
eine_note.to(SystemNP)
print(eine_note)
```

    15.0
    0.666666666666667
    WARNING: Inkonsistent System conversion
    1.0
    15.0


Das Verrechnen von Noten wird direkt über das '+'-Zeichen erledigt. Dabei wird die Gewichtung mitgerechnet.


```python
ka = Weight(NoteEntity(3), NoteEntity(4), NoteEntity(3.5)).normalize()
kt = Weight(NoteEntity(3), NoteEntity(1), NoteEntity(2.5)).set_weight(1)
mündlich = Weight(NoteEntity(2), NoteEntity(1), NoteEntity(3)).set_weight(1)

print(f'KA: {ka}, KT: {kt}, mündlich: {mündlich}')

schriftlich = ka + kt

gesamt = schriftlich.set_weight(3) + mündlich

print(f'schriftlich: {schriftlich}, gesamt: {gesamt}')
```

    KA: 3*3.5, KT: 1*2.1666666666666665, mündlich: 1*2.0
    schriftlich: 3*3.1666666666666665, gesamt: 4*2.875


Die Gesamtnote lässt sich auch im zeitlichen Verlauf visualisieren.


```python
noten = Notenberechnung(w_s0=1, w_sm=3, system = SystemN)
noten.note_hinzufuegen(art='KA', date = '2024-04-10', note=2, status='fertig')
noten.note_hinzufuegen(art='KA', date = '2024-04-15', note=2.5, status='fertig')
noten.note_hinzufuegen(art='KA', date = '2024-03-01', note=4.5, status='fertig')
noten.note_hinzufuegen(art='KA', date = '2024-03-15', note=5, status='fertig')
noten.note_hinzufuegen(art='KT', date = '2024-02-01', note=4, status='fehlt')
noten.note_hinzufuegen(art='KT', date = '2024-01-01', note=2.75, status='fehlt')
noten.note_hinzufuegen(art='m', date = '2023-09-01', note=3.0)
noten.note_hinzufuegen(art='m', date = '2023-10-01', note=3.25)
noten.note_hinzufuegen(art='m', date = '2023-11-01', note=3.5)

gesamtnote = noten.berechne_gesamtnote()
print(gesamtnote)
noten.plot_time_series()
```

    m_s1=3.4821428571428568, m_s=3.4290540540540535, m_m=3.25, gesamtnote=3.3842905405405403, datum=15.04.2024



    
![png](Noten_files/Noten_6_1.png)
    


Es können alle Noten angezeigt werden, die erteilt wurden.


```python
noten._get_full_dataframe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>date</th>
      <th>art</th>
      <th>status</th>
      <th>note</th>
      <th>nr</th>
      <th>von</th>
      <th>bis</th>
      <th>due</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2023-09-01</td>
      <td>m</td>
      <td>---</td>
      <td>3.0</td>
      <td>1.0</td>
      <td>2023-09-01</td>
      <td>2023-09-01</td>
      <td>None</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2023-10-01</td>
      <td>m</td>
      <td>---</td>
      <td>3.25</td>
      <td>2.0</td>
      <td>2023-10-01</td>
      <td>2023-10-01</td>
      <td>None</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2023-11-01</td>
      <td>m</td>
      <td>---</td>
      <td>3.5</td>
      <td>3.0</td>
      <td>2023-11-01</td>
      <td>2023-11-01</td>
      <td>None</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2024-01-01</td>
      <td>KT</td>
      <td>fehlt</td>
      <td>2.75</td>
      <td>1.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.75</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>5</th>
      <td>2024-02-01</td>
      <td>KT</td>
      <td>fehlt</td>
      <td>4.0</td>
      <td>2.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.75</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>7</th>
      <td>2024-03-01</td>
      <td>KA</td>
      <td>fertig</td>
      <td>4.5</td>
      <td>1.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.25</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>9</th>
      <td>2024-03-15</td>
      <td>KA</td>
      <td>fertig</td>
      <td>5.0</td>
      <td>2.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>10</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.25</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>11</th>
      <td>2024-04-10</td>
      <td>KA</td>
      <td>fertig</td>
      <td>2.0</td>
      <td>3.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>12</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.25</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>13</th>
      <td>2024-04-15</td>
      <td>KA</td>
      <td>fertig</td>
      <td>2.5</td>
      <td>4.0</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
    <tr>
      <th>14</th>
      <td>NaT</td>
      <td>V</td>
      <td>---</td>
      <td>3.25</td>
      <td>NaN</td>
      <td>NaT</td>
      <td>NaT</td>
      <td>None</td>
    </tr>
  </tbody>
</table>
</div>


