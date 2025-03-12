import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FuncFormatter

#задаем диапазон значений от -пи до пи  с шагом 0.01
x = np.arange(-np.pi, np.pi, 0.01)
#вычесляем значение y = 1/2cos(x)
y = 0.5 * np.cos(x)

#создаем график
plt.plot(x, y, label="y = 1/2cos(x)", color="red")

#добавляем подписей осей и заголовок
plt.title("график функции y = 1/2cos(x)")
plt.xlabel("y", fontsize=12 ,fontweight="bold", color="green")
plt.ylabel("x", fontsize=12, fontweight="bold", color="green")
plt.grid(True)#сетка
plt.legend()

# Находим последнее пересечение с осью x (y = 0)
# Ищем индекс, где y меняет знак с положительного на отрицательный
crossing_index = np.where(np.diff(np.sign(y)))[0]
crossing_x = x[crossing_index]
crossing_y = y[crossing_index]

#рисуем засечку пересечения функции
plt.scatter(crossing_x, crossing_x, color="black", zorder=5)#делает точку поверх графика


ax = plt.gca()

# Устанавливаем диапазон оси x от -π до π
ax.set_xlim(-np.pi, np.pi)
ax.xaxis.set_major_locator(MultipleLocator(base=np.pi / 2))#основные деления

#форматируем ось х
def format_func(value, tick_number):
    fractions = {
        -np.pi: r"$-\pi$",
        -np.pi / 2: r"$-\pi/2$",
        0: r"$0$",
        np.pi / 2: r"$\pi/2$",
        np.pi: r"$\pi$",
    }
    return fractions.get(value, "")

ax.xaxis.set_major_formatter(FuncFormatter(format_func))#принимаем

ax.axhline(0, color="green", linewidth=2)#ось х
ax.axvline(0, color="green", linewidth=2)#ось у

plt.show()