#Created By Gilles Charlier & Antoine Dumont

# fonction qui renvoie l'index de l'elements le plus petit du tableau "vecteur" et qui n'est pas dans la pile fridge
function closest(vector,fridge,n)
  min = Inf
  index=-1
  for k=1:n
    if((vector[k]<min) && (!(in(k,fridge))))
      index=k                                                                                                                                                                                                                                                                     =k
      min=vector[k]
    end
  end
  return index
end

# fonction qui transforme la matrice de telle sorte que la matrice soit bien du type Float64 et que deux noeuds non relie ai une distance egale a l'infini
function transform(matadj,n)
  mat=convert(Array{Float64},matadj)
  for  k=1:n,l=1:n
        if ((k!=l) && (mat[k,l]==0.0))
        mat[k,l] = Inf
      end
  end
  return mat
end

#= algorithme de Dikkstra
input: 2 entier: i le noeud de depart et j le noeud d'arrivee
       un tableau a 2 dimensions: mat qui est la matrice d'adjacence du graphe dont les elements peuvent etre des entiers ou des reels
output: renvoie une liste de 2 elements: le premier etant la distance entre les 2 noeuds, le deuxieme etant le chemin parcouru entre les deux noeuds
=#
function dijkstra(i,j,mat)
  #initialisation de tous les labels a l'infini sauf le label de depart qui est initialise a 0
  n=size(mat,1) # n= le nombre de noeuds
  matadj=transform(mat,n)
  vector = Array{Float64}(n)
  for k=1:n
    vector[k]=Inf
  end
  vector[i]=0
  fridge = Array{Int64}(0) # creaton du frigo
  pred = Array{Int64}(n) # creation d'un tableau de dimension n qui sert a retenir les predecesseurs d'un noeud

  #calcul plus court chemin
  while(!(in(j,fridge)))
    # Place le noeud avec la distance minimimale dans le frigo a condition que celui-ci n'y soit pas encore
     u=closest(vector,fridge,n)
     push!(fridge,u)
     # met a jour les labels des noeuds qui ne sont pas dans le frigo
     for v=1:n
       if ((!(in(v,fridge))) && (vector[u]+matadj[u,v]<vector[v]))
         vector[v]=vector[u]+matadj[u,v]
         pred[v]=u # le predecesseur de v est le dernier noeud du frigo
       end
     end
  end

  #creation chemin
  path = Array{Int64}(0)
  s=j
  # ajoute au debut du tableau "chemin" les noeuds predecesseurs de j jusqu'au noeud de depart
  while(s != i)
    unshift!(path,s)
    s=pred[k]
  end
  unshift!(path,i) # ajoute finalement au debut du tableau chemin le noeud de depart
  return [vector[j],path]
end

#= algorithme de Floyd-Warshall
input: 2 entier: i le noeud de depart et j le noeud d'arrivee
       un tableau a 2 dimensions: mat qui est la matrice d'adjacence du graphe dont les elements peuvent etre des entiers ou des reels
output: renvoie une liste de 2 elements: le premier etant la distance entre les 2 noeuds, le deuxieme etant le chemin parcouru entre les deux noeuds
=#
function floydWarshall(i,j,mat)
   n=size(mat,1)
   matadj=transform(mat,n)

   #initialisation de la matrice pred
   pred = Matrix{Int64}(n,n)
   for a=1:n
     for b=1:n
      if ((a===b) || (matadj[a,b]==Inf))
        pred[a,b] = -1
      else
        pred[a,b] = a
      end
     end
   end

   # Calcul du plus court chemin
   for k=1:n
     for l=1:n
       for m=1:n
         # si le plus court chemin passe par k alors on peut le diviser en 2sous-chemin allant de l a k et de k a m
         if (matadj[l,m]>(matadj[l,k]+matadj[k,m]))
         pred[l,m] = pred[k,m]
         matadj[l,m] = matadj[l,k]+matadj[k,m]
         end
        end
     end
   end

   #creation du chemin
   path = Array{Int64}(0)
   s = j
   while(s != i)
     unshift!(path,pred[1,s])
     s = pred[1,s]
   end
   push!(path,j)
   return [matadj[i,j],path]
 end

function main()
  println("enter the path of your .csv file :")
  path = input() #Path of the .csv file=#
  println("node 1 :")
  node1 = parse(Int,input())
  println("node 2 :")
  node2 = parse(Int,input())

  matadj = readdlm(path, ',');
  # les fonctions s'executent ici :
  # type of matadj : Array{Float64,2} --> pas besoin de conversion :)
  println("Dijstra result : ")
  println(dijkstra(node1,node2,matadj))
  println("FloydWarshall result : ")
  println(floydWarshall(node1,node2,matadj))
end
main();
