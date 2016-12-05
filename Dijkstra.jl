#Created By Gilles & Antoine
function notInTheFridge(element,vectorPath)
  isIn = false
  for i=1:length(vectorPath)
    if (element==vectorPath[i])
      isIn = true
      return isin
# function closest
#
function closest(index,matadj)
  min = typemax(Int64)
  for k=1:n
    if(matadj[index,k]<min && matadj != 0)# && fonction)
      min=k # renvoie l'index auquel se trouve le plus petit element de la ligne index
    end
  end
function dijkstra(i,j,matadj)
  #initialisation
  mat = matadj
  n=size(mat,1)
  infinity = typemax(Int64)

  for k=1:n,l=1:n
    mat[k,l]=infinity
  end
  mat[i,i]=0
  vectorPath = Int64[]
  done=false
  #body
  notDone=true
  #while(notDone)
    # verifier si le noeud ajouté se trouve à l'index j
    # si oui : done = true
    # si non : done = false et continuer

  #end
end

#test
matrice = [1 2 3]
length(matrice)
test= dijkstra(1,2,matrice)
println(test)

vector = Float64[]
println(vector==Float64[])
