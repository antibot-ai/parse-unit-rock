# Парсинг юнитов
Парсит строку, содержащую единицу измерения, и возвращает её числовое значение.

### Параметры
- **str** (строка): Строка для парсинга
- **unit_type** (строка [опционально]): Тип единицы измерения для парсинга (по умолчанию 'number')
   - `'time'` - Время. Единица измерения - секунды
   - `'number'` - Числа. Единица измерения - целочисленные значения
   - `'request'` - Запросы. Единица измерения - секунды
   - `'operation'` - Операции. Единица измерения - секунды
   - `'data_size'` - Объем информации. Единица измерения - байты

# Установка
### tarantool
```bash
tt rocks install --only-server=https://rocks.antibot.ru parse-unit
```
### luarocks
```bash
luarocks install --server=https://rocks.antibot.ru parse-unit
```

# Использование
```lua
local parseUnit = require('parseUnit')

local value = parseUnit('1h', 'time')
print(value) -- 3600 секунд
```

# Генерация ldoc
```bash
ldoc -s '!new' -d ldoc lua
```

# Тестирование
```bash
luatest test/*
```
