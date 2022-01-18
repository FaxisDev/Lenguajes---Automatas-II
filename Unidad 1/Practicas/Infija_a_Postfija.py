infija = input("Escribe la Operacion Infija: ")
precedencia = {"exp": 5, "tan": 5, "log": 5, "cos": 5, "sen": 5, "^": 4,
               "%": 4, "*": 3, "/": 3, "+": 2, "-": 2, "(": 1}
pila_operadores, listaPosfija, numeros = [], [], []
funcion = infija.split()

# Identifica todos los numeros de la lista
for numeros_obtenidos in funcion:
    # Si la cadena no es Alhpanumerico y si es un numero lo adjuntara a la lista
    if not numeros_obtenidos.isalpha() and numeros_obtenidos.isalnum():
        numeros.append(numeros_obtenidos)
# Convertir de Caracteres a Int
numeros = list(map(int, numeros))
# Ordena la lista con la funcion sort()
numeros.sort()
# Nuevamente la lista a String
numeros = list(map(str, numeros))
numeros.append("pi")

# Transforma la cadena de texto en caracter
for elemento_cadena in funcion:
    # Determina si es una variable o un numero y lo ingresa a la lista
    if elemento_cadena in "abcdejghyjkomnopqrstuvwxyz" or elemento_cadena in str(numeros):
        listaPosfija.append(elemento_cadena)
    elif elemento_cadena == '(':
        pila_operadores.append(elemento_cadena)
    elif elemento_cadena == ')':
        parentesis_izq = pila_operadores.pop()
        while parentesis_izq != '(':
            #
            listaPosfija.append(parentesis_izq)
            parentesis_izq = pila_operadores.pop()
    else:
        while not len(pila_operadores) == 0 and (precedencia[pila_operadores[len(pila_operadores)-1]] >= precedencia[elemento_cadena]):
            listaPosfija.append(pila_operadores.pop())
        pila_operadores.append(elemento_cadena)
    print(pila_operadores)
while not len(pila_operadores) == 0:
    listaPosfija.append(pila_operadores.pop())

print("Notació posfija: ", ", ".join(listaPosfija))
