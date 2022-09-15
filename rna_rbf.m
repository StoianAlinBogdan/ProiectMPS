clc;
clear all;
close all;

SPREAD = [1 10 0.1];
EXAMPLES = [10 100];
GOAL = [0.0001 0];

% algoritmul in cazul functiei newrb
for i = 0:length(SPREAD)-1
    for j = 0:length(EXAMPLES)-1
        for k = 0:length(GOAL)-1
            spread = SPREAD(i + 1);      % spread
            examples = EXAMPLES(j + 1);  % numarul de exemple in setul de antrenare
            goal = GOAL(k + 1);          % eroarea maxima admisa (goal)

            fprintf("Cazul %g: SPREAD = %g; EXAMPLES = %g; GOAL = %g\n", i*4 + j*2 + k + 1, spread, examples, goal);

            dataset = linspace(0, 2*pi, examples);   % setul de date de marime 'examples'
            values = sin(dataset) .* sin(dataset);   % valorile functiei pentru setul de date

            net = newrb(dataset, values, goal, spread, 50, 2);   % crearea retelei de tip RBF
            fprintf("Parametrii retelei: \n");
            display(net.IW);
            display(net.LW);
            display(net.b);

            test_set = 0:0.001:2*pi;            % setul de date de testare
            test_values = sin(test_set) .* sin(test_set); % valorile functiei pentru setul de testare

            sim_result = sim(net, test_set);              % rezultatele simularii
            
            % afisarea rezultatelor
            figure(1);
            subplot(3, 4, i*4 + j*2 + k + 1);
            plot(test_set, test_values);
            hold on;
            plot(test_set, sim_result);
            title({['SPREAD = ', num2str(spread),' EX = ', num2str(examples)]; [' GOAL = ', num2str(goal), ' ']});
            hold on;
        end
    end
end

% algoritmul in cazul functiei newrbe
for i = 0:length(SPREAD)-1
    for j = 0:length(EXAMPLES)-1
        spread = SPREAD(i + 1);      % spread
        examples = EXAMPLES(j + 1);  % numarul de exemple in setul de antrenare

        fprintf("Cazul %g: SPREAD = %g; EXAMPLES = %g;", i*2 + j + 1, spread, examples);

        dataset = linspace(0, 2*pi, examples);   % setul de date de marime 'examples'
        values = sin(dataset) .* sin(dataset);   % valorile functiei pentru setul de date

        net = newrbe(dataset, values, spread);   % crearea unei retele de tip RBF exacte
        fprintf("Parametrii retelei: \n");
        display(net.IW);
        display(net.LW);
        display(net.b);

        test_set = 0:0.001:2*pi;            % setul de date de testare
        test_values = sin(test_set) .* sin(test_set); % valorile functiei pentru setul de testare

        sim_result = sim(net, test_set);              % rezultatele simularii
        
        % afisarea rezultatelor
        figure(2);
        subplot(3, 2, i*2 + j + 1);
        plot(test_set, test_values);
        hold on;
        plot(test_set, sim_result);
        title(['SPREAD = ', num2str(spread),' EX = ', num2str(examples)]);
        hold on;
    end
end

% Observam ca o valoarea mai mare pentru SPREAD ajuta la acuratetea
% prezicerilor retelei neurale atat in cazul retelei newrb dar si newrbe.
% Totusi, chiar si cu o valoare mica pentru SPREAD (0.1) putem obtine
% rezultate bune daca numarul de exemple in setul de antrenament este 
% relativ mare (100). Putem observa in ambele cazuri ca daca numarul de
% exemple este mic (10), si spread-ul mic (0.1), reteua nu poate prezice
% deloc cum arata functia

% In cazul newrb, un numar adecvat de neuroni variaza intre 10 si 50,
% depinzand de spread, goal si numarul de exemple

