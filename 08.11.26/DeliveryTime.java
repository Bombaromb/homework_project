public final class DeliveryTime {
    private static final double EXTRA_MINUTES = 15.0;
    private DeliveryTime() {}
    public static double calculateMaxMinutes(double distance, double speed) {
        if (distance < 0) throw new IllegalArgumentException("Расстояние не может быть отрицательным");
        if (speed <= 0) throw new IllegalArgumentException("Скорость должна быть положительной");
        return (distance / speed) * 60.0 + EXTRA_MINUTES;
    }
}
