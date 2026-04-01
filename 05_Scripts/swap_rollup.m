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
    parts_checked = numel(instance.Components);
    parts_used = 0;
    errors = 0;

    for i = 1:parts_checked
        child = instance.Components(i);
        try
            w = child.getValue('EScooter_Standard.Hardware_Component.Weight');
            c = child.getValue('EScooter_Standard.Hardware_Component.Cost');
            
            if isempty(w) || isnan(w), w = 0; end
            if isempty(c) || isnan(c), c = 0; end
            
            total_weight = total_weight + w;
            total_cost = total_cost + c;
            parts_used = parts_used + 1;
        catch ME
            fprintf('[Error] %s: %s\n', child.Name, ME.message);
            errors = errors + 1;
        end
    end

    try
        instance.setValue('EScooter_Standard.Hardware_Component.Weight', total_weight);
        instance.setValue('EScooter_Standard.Hardware_Component.Cost', total_cost);
        
        if isTopLevel
            fprintf('=> Analysis Finished.\n');
            fprintf('   Parts checked: %d | Used: %d | Errors: %d\n', parts_checked, parts_used, errors);
            fprintf('   Total Weight: %.2f kg | Total Cost: %.2f EUR\n\n', total_weight, total_cost);
        end
    catch ME
        fprintf('[Error] Schreibfehler in %s: %s\n', instance.Name, ME.message);
    end
end