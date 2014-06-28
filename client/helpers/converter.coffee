hoursByDay = 8

@Converter = toDays: (value, from)-> if from is 'h' then value / hoursByDay else value