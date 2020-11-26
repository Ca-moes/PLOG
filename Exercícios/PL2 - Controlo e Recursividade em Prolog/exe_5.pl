e_primo(2). % 2 é primo
e_primo(3). % 3 é primo

% um numero é primo se os unicos divisores forem 1 e ele próprio
e_primo(P) :- integer(P),           % tem de ser inteiro para ser primo
                P > 3,              % tem de ser > que 3 [1 e 2 estão verificados]
                P mod 2 =\= 0,      % não pode ser Par AKA divisivel por 2
                \+tem_factor(P,3).  % começo de verificação se tem divisores / verifica até encontrar divisor ou o numero que verifica ao quadrado é > que o numero a testar se é primo
tem_factor(N,L) :- N mod L =:= 0.   % se N for divisivel por L -> Não é primo
tem_factor(N,L) :-                  % se não for divisivel...
                    L * L < N,      % enquanto que o proximo numero ^2 pela qual se va dividir for menor que o numero a testar...
                    L2 is L + 2,    % determina o próximo número pela qual vai dividir, que será o próximo impar
                    tem_factor(N,L2).   % testa o proximo fator