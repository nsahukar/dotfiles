---Pretty print lua table
function P(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end
