# On extrait la liste des magazines du fichier .txt en parcourant les lignes une à une
file = open("liste_magazine.txt","r",encoding="utf-8")
liste_magazine = []
for line in file:
    liste_magazine.append(line.rstrip('\n"').lstrip('"')) # Les méthodes rstrip() et lstrip retirent les symboles de saut de ligne '\n' ainsi que les guillemets autour des noms de magazine tels que "La pierre sèche, mode d'emploi"
file.close()

def auto_complete(liste):
    
    typed = input("Veuillez saisir jusque 3 lettres")

    # Cette boucle infinie vérifie que l'utilisateur donne un bon nombre de lettre, on en sort si c'est le cas
    while True:
        if len(typed) == 0:
            typed = input("Veuillez saisir au moins 1 lettre")
        elif len(typed) > 3:
            typed = input("Il y a trop de lettres, veuillez saisir jusque 3 lettres")
        else: 
            break

    tmp = [] # Liste qui va contenir les magazines commençant comme l'input
    

    # Les trois tests suivant séparent les cas où le nombre de lettres saisies est 1, 2 ou 3
    # Ensuite on parcourt la liste des magazines pour chercher ceux qui commencent pareil que l'input de l'utilisateur et on les met dans la liste tmp
    # Enfin on trie cette liste et renvoie les trois premiers magazines de la liste

    # Si une seule lettre dans l'input
    if len(typed) == 1:
        for mag in liste:
            if (mag[0] == typed[0] or ord(mag[0])+32 == ord(typed[0])): # Ce test permet de vérifier si les lettres sont identiques, qu'elles soient majuscules ou non
                tmp.append(mag)
        tmp = sorted(tmp,key=str.lower) # On trie alphabétiquement sans ce soucier des majuscules
        return tmp[:3]

    # Si deux lettres dans l'input
    elif len(typed) == 2:
        for mag in liste:
            if (mag[0] == typed[0] or ord(mag[0])+32 == ord(typed[0])) and mag[1] == typed [1]:
                tmp.append(mag)
        tmp = sorted(tmp,key=str.lower)
        return tmp[:3]

    # Si trois lettres dans l'input
    else:
        for mag in liste:
            if (mag[0] == typed[0] or ord(mag[0])+32 == ord(typed[0])) and mag[1] == typed [1] and (mag[2] == typed [2]  or ord(mag[2])+32 == ord(typed[2])):
                tmp.append(mag)
        tmp = sorted(tmp,key=str.lower)
        return tmp[:3]

auto_complete(liste_magazine)



""" Complexité du code:

En notant n le nombre de magazines et le nombre de lignes du fichier .txt

Pour obtenir la liste de magazines, on parcourt les lignes du fichier une par une, opération en O(n)

Dans la fonction auto_complete(), on va encore parcourir tous les magazines pour trouver ceux qui commencent comme l'input de l'utilisateur, là encore O(n).
Ensuite on fait appel à la fonction de tri sorted() qui a une complexité de O(nlog(n))

Au final, on a une complexité de l'ordre de O(nlog(n)) pour l'ensemble du code.
"""


""" Bonus:

Un problème avec ce code est que si l'on veut ajouter des magazines, on va devoir reparcourir l'intégralité du fichier alors qu'il suffirait d'ajouter ces magazines à la liste que l'on a déjà.
"""