#Created By Gilles & Antoine
# regarde la ligne line de la matrice d'adjacence et renvoie la colonne du plus petit noeud qui n'est pas dans le fridge et >0
function closest(vector,fridge,n)
  min = Inf
  index=-1
  for k=1:n
    if((vector[k]<min) & (!(in(k,fridge))))
      index=k                                                                                                                                                                                                                                                                     =k
      min=vector[k] # renvoie l'index auquel se trouve le plus petit element de la ligne index
    end
  end
  return index
end

function transform(mat)
  n=size(mat,1)
  for  k=1:n,l=1:n
      if ((k!=l) & (mat[k,l]==0.0))
        mat[k,l] = Inf
      end
  end
  return mat
end

function dijkstra(i,j,matadj)
  #initialisation
  n=size(matadj,1)
  transform(matadj)
  vector = Array{Float64}(n)
  for k=1:n
    vector[k]=Inf
  end
  vector[i]=0
  fridge = Array{Int64}(0)
   #body
  while(!(in(j,fridge)))
     u=closest(vector,fridge,n)
     push!(fridge,u)
     for v=1:n
       if ((!(in(v,fridge))) & (vector[u]+matadj[u,v]<vector[v]))
         vector[v]=vector[u]+matadj[u,v]
       end
     end
  end
    return vector[j]
end

p=Float64[0 4 2 0 0 0
4 0 1 5 0 0
2 1 0 8 10 0
0 5 8 0 2 6
0 0 10 2 0 3
0 0 0 6 3 0]
print(dijkstra(1,6,p))
