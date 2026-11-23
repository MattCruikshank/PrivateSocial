-- Rewrite relative links to .md files so they point at the generated .html,
-- keeping any #anchor. Absolute URLs (scheme://) are left alone.
function Link(el)
  local t = el.target
  if not t:match("^%a[%w+.-]*:") then
    t = t:gsub("%.md$", ".html"):gsub("%.md#", ".html#")
    el.target = t
  end
  return el
end
