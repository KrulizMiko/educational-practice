using Plots
gr()

# Определения функции
function y(x)
    return x^2 * cos(1 / (x + 2))
end


# Создания массива значений х
x_values = range(-5, 2, length=1000) # Избегаем x = -2, так как знаменатель станет нулевым

# Вычисление соответствующих значений y
y_values = y.(x_values)

# Построение графика
p = plot(x_values, y_values, label="y = x^2 cos(1/(x+2))", xlabel="x", ylabel="y", title="График функции", 
linewidth=2, color=:blue, legend=:topright, grid=true,
xlims=(-5, 2), ylims=(-6, 5))  # Задаём масштаб осей

# Выделение осей x и y
hline!([0], label="", color=:black, linestyle=:dash, linewidth=2)  # Горизонтальная линия (ось x)
vline!([0], label="", color=:black, linestyle=:dash, linewidth=2)  # Вертикальная линия (ось y)

# Постепенное добавление точек
for i in 1:length(x_values)
    scatter!([x_values[i]], [y_values[i]], label="", color=:red)  # Добавляем точку
    sleep(0.1)  # Задержка в 0.1 секунды
    gui()  # Обновляем график
end


Plots.display(p)#принудительно открыть окно с графиком
gui()#удерживаем окно открытым

println("нажмми enter")
readline()