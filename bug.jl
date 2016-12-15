#Created By Gilles Charlier & Antoine Dumont

# fonction qui renvoie l'index de l'elements le plus petit du tableau "vecteur" et qui n'est pas dans la pile fridge
function closest2(vector,fridge,n)
  min = Inf
  index=-1
  for k=1:n
    if((vector[k]<min) && (!(in(k,fridge))))
      index=k
      min=vector[k]
    end
  end
  return index
end

# fonction qui transforme la matrice d'adjacence en matrice de cout, laisse les 0 sur la diagonale
function transform(matadj,n)
  mat=convert(Array{Float64},matadj)
  for  k=1:n,l=1:n
        if ((k!=l) && (mat[k,l]==0.0))
          mat[k,l] = Inf
        else
          mat[k,l]= (1/mat[k,l])
        end
        if (k == l)
          mat[k,l]=0.0
        end
  end
  return mat
end

#= algorithme de Dikkstra
input: 2 entier: i le noeud de depart et j le noeud d'arrivee
       un tableau a 2 dimensions: matadj qui est la matrice d'adjacence du graphe dont les elements peuvent etre des entiers ou des reels
output: renvoie une liste de 2 elements: le premier etant la distance entre les 2 noeuds, le deuxieme etant le chemin parcouru entre les deux noeuds
=#
function dijkstra(i,j,mat)
  #initialisation de tous les labels a l'infini sauf le label de depart qui est initialise a 0
  n=size(mat,1) # n= le nombre de noeuds
  #mat=transform(matadj,n)
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
     u=closest2(vector,fridge,n)
     push!(fridge,u)
     # met a jour les labels des noeuds qui ne sont pas dans le frigo
     for v=1:n
       if ((!(in(v,fridge))) && (vector[u]+mat[u,v]<vector[v]))
         vector[v]=vector[u]+mat[u,v]
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
    s=pred[s]
  end
  unshift!(path,i) # ajoute finalement au debut du tableau chemin le noeud de depart
  return [vector[j],path]
end

#= algorithme de Floyd-Warshall
input: 2 entier: i le noeud de depart et j le noeud d'arrivee
       un tableau a 2 dimensions: matadj qui est la matrice d'adjacence du graphe dont les elements peuvent etre des entiers ou des reels
output: renvoie une liste de 2 elements: le premier etant la distance entre les 2 noeuds, le deuxieme etant le chemin parcouru entre les deux noeuds
=#
function floydWarshall(i,j,mat)
   n=size(mat,1)
   #mat=transform(matadj,n)

   #initialisation de la matrice pred
   pred = Matrix{Int64}(n,n)
   for a=1:n
     for b=1:n
      if ((a==b) || (mat[a,b]==Inf))
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
         if (mat[l,m] > (mat[l,k]+mat[k,m]))
          mat[l,m] = mat[l,k]+mat[k,m]
          pred[l,m] = pred[k,m]
         end
        end
     end
   end

   #creation du chemin
   path = Array{Int64}(0)
   s = j
   while(s != i)
     unshift!(path,pred[i,s])
     s = pred[i,s]
   end
   push!(path,j)
   return [mat[i,j],path]
 end

 p = [0 1/85 1/217 0 1/173 0 0 0 0 0
 1/85 0 0 0 0 1/80 0 0 0 0
 1/217 0 0 0 0 0 1/186 1/103 0 0
 0 0 0 0 0 0 0 1/183 0 0
 1/173 0 0 0 0 0 0 0 0 1/502
 0 1/80 0 0 0 0 0 0 1/250 0
 0 0 1/186 0 0 0 0 0 0 0
 0 0 1/103 1/183 0 0 0 0 0 1/167
 0 0 0 0 0 1/250 0 0 0 1/84
 0 0 0 0 1/502 0 0 1/167 1/84 0]

 q = [0 85 217 0 173 0 0 0 0 0
 85 0 0 0 0 80 0 0 0 0
 217 0 0 0 0 0 186 103 0 0
 0 0 0 0 0 0 0 183 0 0
 173 0 0 0 0 0 0 0 0 502
 0 80 0 0 0 0 0 0 250 0
 0 0 186 0 0 0 0 0 0 0
 0 0 103 183 0 0 0 0 0 167
 0 0 0 0 0 250 0 0 0 84
 0 0 0 0 502 0 0 167 84 0]

 k=[0.0 85.0 217.0 Inf 173.0 Inf Inf Inf Inf Inf
 85.0 0.0 Inf Inf Inf 80.0 Inf Inf Inf Inf
  217.0 Inf 0.0 Inf Inf Inf 186.0 103.0 Inf Inf
   Inf Inf Inf 0.0 Inf Inf Inf 183.0 Inf Inf
    173.0 Inf Inf Inf 0.0 Inf Inf Inf Inf 502.0
     Inf 80.0 Inf Inf Inf 0.0 Inf Inf 250.0 Inf
      Inf Inf 186.0 Inf Inf Inf 0.0 Inf Inf Inf
       Inf Inf 103.0 183.0 Inf Inf Inf 0.0 Inf 167.0
        Inf Inf Inf Inf Inf 250.0 Inf Inf 0.0 84.0
         Inf Inf Inf Inf 502.0 Inf Inf 167.0 84.0 0.0]

 println(dijkstra(1,10,k))
 println(floydWarshall(1,10,k))

#function main()
#  println("enter the path of your .csv file :")
#  path = input() #Path of the .csv file=#
#  println("node 1 :")
#  node1 = parse(Int,input())
#  println("node 2 :")
#  node2 = parse(Int,input())

#  matadj = readdlm(path, ',');
  # les fonctions s'executent ici :
  # type of matadj : Array{Float64,2} --> pas besoin de conversion :)
#  println("Dijstra result : ")
#  println(dijkstra(node1,node2,matadj))
#  println("FloydWarshall result : ")
#  println(floydWarshall(node1,node2,matadj))
#end
#main();
