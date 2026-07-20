function ignorehistory --on-event fish_prompt
    history --case-sensitive --exact --delete clear reboot "~" yay

    set history_items (history --search --prefix cd ls ll shutdown history man z)
    for item in $history_items
        history --delete --case-sensitive --exact $item
    end
end
