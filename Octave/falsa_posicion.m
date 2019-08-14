pkg load symbolic

%{
Funcion que se encarga de calcular el xk+1 utilizando el metodo de la secante
:param funcion: funcion que se debe evaluar
:param xk: xk de la iteracion anterior
:param ck: limite izquierdo del intervalo si se seleeciona [ak, xk],
           limite derecho del intervalo si se selecciona [xk, ck]
%}
function [xk1] = xkSecante(funcion, xk, ck)
    %Se calcula el xk+1 utilizando el metodo de la secante
    xk1 = xk - (funcion(xk) * (xk - ck)) / (funcion(xk) - funcion(ck));
end % xkSecante(funcion, xk, ck)

%{
Funcion que implementa el metodo de la falsa posicion para encontrar el cero de una funcion
:param f: funcion que se debe evaluar
:param a: limite izquierdo del intervalo
:param b: limite derecho del intervalo
:param tol: tolerancia al fallo que debe tener el resultado, debe ser un numero que se encuentre entre cero y uno
%}
function [xAprox, iter] = falsa_posicion(f, a, b, tol)
    funcion = matlabFunction(sym(f)); %Se obtiene la funcion ingresada por el usuario
    itr = 0; %Se inicializa el contador
    xk = xkSecante(funcion, b, a); %Se calcula el xk inicial

    intervalo0 = funcion(a) * funcion(b); %Se verifica si en el intervalo existe un cero
    if ~(intervalo0 < 0)
        xAprox = "La funcion no garantiza la existencia de un cero en el intervalo ingresado";
        iter = 0;
    end % ~(intervalo0 < 0)

    while 1
        %Se verifica la condicion de parada
        if abs(funcion(xk)) <= tol
            break;
        end % abs(funcion(xk)) <= tol

        %Se verifica si en el primer intervalo se garantiza la existencia de un cero
        intervalo1 = funcion(a) * funcion(xk);
        if intervalo1 < 0
            b = xk; %Se define el nuevo limite derecho
            itr = itr + 1; %Se aumenta el contador de iteraciones
            xk = xkSecante(funcion, xk, a); %Se calcula el nuevo xk

        else
            a = xk; %Se define el nuevo limite izquierdo
            itr = itr + 1; %Se aumenta el contador de iteraciones
            xk = xkSecante(funcion, xk, b); %Se calcula el nuevo xk
        end % intervalo1 < 0
    end % while 1

        %Se retornan los valores obtenidos
        xAprox = xk;
        iter = itr;

end %falsa_posicion(f, a, b, tol)

%[xAprox, iter] = falsa_posicion('cos(x)-x', 1/2, pi, 10^-5)
%[xAprox, iter] = falsa_posicion('exp(2*x) - 10 - log(x/2)', 1, 1.2, 10^-2)
