public class Bicycle implements Transport {
    @Override
    public double getSpeed() { return 15.0; }
    @Override
    public double getCostPerKm() { return 10.0; }
    @Override
    public String toString() { return "Велосипед"; }
}
