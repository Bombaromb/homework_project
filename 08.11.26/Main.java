import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Transport bike = new Bicycle();
        Transport car = new Car();
        Product[] ivanProducts = { new Product("Пицца Маргарита", 450), new Product("Кока-Кола", 100) };
        Product[] annaProducts = { new Product("Суши Сет", 1200), new Product("Вок с курицей", 350) };
        Courier[] couriers = { new Courier("Иван", bike, ivanProducts), new Courier("Анна", car, annaProducts) };
        List<DeliveryOrder> history = new ArrayList<>();
        while (true) {
            System.out.println();
            System.out.println("=== СЛУЖБА ДОСТАВКИ ===");
            System.out.println("1. Сделать заказ");
            System.out.println("2. Показать историю доставок");
            System.out.println("3. Выйти");
            System.out.print("Выберите действие: ");
            int choice = readInt(scanner);
            if (choice == 1) createOrder(scanner, couriers, history);
            else if (choice == 2) printHistory(history);
            else if (choice == 3) { System.out.println("Выход из программы."); break; }
            else System.out.println("Неверная команда, попробуйте еще раз.");
        }
        scanner.close();
    }
    private static void createOrder(Scanner scanner, Courier[] couriers, List<DeliveryOrder> history) {
        System.out.println("\nДоступные курьеры и их меню:");
        for (int i = 0; i < couriers.length; i++) System.out.println((i + 1) + ". Курьер " + couriers[i].getName() + " (Транспорт: " + couriers[i].getTransport() + ")");
        System.out.print("Выберите цифру курьера: ");
        int cIdx = readInt(scanner) - 1;
        if (cIdx < 0 || cIdx >= couriers.length) { System.out.println("Неверный выбор!"); return; }
        Courier sc = couriers[cIdx];
        Product[] prods = sc.getProducts();
        System.out.println("\nПродукты у курьера " + sc.getName() + ":");
        for (int i = 0; i < prods.length; i++) System.out.println((i + 1) + ". " + prods[i].getName() + " — " + prods[i].getPrice() + " руб.");
        System.out.print("Выберите цифру продукта: ");
        int pIdx = readInt(scanner) - 1;
        if (pIdx < 0 || pIdx >= prods.length) { System.out.println("Неверный выбор!"); return; }
        double dist = readDouble(scanner, "Введите расстояние до вас (в км): ");
        DeliveryOrder order = new DeliveryOrder(sc, prods[pIdx], dist);
        order.printInfo();
        history.add(order);
    }
    private static void printHistory(List<DeliveryOrder> history) {
        System.out.println("\n=== ИСТОРИЯ ДОСТАВОК ===");
        if (history.isEmpty()) System.out.println("История пуста.");
        else for (int i = 0; i < history.size(); i++) {
            DeliveryOrder o = history.get(i);
            System.out.println((i + 1) + ". Товар: " + o.getProduct().getName() + " | Курьер: " + o.getCourier().getName() + " | Цена доставки: " + o.getDeliveryCost() + " руб.");
        }
        System.out.println("========================");
    }
    private static int readInt(Scanner s) {
        while (true) { try { return Integer.parseInt(s.nextLine().trim()); } catch (Exception e) { System.out.print("Пожалуйста, введите целое число: "); } }
    }
    private static double readDouble(Scanner s, String prompt) {
        System.out.print(prompt);
        while (true) { try { double v = Double.parseDouble(s.nextLine().trim().replace(',', '.')); if (v <= 0) { System.out.print("Расстояние > 0. Повторите: "); continue; } return v; } catch (Exception e) { System.out.print("Пожалуйста, введите число: "); } }
    }
}
