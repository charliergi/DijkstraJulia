#Created By Gilles & Antoine
function dijkstra(i,j,matadj)
  #initialisation
  mat = matadj
  n=size(mat,1)
  infinity = typemax(Int64)
  vectorInt = Int64[]
  vectorPath = String[]
  for k=1:n,l=1:n
    mat[k,l]=infinity
  end
  mat[i,i]=0
  return mat
end

#test
matrice = [1 2
            2 2]
test= dijkstra(1,2,matrice)
println(test)
