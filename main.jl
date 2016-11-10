import JSON

println("HINES MATRIX TEST")

function loadMatrix(s)
    JSON.parsefile(s)
end

function backward(l_,d_,u_,rhs_,p_)
    for i = length(rhs_):-1:2
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
        rhs_[i] -= u_[i] * rhs_[p_[i]+1];
        rhs_[i] /= d_[i];
    end
end

function error(out,sol)
    error = Array{Float64}(length(out));
    for i=1:length(out)
        error[i]=sol[i]-out[i];
    end
    return error;
end

function HMCheck(cell_file)

    control = true;
    matrix = loadMatrix(cell_file);
    backward(matrix["l"],matrix["d"],matrix["u"],matrix["rhs_"],matrix["p"])
    forward(matrix["l"],matrix["d"],matrix["u"],matrix["rhs_"],matrix["p"])
    verror = error(matrix["rhs_"],matrix["sol"])
    for i=1:length(verror)
        if abs(verror[i]) > 5.0e-9
            println("The solution is not correct based on our precision requeriments");
            control = false;
            break;
        end
    end
    if control
        println("TEST PASSED")
    else 
        println("TEST FAILED")
    end
end


HMCheck("matrix_1_cell.json")




