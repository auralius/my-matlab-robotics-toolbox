function r = cgr_self_update(r, qc)
    r.qc = qc;
    r.T = cgr_fkine(r, qc); 
    r.jac = cgr_jac(r, qc); 
end