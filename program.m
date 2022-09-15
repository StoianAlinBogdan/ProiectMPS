S=[2 4 8]
N=[10 100]
LR=[.01 .1 .3]
EPCHS=[150 250 500]

% x y
% 
test=0:2*pi/10:2*pi
expected=sin(test).*sin(test)

for k=1:length(S)
    for l=1:length(N)
        for m=1:length(LR)
            for n=1:length(EPCHS)
                i=(2*pi)/N(l); % pasul de iterare
                x=i:i:2*pi; % vectorul input/intervalul
                %x=2*(x-1)*(pi/N(l));
                y=sin(x).*sin(x); % targetul-funcția de minimizat
                net=newff(x,y,S(k),{'tansig'}, 'trainlm'); % crează o rețea neuronală de tip feed-forward
                net.trainparam.epochs=EPCHS(n); % numărul de epoci de antrenare
                net.trainparam.goal=1e-10; % eroarea de aproximare--se mai numește și scop
                net.trainparam.lr=LR(m); 
                net=train(net,x,y); %
                fprintf("Nr. neuroni %d\n", S(k));
                fprintf("N: %d\n", N(l));
                fprintf("Learning rate %d\n", LR(m));
                fprintf("NR. epochs %d\n", EPCHS(n));
                
                expected
                aux=net(test)
                %aux
                %x=input('treci la urmatoarea iteratie?');
            end
        end
    end
end




