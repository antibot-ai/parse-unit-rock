---
-- Парсит строку с юнитом и возвращает числовое значение
-- @module parseUnit
local parseUnit

--- Парсит строку с юнитом
-- @param str (string) Строка для парсинга
-- @param[opt] unit_type (string) Тип юнита
  -- ['time', 'number', 'request', 'operation', 'data_size'].
  -- По умолчанию 'number'
-- @return Значение или nil
-- @usage
  -- local value = parseUnit('1h', 'time')
  -- print(value) -- 3600 секунд
function parseUnit(str, unit_type)
  local value, unit = str:match('^(%d+)(.-)$')
  unit_type = unit_type or 'number'

  if not value and not unit then
    return nil
  end

  local raw_unit = unit
  value = tonumber(value)
  unit = unit:lower()

  -- Время
  if unit_type == 'time' then
    -- Минуты
    if raw_unit == 'm' then
      return value * 60
    -- Месяцы
    elseif raw_unit == 'M' then
      return value * 2592000
    end

    if unit == 'ns' then
      return value * 10^-9
    elseif unit == 'us' then
      return value * 10^-6
    elseif unit == 'ms' then
      return value * 0.001
    elseif unit == 's' then
      return value
    elseif unit == 'h' then
      return value * 3600
    elseif unit == 'd' then
      return value * 86400
    elseif unit == 'w' then
      return value * 604800
    elseif unit == 'y' then
      return value * 31536000
    end

  -- Числа
  elseif unit_type == 'number' then
    if unit == 'k' then
      return value * 1000
    elseif unit == 'm' then
      return value * 1000000
    elseif unit == 'b' then
      return value * 10^9
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
    elseif unit == 'mb' then
      return value * 10^6
    elseif unit == 'gb' then
      return value * 10^9
    elseif unit == 'tb' then
      return value * 10^12
    elseif unit == 'pb' then
      return value * 10^15
    elseif unit == 'kib' then
      return value * 1024
    elseif unit == 'mib' then
      return value * 2^20
    elseif unit == 'gib' then
      return value * 2^30
    elseif unit == 'tib' then
      return value * 2^40
    elseif unit == 'pib' then
      return value * 2^50
    end
  end

  return value
end

return parseUnit
