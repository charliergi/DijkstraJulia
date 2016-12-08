#Created By Gilles & Antoine
# regarde la ligne line de la matrice d'adjacence et renvoie la colonne du plus petit noeud qui n'est pas dans le fridge et >0
function closest(vector,fridge,n)
  min = typemax(Int64)
  index=-1
  for k=1:n
    if((vector[k]<min) & (!(in(k,fridge))))
      index=k                                                                                                                                                                                                                                                                     =k
      min=vector[k] # renvoie l'index auquel se trouve le plus petit element de la ligne index
    end
  end
  return index
end

function dijkstra(i,j,mat)
  #initialisation
  n=size(mat,1)
  matadj = mat
  for k=1:n,l=1:n
      if ((k!=l) & (matadj[k,l]==0))
      matadj[k,l]= typemax(Int64)
      end
  end

  vector = Array{Int64}(n)
  for k=1:n
    vector[k]=typemax(Int64)
  end
  vector[i]=0
  fridge = Array{Int64}(0) #body

  while(!(in(j,fridge)))
     u=closest(vector,fridge,n)
     push!(fridge,u)
     for v=1:n
       if (!(in(v,fridge)) & vector[u]+matadj[u,v]<vector[v])
         vector[v]=vector[u]+matadj[u,v]
       end
     end
  end
    return vector[j]
end

p=[0 4 2 0 0 0
4 0 1 5 0 0
2 1 0 8 10 0
0 5 8 0 2 6
0 0 10 2 0 3
0 0 0 6 3 0]
dijkstra(1,6,p)
