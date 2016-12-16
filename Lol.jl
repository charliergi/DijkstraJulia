#Created By Gilles Charlier & Antoine Dumont

# fonction qui renvoie l'index de l'elements le plus petit du tableau "vecteur" et qui n'est pas dans la pile fridge
function closest(vector,fridge,n)
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

# Cree une matrice qui sera soit:
# une matrice Float64 de cout correspondante a la matrice d'adjacence rentree (isAdj = true)
# une matrice de cout identique convertie en Float64
function transform(mat,n,isAdj)
  convert(Array{Float64},mat)
  matAux = Matrix{Float64}(n,n)
  for i=1:n,j=1:n
    matAux[i,j]=mat[i,j]
  end

  for  k=1:n,l=1:n
    if (matAux[k,l]==0.0)
      matAux[k,l] = Inf
    else
      if (isAdj) # true --> tranformer la matrice adj en cost
        matAux[k,l]= (1/matAux[k,l])
      end
    end
  end
  return matAux
end


#= algorithme de Dikkstra
input: 2 entier: i le noeud de depart et j le noeud d'arrivee
       un tableau a 2 dimensions: matadj qui est la matrice d'adjacence du graphe dont les elements peuvent etre des entiers ou des reels
output: renvoie une liste de 2 elements: le premier etant la distance entre les 2 noeuds, le deuxieme etant le chemin parcouru entre les deux noeuds
=#
function dijkstra(i,j,matcost)
  #initialisation de tous les labels a l'infini sauf le label de depart qui est initialise a 0
  n=size(matcost,1) # n= le nombre de noeuds
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
     u=closest(vector,fridge,n)
     push!(fridge,u)
     # met a jour les labels des noeuds qui ne sont pas dans le frigo
     for v=1:n
       if ((!(in(v,fridge))) && (vector[u]+matcost[u,v]<vector[v]))
         vector[v]=vector[u]+matcost[u,v]
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
function floydWarshall(i,j,matcost)
   n=size(matcost,1)
   #mat = transform(matcost,n)

   #initialisation de la matrice pred
   pred = Matrix{Int64}(n,n)
   for a=1:n
     for b=1:n
      if ((a==b) || (matcost[a,b]==Inf))
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
         if (matcost[l,m] > (matcost[l,k]+matcost[k,m]))
          matcost[l,m] = matcost[l,k]+matcost[k,m]
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
   return [matcost[i,j],path]
 end

function main()
  println("enter the path of your .csv file :")
  path = input() #Path of the .csv file
  matInput = readdlm(path, ',');
  check=false
  while(!check)
    println("node 1 :")
    node1 = parse(Int,input())
    println("node 2 :")
    node2 = parse(Int,input())
    if ((node1<1 || node1>size(matInput,1)) || (node2<1 || node2>size(matInput,1)))
      println("At least one of your entry node doesn't exist! please choose right nodes!")
    else
      check=true
    end
  end
  println("Type cost if the .csv contains a cost matrix, adj if it contains an adjancy matrix")
  notOk = true
  matcount = Matrix{Float64}(size(matInput,1),size(matInput,1))
  while(notOk)
    typeOfMatrix = input();
    if (typeOfMatrix=="cost")
      matcount = transform(matInput,size(matInput,1),false)
      notOk=false
    elseif (typeOfMatrix == "adj")
      matcount = transform(matInput,size(matInput,1),true)
      notOk=false
    else
      println("Invalid entry, please type again")
    end
  end


   #les fonctions s'executent ici :
   #type of matadj : Array{Float64,2} --> pas besoin de conversion :)
   println("Dijkstra result : ")
   println(dijkstra(node1,node2,matcount))
   println("Floyd-Warshall result : ")
   println(floydWarshall(node1,node2,matcount))
 end
 main();
