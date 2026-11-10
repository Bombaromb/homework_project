public class DeliveryOrder {
    private final Courier courier;
    private final Product product;
    private final double distance;
    private final double deliveryCost;
    private final double timeInMinutes;
    public DeliveryOrder(Courier courier, Product product, double distance) {
        this.courier = courier; this.product = product; this.distance = distance;
        this.deliveryCost = courier.getTransport().getCostPerKm() * distance;
        this.timeInMinutes = DeliveryTime.calculateMaxMinutes(distance, courier.getTransport().getSpeed());
    }
    public Courier getCourier() { return courier; }
    public Product getProduct() { return product; }
    public double getDistance() { return distance; }
    public double getDeliveryCost() { return deliveryCost; }
    public double getTimeInMinutes() { return timeInMinutes; }
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
