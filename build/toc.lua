-- Insert a "Contents" list of the document's ## sections just before the
-- first ## heading, so it sits below the title and introduction.
function Pandoc(doc)
  local items, first = {}, nil
  for i, block in ipairs(doc.blocks) do
    if block.t == "Header" and block.level == 2 then
      first = first or i
      table.insert(items, { pandoc.Plain({ pandoc.Link(block.content, "#" .. block.identifier) }) })
    end
  end
  if #items < 2 then return doc end
  local toc = pandoc.Div({
    pandoc.Para({ pandoc.Strong({ pandoc.Str("Contents") }) }),
    pandoc.BulletList(items),
  }, pandoc.Attr("", { "toc" }))
  doc.blocks:insert(first, toc)
  return doc
end
