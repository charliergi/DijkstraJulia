# Bellman-Ford implementation in Julia
# Created by Antoine Dumont and Gilles Charlier
# ◮ Given a directed weighted graph G and a source s
# ◮ Outputs a vector d where di is the shortest distance from s to node i
# ◮ Can detect a negative-weight cycle
# ◮ Runs in Θ(nm) time
function bellmanFord(matadj,s)
  sizeOfMatrix = size(matadj,1)
  #list of edges
  listOfEdges = Array{Any}(0)

  for i=1:sizeOfMatrix-1
    for j=1+i:sizeOfMatrix
      push!(listOfEdges,(i,j,matadj[i,j]))
    end
  end
  for i=2:sizeOfMatrix
    for j=1:i-1
      push!(listOfEdges,(i,j,matadj[i,j]))
    end
  end
  #println(listOfEdges)
  #println(listOfEdges)

  #println(listOfEdges)
  #list of vertices
  listOfVertices=Array{Float64}(sizeOfMatrix)
  for i=1:sizeOfMatrix
    listOfVertices[i]=i
  end
  #println(listOfVertices)
  #initilisation
  listOfDistances = Array{Float64}(sizeOfMatrix)
  listOfPredecessors = Array{Float64}(sizeOfMatrix)

  for i=1:sizeOfMatrix
    listOfDistances[i]= Inf
    listOfPredecessors[i]=-1 # no predecessor
  end
  listOfDistances[s]=0
  #println(listOfDistances)
  for i=1:size(listOfVertices,1)-1
    for j=1:size(listOfEdges,1)
      (u,v,w)=listOfEdges[j]
      listOfDistances[v] = min(listOfDistances[v],listOfDistances[u] + w)
    end
  end
  #println("passeee")
  #verification ?
  #println(listOfPredecessors)
  println((listOfDistances,listOfPredecessors))
  return (listOfDistances,listOfPredecessors)
end

floydWarshall(1,10,p)

bellmanFord(l,1)
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
j=Float64[0 1 3
          1 0 1
          3 1 0]
f=Float64[0 4 2 0 0 0
          4 0 1 5 0 0
          2 1 0 8 10 0
          0 5 8 0 2 6
          0 0 10 2 0 3
          0 0 0 6 3 0]
l=Float64[0 5 10 1
          5 0 2 0
          10 2 0 1
          1 0 1 0]
#=test = Array{Any}(0)
push!(test,(1,2,3))
push!(test,(4,5,6))
println(test)
(x,y,z) = test[1]
println(x)
=#
