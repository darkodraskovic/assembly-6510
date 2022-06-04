10 print"ausgabe in fahrenheit oder celsius (f/c)":input a$
20 if a$="" then 10
30 if a$="c" then 100
40 if a$="f" then 50
45 goto 10
50 input"eingabe von celsius: ";c
60 f = (c*9)/5+32
70 print c;"grad celsius = ";f;"grad fahrenheit"
80 print
90 goto 10
100 input "eingabe von fahrenheit: ";f
110 c = (f-32)*5/9
120 print f;"grad fahrenheit = ";c;"grad celsius"
130 print
140 goto 10
