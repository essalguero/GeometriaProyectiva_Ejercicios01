%Este ejercicio se ha dejado definido como una función que es utilizada por el
%apartado 3e. AL ejecutar ese ejercicio, se puede ver la matriz de la cámara

% P = KR[I3 | - C]

function P = Problema03_d (C, Pantalla)

f = Pantalla(1);

K = [1, 0, 0; 0, f, 0; 0, 0, f];

angulo = pi / 2;

mRotZ = [cos(angulo), -sin(angulo), 0, 0;
     sin(angulo), cos(angulo), 0, 0
     0, 0, 1, 0;
     0, 0, 0, 1];
     
mRotY = [cos(angulo), 0, sin(angulo), 0;
     0, 1, 0, 0;
     -sin(angulo), 0, cos(angulo), 0
     0, 0, 0, 1];
     
I3C = eye(3, 4);

I3C(1:3, 4) = -C;


P = K * mRotY(1:3, 1:3) * I3C