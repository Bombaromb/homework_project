[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

Set-Location 'D:\homework_project'

if (-not (Test-Path '08.11.26')) {
    New-Item -ItemType Directory -Path '08.11.26' -Force | Out-Null
}

Set-Location '08.11.26'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$files = @{
    'Transport.java' = @'
public interface Transport {
    double getSpeed();
    double getCostPerKm();
}
'@
    'Bicycle.java' = @'
public class Bicycle implements Transport {
    @Override
    public double getSpeed() {
        return 15.0;
    }

    @Override
    public double getCostPerKm() {
        return 10.0;
    }

    @Override
    public String toString() {
        return "Велосипед";
    }
}
'@
    'Car.java' = @'
public class Car implements Transport {
    @Override
    public double getSpeed() {
        return 50.0;
    }

    @Override
    public double getCostPerKm() {
        return 25.0;
    }

    @Override
    public String toString() {
        return "Автомобиль";
    }
}
'@
    'Product.java' = @'
public class Product {
    private final String name;
    private final double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
}
'@
    'Courier.java' = @'
public class Courier {
    private final String name;
    private final Transport transport;
    private final Product[] products;

    public Courier(String name, Transport transport, Product[] products) {
        this.name = name;
        this.transport = transport;
        this.products = products;
    }

    public String getName() {
        return name;
    }

    public Transport getTransport() {
        return transport;
    }

    public Product[] getProducts() {
        return products.clone();
    }
}
'@
    'DeliveryTime.java' = @'
public final class DeliveryTime {
    private static final double EXTRA_MINUTES = 15.0;

    private DeliveryTime() {
    }

    public static double calculateMaxMinutes(double distance, double speed) {
        if (distance < 0) {
            throw new IllegalArgumentException("Расстояние не может быть отрицательным");
        }
        if (speed <= 0) {
            throw new IllegalArgumentException("Скорость должна быть положительной");
        }
        return (distance / speed) * 60.0 + EXTRA_MINUTES;
    }
}
'@
    'DeliveryOrder.java' = @'
public class DeliveryOrder {
    private final Courier courier;
    private final Product product;
    private final double distance;
    private final double deliveryCost;
    private final double timeInMinutes;

    public DeliveryOrder(Courier courier, Product product, double distance) {
        this.courier = courier;
        this.product = product;
        this.distance = distance;
        this.deliveryCost = courier.getTransport().getCostPerKm() * distance;
        this.timeInMinutes = DeliveryTime.calculateMaxMinutes(distance, courier.getTransport().getSpeed());
    }

    public Courier getCourier() {
        return courier;
    }

    public Product getProduct() {
        return product;
    }

    public double getDistance() {
        return distance;
    }

    public double getDeliveryCost() {
        return deliveryCost;
    }

    public double getTimeInMinutes() {
        return timeInMinutes;
    }

    public void printInfo() {
        System.out.println("--- Информация о доставке ---");
        System.out.println("Товар: " + product.getName() + " (" + product.getPrice() + " руб.)");
        System.out.println("Курьер: " + courier.getName());
        System.out.println("Транспорт курьера: " + courier.getTransport());
        System.out.println("Расстояние: " + distance + " км");
        System.out.println("Стоимость доставки: " + deliveryCost + " руб.");
        System.out.println("Максимальное время ожидания: " + (int) Math.ceil(timeInMinutes) + " мин.");
        System.out.println("-----------------------------");
    }
}
'@
    'Main.java' = @'
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Transport bike = new Bicycle();
        Transport car = new Car();

        Product[] ivanProducts = {
            new Product("Пицца Маргарита", 450),
            new Product("Кока-Кола", 100)
        };

        Product[] annaProducts = {
            new Product("Суши Сет", 1200),
            new Product("Вок с курицей", 350)
        };

        Courier[] couriers = {
            new Courier("Иван", bike, ivanProducts),
            new Courier("Анна", car, annaProducts)
        };

        List<DeliveryOrder> history = new ArrayList<>();

        while (true) {
            System.out.println();
            System.out.println("=== СЛУЖБА ДОСТАВКИ ===");
            System.out.println("1. Сделать заказ");
            System.out.println("2. Показать историю доставок");
            System.out.println("3. Выйти");
            System.out.print("Выберите действие: ");

            int choice = readInt(scanner);

            if (choice == 1) {
                createOrder(scanner, couriers, history);
            } else if (choice == 2) {
                printHistory(history);
            } else if (choice == 3) {
                System.out.println("Выход из программы.");
                break;
            } else {
                System.out.println("Неверная команда, попробуйте еще раз.");
            }
        }

        scanner.close();
    }

    private static void createOrder(Scanner scanner, Courier[] couriers, List<DeliveryOrder> history) {
        System.out.println("\nДоступные курьеры и их меню:");
        for (int i = 0; i < couriers.length; i++) {
            System.out.println((i + 1) + ". Курьер " + couriers[i].getName()
                    + " (Транспорт: " + couriers[i].getTransport() + ")");
        }
        System.out.print("Выберите цифру курьера: ");
        int courierIndex = readInt(scanner) - 1;

        if (courierIndex < 0 || courierIndex >= couriers.length) {
            System.out.println("Неверный выбор!");
            return;
        }

        Courier selectedCourier = couriers[courierIndex];
        Product[] products = selectedCourier.getProducts();

        System.out.println("\nПродукты у курьера " + selectedCourier.getName() + ":");
        for (int i = 0; i < products.length; i++) {
            System.out.println((i + 1) + ". " + products[i].getName() + " — " + products[i].getPrice() + " руб.");
        }
        System.out.print("Выберите цифру продукта: ");
        int productIndex = readInt(scanner) - 1;

        if (productIndex < 0 || productIndex >= products.length) {
            System.out.println("Неверный выбор!");
            return;
        }

        Product selectedProduct = products[productIndex];

        double distance = readPositiveDouble(scanner, "Введите расстояние до вас (в км): ");

        DeliveryOrder order = new DeliveryOrder(selectedCourier, selectedProduct, distance);
        order.printInfo();
        history.add(order);
    }

    private static void printHistory(List<DeliveryOrder> history) {
        System.out.println("\n=== ИСТОРИЯ ДОСТАВОК ===");
        if (history.isEmpty()) {
            System.out.println("История пуста.");
        } else {
            for (int i = 0; i < history.size(); i++) {
                DeliveryOrder order = history.get(i);
                System.out.println((i + 1) + ". Товар: " + order.getProduct().getName()
                        + " | Курьер: " + order.getCourier().getName()
                        + " | Цена доставки: " + order.getDeliveryCost() + " руб.");
            }
        }
        System.out.println("========================");
    }

    private static int readInt(Scanner scanner) {
        while (true) {
            String line = scanner.nextLine().trim();
            try {
                return Integer.parseInt(line);
            } catch (NumberFormatException e) {
                System.out.print("Пожалуйста, введите целое число: ");
            }
        }
    }

    private static double readPositiveDouble(Scanner scanner, String prompt) {
        System.out.print(prompt);
        while (true) {
            String line = scanner.nextLine().trim().replace(',', '.');
            try {
                double value = Double.parseDouble(line);
                if (value <= 0) {
                    System.out.print("Расстояние должно быть больше нуля. Повторите ввод: ");
                    continue;
                }
                return value;
            } catch (NumberFormatException e) {
                System.out.print("Пожалуйста, введите число: ");
            }
        }
    }
}
'@
}

foreach ($file in $files.GetEnumerator()) {
    [System.IO.File]::WriteAllText($file.Key, $file.Value, $utf8NoBom)
}

Set-Location '..'

[System.IO.File]::WriteAllText('.gitattributes', "*.java linguist-detectable`n*.py linguist-undetectable", $utf8NoBom)
[System.IO.File]::WriteAllText('.gitignore', "out/`nbin/`n*.class`n*.jar`n*.war`n.idea/`n*.iml`n.vscode/`ntarget/`nThumbs.db`nDesktop.ini`n.DS_Store", $utf8NoBom)

Write-Host 'Файлы успешно созданы!' -ForegroundColor Green