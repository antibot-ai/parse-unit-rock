---
-- Парсит строку с юнитами и возвращает числовое значение
local parseUnit

---
-- @param str Строка для парсинга
-- @return Значение или nil
function parseUnit(str)
  local value, unit = str:match('^(%d+)(.-)$')

  if not value and not unit then
    return nil
  end

  value = tonumber(value)
  unit = unit:lower()

  -- Числительные
  if unit == 'k' then
    return value * 1000
  elseif unit == 'm' then
    return value * 1000000

  -- Время
  elseif unit == 's' then
    return value
  elseif unit == 'm' then
    return value * 60
  elseif unit == 'h' then
    return value * 3600

  -- Запросы
  elseif unit == 'rps' then
    return value, 1
  elseif unit == 'rpm' then
    return value, 60
  elseif unit == 'rph' then
    return value, 3600

  -- Операции
  elseif unit == 'ops' then
    return  value, 1
  elseif unit == 'opm' then
    return  value, 60
  elseif unit == 'oph' then
    return  value, 3600

  -- Объем информации
  elseif unit == 'b' then
    return value
  elseif unit == 'kb' then
    return value * 1000
  elseif unit == 'kib' then
    return value * 1024
  elseif unit == 'mb' then
    return value * 1000000
  elseif unit == 'mib' then
    return value * 1048576
  end

  return nil
end

return parseUnit
