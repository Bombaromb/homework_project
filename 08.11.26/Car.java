public class Car implements Transport {
    @Override
    public double getSpeed() { return 50.0; }
    @Override
    public double getCostPerKm() { return 25.0; }
    @Override
    public String toString() { return "Автомобиль"; }
}
