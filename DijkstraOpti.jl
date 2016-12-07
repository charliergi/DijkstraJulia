#Created By Gilles & Antoine
# regarde la ligne line de la matrice d'adjacence et renvoie la colonne du plus petit noeud qui n'est pas dans le fridge et >0
function closest(vector,fridge)
  min = typemax(Int64)
  index=-1
  for k=1:size(vector,2)
    if((vector[k]<min) & (in(k,fridge)==false))

      index=k # renvoie l'index auquel se trouve le plus petit element de la ligne index
    end
  return index
end

function dijkstra(i,j,matadj)
  #initialisation

  vector = Array{Int64,size(matadj,1)}
  size=size(vector,2)
  for k=1:size
    vector[k]=typemax(Int64)
  end
  vector[i]=0
  fridge = Int64[]
  #body
  println(k)
  while(in(j,fridge)==false)
     u=closest(vector,fridge)
     push!(fridge,u)
     for v=1:size
       if in(v,fridge)==false & vector[u]+matadj[u,v]<vector[v]
         vector[v]=vector[u]+matadj[u,v]
       end
  end
  return vector[end]
end
