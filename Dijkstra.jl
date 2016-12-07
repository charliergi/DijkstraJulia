
#Created By Gilles & Antoine

function notInTheFridge(element,vectorPath)
  isIn = false
  for i=1:length(vectorPath)
    if (element==vectorPath[i])
      isIn = true
  end
    return isin
end
      
# function closest
#

function closest(index,matadj)
  min = typemax(Int64)
  for k=1:n
    if((matadj[index,k]<min) & (matadj[index,k] != 0) & (notInTheFridge(k,vectorPath)==false))
      min=u 
      index=k # renvoie l'index auquel se trouve le plus petit element de la ligne index
      
  end
end
  
function dijkstra(i,j,matadj)
  #initialisation
  mat = matadj
  n=size(mat,1)
  for k=1:n,l=1:n
    mat[k,l]=typemax(Int64)
  end
  mat[i,i]=0
  vectorPath = Int64[]
  #body
  notDone=true
  while(notInTheFridge(j,vectorPath)==false)
     u=
     push!(vectorPath,closest())
    # verifier si le noeud ajouté se trouve à l'index j
    # si oui : done = true
    # si non : done = false et continuer

  #end
end
