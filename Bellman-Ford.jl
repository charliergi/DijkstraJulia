# Bellman-Ford implementation in Julia
# Created by Antoine Dumont and Gilles Charlier
# ◮ Given a directed weighted graph G and a source s
# ◮ Outputs a vector d where di is the shortest distance from s to node i
# ◮ Can detect a negative-weight cycle
# ◮ Runs in Θ(nm) time
function belFord(matadj,s,i)
  #initialization
  sizeOfMatrix = size(matadj,1)
  println(sizeOfMatrix)
  d=Array{Float64}(sizeOfMatrix)
  for k=1:sizeOfMatrix
    d[k]=Inf
  end
  d[s]=0
  #println(d)
  #println(d)
  for k=1:sizeOfMatrix-1
    #println("passe")
    for u=1:sizeOfMatrix,v=1:sizeOfMatrix
      c=matadj[u,v]
      #println(c)
      d[v] = min(d[v],d[u]+c)
      if u==4 && k==1
        println(d)
      end
      #println(d)
    end
  end
  #println(d)
  for h=1:sizeOfMatrix
    if h==i return d[h]
    end
  end
  return -1
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
println(belFord(l,1,2))
