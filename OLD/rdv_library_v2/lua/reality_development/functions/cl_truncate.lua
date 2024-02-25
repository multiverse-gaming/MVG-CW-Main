function RDV.LIBRARY.TruncateString(s,w)
    local ellipsis = "…"
    local n_ellipsis = utf8.len(ellipsis)

    if utf8.len(s) > w then
        return s:sub(1, utf8.offset(s, w - n_ellipsis + 1) - 1) .. ellipsis
    end
    return s
end