function swap_rollup(instance)
    if ~isprop(instance, 'Components') || isempty(instance.Components)
        return; 
    end

    isTopLevel = isa(instance, 'systemcomposer.analysis.ArchitectureInstance');
    if isTopLevel
        fprintf('\n--- SWaP Roll-Up Analysis ---\n');
    end

    total_weight = 0;
    total_cost = 0;
    total_volume = 0;
    total_operating_power = 0;
    total_supply_power = 0;
    
    parts_checked = numel(instance.Components);
    parts_used = 0;
    errors = 0;

    for i = 1:parts_checked
        child = instance.Components(i);
        try
            w  = child.getValue('EScooter_Standard.Hardware_Component.Weight');
            c  = child.getValue('EScooter_Standard.Hardware_Component.Cost');
            v  = child.getValue('EScooter_Standard.Hardware_Component.Volume');
            op = child.getValue('EScooter_Standard.Hardware_Component.Operating_Power');
            sp = child.getValue('EScooter_Standard.Hardware_Component.Supply_Power');
            
            if isempty(w) || isnan(w), w = 0; end
            if isempty(c) || isnan(c), c = 0; end
            if isempty(v) || isnan(v), v = 0; end
            if isempty(op) || isnan(op), op = 0; end
            if isempty(sp) || isnan(sp), sp = 0; end
            
            total_weight = total_weight + w;
            total_cost = total_cost + c;
            total_volume = total_volume + v;
            total_operating_power = total_operating_power + op;
            total_supply_power = total_supply_power + sp;
            
            parts_used = parts_used + 1;
        catch ME
            fprintf('[Error] %s: %s\n', child.Name, ME.message);
            errors = errors + 1;
        end
    end

    try
        % Aufsummierte Werte in die Parent-Instanz (das übergeordnete System) schreiben
        instance.setValue('EScooter_Standard.Hardware_Component.Weight', total_weight);
        instance.setValue('EScooter_Standard.Hardware_Component.Cost', total_cost);
        instance.setValue('EScooter_Standard.Hardware_Component.Volume', total_volume);
        instance.setValue('EScooter_Standard.Hardware_Component.Operating_Power', total_operating_power);
        instance.setValue('EScooter_Standard.Hardware_Component.Supply_Power', total_supply_power);
        
        % Ausgabe und automatische Validierung für das Gesamtsystem
        if isTopLevel
            fprintf('=> Analysis Finished.\n');
            fprintf('   Parts checked: %d | Used: %d | Errors: %d\n', parts_checked, parts_used, errors);
            fprintf('   Total Weight: %.2f kg | Total Cost: %.2f EUR\n', total_weight, total_cost);
            fprintf('   Total Volume: %.2f cm³\n', total_volume);
            fprintf('   Operating Power: %.2f W | Supply Power: %.2f W\n', total_operating_power, total_supply_power);
            
            fprintf('\n   --- Automatische System-Validierung ---\n');
            % Validierung Leistung
            if total_supply_power >= total_operating_power && total_supply_power > 0
                fprintf('   [OK] Leistungsbilanz: Batterie liefert ausreichend Energie.\n');
            elseif total_supply_power > 0
                fprintf('   [FAIL] Leistungsbilanz: Verbraucher ziehen mehr Strom als die Batterie liefert!\n');
            end
            
            % Validierung Gewicht (Requirement NF2.1 -> max 20 kg)
            if total_weight <= 20
                 fprintf('   [OK] Gewicht: Systemgewicht ist innerhalb der Toleranz (<= 20kg).\n\n');
            else
                 fprintf('   [FAIL] Gewicht: System überschreitet das Limit von 20kg!\n\n');
            end
        end
    catch ME
        fprintf('[Error] Schreibfehler in %s: %s\n', instance.Name, ME.message);
    end
end