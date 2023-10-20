---
-- Парсит строку с юнитами и возвращает числовое значение
local parseUnit

---
-- @param str Строка для парсинга
-- @param unit_type Тип юнита -
-- 'time', 'number', 'request', 'operation', 'data_size'
-- @return Значение или nil
function parseUnit(str, unit_type)
  local value, unit = str:match('^(%d+)(.-)$')

  if not value and not unit then
    return nil
  end

  value = tonumber(value)
  unit = unit:lower()

  -- Время
  if unit_type == 'time' then
    if unit == 'ms' then
      return value * 0.001
    elseif unit == 's' then
      return value
    elseif unit == 'm' then
      return value * 60
    elseif unit == 'h' then
      return value * 3600
    elseif unit == 'd' then
      return value * 86400
    elseif unit == 'w' then
      return value * 604800
    end

  -- Числительные
  elseif unit_type == 'number' then
    if unit == 'k' then
      return value * 1000
    elseif unit == 'm' then
      return value * 1000000
    elseif unit == 'b' then
      return value *  1000000000
    end

  -- Запросы
  elseif unit_type == 'request' then
    if unit == 'rps' then
      return value, 1
    elseif unit == 'rpm' then
      return value, 60
    elseif unit == 'rph' then
      return value, 3600
    end

  -- Операции
  elseif unit_type == 'operation' then
    if unit == 'ops' then
      return  value, 1
    elseif unit == 'opm' then
      return  value, 60
    elseif unit == 'oph' then
      return  value, 3600
    end

  -- Объем информации
  elseif unit_type == 'data_size' then
    if unit == 'b' then
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
  end

  return nil
end

return parseUnit
