import JSON

println("HINES MATRIX TEST")

function loadMatrix(s)
    JSON.parsefile(s)
end

function backward(l_,d_,u_,rhs_,p_)
    for i = length(rhs_)-1:-1:1 
        factor = l_[i] / d_[i];
        d_[p_[i]+1]   -= factor * u_[i];
        rhs_[p_[i]+1] -= factor * rhs_[i];
    end
    #println("RHS FINAL")
    #println(rhs_)
end

function forward(l_,d_,u_,rhs_,p_)
    rhs_[1] /= d_[1]
    for i = 2:length(rhs_)
        rhs_[p_[i]+1] -= u_[i] * rhs_[i];
        rhs_[p_[i]+1] /= d_[i];
    end
end

matrix = loadMatrix("matrix.json")
#println(matrix["rhs"])

#backward(matrix["l"],matrix["d"],matrix["u"],matrix["rhs"],matrix["p"])
#println(matrix["rhs"])

forward(matrix["l"],matrix["d"],matrix["u"],matrix["rhs"],matrix["p"])
println(matrix["rhs"])

println(matrix["v"])





