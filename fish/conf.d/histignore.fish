function ignorehistory --on-event fish_prompt
    history --case-sensitive --exact --delete clear reboot "~" yay

    set history_items (history --search --prefix cd ls shutdown history)
    for item in $history_items
        history --delete --case-sensitive --exact $item
    end
end
