% Solucion al segundo ejercicio.
% Las instrucciones para dibujar los pasos intermedios han sido comentadas
% y sólo se representan el objeto inicial y final
% Se pueden descomentar las lineas 37-38, 43-44 y 67-68 si se quiere revisar el 
% proceso seguido

clf;
clear;

pkg load geometry


% Datos del problema
anguloRotacion = pi / 4
vTraslacion = [-1, -1, -1]
centroEsfera = [0, -3, 1]

%Parte 1 - antes de la reflexion

sphereObject = drawSphere([centroEsfera 1], 'linestyle', ':', 'facecolor', 'green');
hold on

% Definir matriz Rotacion
mRotZ = [cos(anguloRotacion), -sin(anguloRotacion), 0, 0; ...
         sin(anguloRotacion), cos(anguloRotacion), 0, 0; ...
         0, 0, 1, 0; ...
         0, 0, 0, 1];

% Definir matriz Traslación
mTraslacion = eye(4, 4);
mTraslacion(1:3, 4) = vTraslacion';

% Obtener primera matriz - Transformación Rotación pi/4 + traslación [-1, -1, -1]
mStep1 = mRotZ;

centroEsfera1 = mStep1 * [centroEsfera, 1]';

%sphereObject = drawSphere([centroEsfera1(1:3)' 1], 'linestyle', ':', 'facecolor', 'blue');
%hold on


mStep2 = mTraslacion;
centroEsfera2 = mStep2 * centroEsfera1;
%sphereObject = drawSphere([centroEsfera2(1:3)' 1], 'linestyle', ':', 'facecolor', 'cyan');
%hold on


% Parte 2 - Reflexion
% Plano x - y = 0
% Angulo plano - ejes = -45 grados = -pi/4 radianes -> negativo porque es sentido horario



anguloRotReflexion = -pi/4;

mRotZReflexion = [cos(anguloRotReflexion), -sin(anguloRotReflexion), 0, 0; ...
                  sin(anguloRotReflexion), cos(anguloRotReflexion), 0, 0; ...
                  0, 0, 1, 0; ...
                  0, 0, 0, 1];

mReflexionZ = eye(4, 4);
mReflexionZ(1, 1) = -1;

mStep3 = mReflexionZ * mRotZReflexion;

centroEsfera3 = mStep3 * centroEsfera2;

%sphereObject = drawSphere([centroEsfera3(1:3)' 1], 'linestyle', ':', 'facecolor', 'yellow')
%hold on


% Parte 3 - Girar para compensar que la rotación no se ha hecho respecto al plano deseado - girar 180 grados negativos respecto z

%El angulo a rotar es 180 en sentido horario menos lo que ya se ha rotado
%antes (45) para poder hacer la reflexion respecto al plano ZY
anguloRotCorreccion = -pi + pi/4
mRotZCorreccion = [cos(anguloRotCorreccion), -sin(anguloRotCorreccion), 0, 0; ...
                   sin(anguloRotCorreccion), cos(anguloRotCorreccion), 0, 0; ...
                   0, 0, 1, 0; ...
                   0, 0, 0, 1];

mStep4 = mRotZCorreccion;
centroEsfera4 = mStep4 * centroEsfera3

sphereObject = drawSphere([centroEsfera4(1:3)' 1], 'linestyle', ':', 'facecolor', 'red');

hold off

xlabel('x')
ylabel('y')
zlabel('z')


matrizTransformaciones = mStep4 * mStep3 * mStep2 * mStep1