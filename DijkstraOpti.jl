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

p=Float64[0 85 217 0 173 0 0 0 0 0
85 0 0 0 0 80 0 0 0 0
217 0 0 0 0 0 186 103 0 0
0 0 0 0 0 0 0 183 0 0
173 0 0 0 0 0 0 0 0 502
0 80 0 0 0 0 0 0 250 0
0 0 186 0 0 0 0 0 0 0
0 0 103 183 0 0 0 0 0 167
0 0 0 0 0 250 0 0 0 84
0 0 0 0 502 0 0 167 84 0]
print(dijkstra(1,10,p))
