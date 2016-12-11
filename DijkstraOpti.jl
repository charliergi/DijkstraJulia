#Created By Gilles & Antoine

# fonction qui renvoie l'index de l'éléments le plus petit du tableau vecteur et qui n'est pas dans la pile fridge
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

# fonction qui transforme la matrice de telle sorte que la matrice soit bien du type Float64 et que deux noeuds non relié ai une distance égale à l'infini
function transform(matadj,n)
  mat=convert(Array{Float64},matadj) # convertit la matrice en type "float64"
  for  k=1:n,l=1:n
        if ((k!=l) && (mat[k,l]==0.0))
        mat[k,l] = Inf
      end # initialise les valeurs dans la matrice d'adjacence à l'infini si les 2 noeuds ne sont pas relié
  end
  return mat
end

#= algorithme de Dikkstra
input: 2 entier: i le noeud de départ et j le noeud d'arrivée
       un tableau à 2 dimensions: mat qui est la matrice d'adjacence du graphe dont les éléments peuvent être des entiers ou des réels
output: renvoie une liste de 2 éléments: le premier étant la distance entre les 2 noeuds, le deuxieme étant le chemin parcouru entre les deux noeuds
=#
function dijkstra(i,j,mat)
  # initialisation
  n=size(mat,1) # n= le nombre de noeuds
  matadj=transform(mat,n) # on crée une nouvelle matrice qui est la même que notre matrice d'adjacence mais avec le bon format
  vector = Array{Float64}(n)
  for k=1:n
    vector[k]=Inf
  end # initialisation des labels de tous les noeuds à l'infini
  vector[i]=0 # label de départ réinitialisé à 0
  fridge = Array{Int64}(0) # créaton du frigo
  pred = Array{Int64}(n) # création d'un tableau de dimension n qui sert à retenir les prédécesseurs d'un noeud

  while(!(in(j,fridge)))
     u=closest(vector,fridge,n) # initialisation de u au noeud avec la distance minimale et qui n'est pas encore dans le frigo
     push!(fridge,u) # place le noeud u dans le frigo
     for v=1:n
       if ((!(in(v,fridge))) && (vector[u]+matadj[u,v]<vector[v]))
         vector[v]=vector[u]+matadj[u,v] # met à jour les labels des noeuds qui ne sont pas dans le frigo
         pred[v]=u # le predecesseur de v est u
       end
     end
  end
  path = Array{Int64}(0) #création du chemin
  k=j # initialisation de k au noeud d'arrivée
  while(k != i)
    unshift!(path,k)
    k=pred[k]
  end # ajoute au début du tableau chemin les noeuds prédécesseurs de j jusqu'au noeud départ
  unshift!(path,i) # ajoute finalement au début du tableau chemin le noeud de départ
  return [vector[j],path]
end

function floydWarshall(i,j,mat)
   n=size(mat,1)
   matadj=transform(mat,n)
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
   for k=1:n
     for l=1:n
       for m=1:n
         if (matadj[l,m]>(matadj[l,k]+matadj[k,m]))
         pred[l,m] = pred[k,m]
         matadj[l,m] = matadj[l,k]+matadj[k,m]
         end
        end
     end
   end
   path = Array{Int64}(0) #création du chemin
   s = j # initialisation de s au noeud d'arrivée
   while(s != i)
     unshift!(path,pred[1,s])
     s = pred[1,s]
   end
   push!(path,j)
   return [matadj[i,j],path]
 end

function main()
  println("enter the path of your .csv file :")
  path = input() #Path of the .csv file
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


p=[0 85 217 0 173 0 0 0 0 0
85 0 0 0 0 80 0 0 0 0
217 0 0 0 0 0 186 103 0 0
0 0 0 0 0 0 0 183 0 0
173 0 0 0 0 0 0 0 0 502
0 80 0 0 0 0 0 0 250 0
0 0 186 0 0 0 0 0 0 0
0 0 103 183 0 0 0 0 0 167
0 0 0 0 0 250 0 0 0 84
0 0 0 0 502 0 0 167 84 0]
#println(dijkstra(1,10,p))
