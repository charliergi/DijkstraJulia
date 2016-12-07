#Created By Gilles & Antoine
# regarde la ligne line de la matrice d'adjacence et renvoie la colonne du plus petit noeud qui n'est pas dans le fridge et >0
function closest(vector,fridge)
  min = typemax(Int64)
  index=-1
  for k=1:size(vector,2)
    if((vector[k]<min) & (in(k,fridge)==false))

      index=k # renvoie l'index auquel se trouve le plus petit element de la ligne index
    end
  end
  return index
end

function dijkstra(i,j,matadj)
  #initialisation

  vector = Array{Int64,size(matadj,1)}
  size=size(vector,2)
  path = Int64[]
  point=-1
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
         point=v
       end
     end
     if in(point,path)==false
       push!(path,point)
     end
  end
    return vector[end]
end

p=[0 7 2 8
7 0 9 1
2 9 0 3
8 1 3 0]
println(dijkstra(1,4,p))
