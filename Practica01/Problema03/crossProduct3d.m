function retval = crossProduct3d(vectorA, vectorB)
  m1 = [0, -vectorA(3), vectorA(2); ... 
        vectorA(3), 0, -vectorA(1); ...
        -vectorA(2), vectorA(1), 0];
  
  retval = m1 * vectorB;
endfunction

