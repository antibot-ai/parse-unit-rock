-- test/validation.lua
local luatest = require('luatest')
local g = luatest.group('validation')

-- Функция парсинга юнитов
local parseUnit = require('lua.parse-unit.init')

-- Тесты
--
-- Парсинг времени
g.test_time = function()
  -- 1 секунда равна 10^9 или 1.000.000.000 наносекунд
  luatest.assert_equals(parseUnit('1000000000ns', 'time'), 1)
  -- 1 секунда равна 10^6 или 1.000.000 микросекунд
  luatest.assert_equals(parseUnit('1000000us', 'time'), 1)
  -- 1 секунда равна 10^3 или 1.000 микросекунд
  luatest.assert_equals(parseUnit('1000ms', 'time'), 1)
  -- 1 секунда равна 1 секунде
  luatest.assert_equals(parseUnit('1s', 'time'), 1)

  -- 1 минута равна 60 секунд
  luatest.assert_equals(parseUnit('1m', 'time'), 60)
  -- 1 час равен 3600 секунд
  luatest.assert_equals(parseUnit('1h', 'time'), 3600)
  -- 1 день равен 86400 секунд
  luatest.assert_equals(parseUnit('1d', 'time'), 86400)
  -- 1 неделя равен 604800 секунд
  luatest.assert_equals(parseUnit('1w', 'time'), 604800)
  -- 1 неделя равен 2592000 секунд
  luatest.assert_equals(parseUnit('1M', 'time'), 2592000)

  -- Согласно https://nginx.org/en/docs/syntax.html
  --
  -- 1 месяц равен 2592000 секунд
  luatest.assert_equals(parseUnit('1M', 'time'), 2592000)
  -- 1 год равен 31536000 секунд
  luatest.assert_equals(parseUnit('1y', 'time'), 31536000)
end

-- Парсинг целочисленных значений
g.test_number = function()
  luatest.assert_equals(parseUnit('10'), 10)
  luatest.assert_equals(parseUnit('123', 'number'), 123)

  -- 10k это 10.000
  luatest.assert_equals(parseUnit('10k', 'number'), 10000)
  -- 10m это 10.000.000 или 10^7
  luatest.assert_equals(parseUnit('10m', 'number'), 10^7)
  -- 10b это 10.000.000.000 или 10^10
  luatest.assert_equals(parseUnit('10b', 'number'), 10^10)
end

-- Парсинг запросов
g.test_request = function()
  -- 10orps это 10, 1
  local val, time = parseUnit('10rps', 'request')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 1)

  -- 10rpm это 10, 60
  local val, time = parseUnit('10rpm', 'request')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 60)

  -- 10rph это 10, 3600
  local val, time = parseUnit('10rph', 'request')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 3600)
end

-- Парсинг операций
g.test_operation = function()
  -- 10ops это 10, 1
  local val, time = parseUnit('10ops', 'operation')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 1)

  -- 10opm это 10, 60
  local val, time = parseUnit('10opm', 'operation')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 60)

  -- 10oph это 10, 3600
  local val, time = parseUnit('10oph', 'operation')
  luatest.assert_equals(val, 10)
  luatest.assert_equals(time, 3600)
end

-- Парсинг объёма информации
g.test_data_size = function()
  -- 10 байт это 10 байт
  luatest.assert_equals(parseUnit('10b', 'data_size'), 10)

  -- Десятичная система префиксов
  --
  -- 1 килобайт (KB) это 1000 10^3 байт
  luatest.assert_equals(parseUnit('1kb', 'data_size'), 10^3)
  -- 1 мегабайт (MB) это 1.000.000 10^6 байт
  luatest.assert_equals(parseUnit('1mb', 'data_size'), 10^6)
  -- 1 гигабайт (GB) это 1.000.000.000 10^9 байт
  luatest.assert_equals(parseUnit('1gb', 'data_size'), 10^9)
  -- 1 терабайт (TB) это 1.000.000.000.000 10^12 байт
  luatest.assert_equals(parseUnit('1tb', 'data_size'), 10^12)
  -- 1 петабайт (PB) это 1.000.000.000.000.000 10^15 байт
  luatest.assert_equals(parseUnit('1PB', 'data_size'), 10^15)

  -- Двоичная система префиксов
  --
  -- 1 кибибайт (KiB) = 1024 2^10 байт
  luatest.assert_equals(parseUnit('1kib', 'data_size'), 2^10)
  -- 1 мебибайт (MiB) = 1.048.576 2^20 байт
  luatest.assert_equals(parseUnit('1mib', 'data_size'), 2^20)
  -- 1 гибибайт (GiB) = 1.073.741.824 2^30 байт
  luatest.assert_equals(parseUnit('1gib', 'data_size'), 2^30)
  -- 1 тебибайт (TiB) = 1.099.511.627.776 2^40 байт
  luatest.assert_equals(parseUnit('1tib', 'data_size'), 2^40)
  -- 1 пебибайт (PiB) = 1.125.899.906.842.624 2^50 байт
  luatest.assert_equals(parseUnit('1pib', 'data_size'), 2^50)
end
