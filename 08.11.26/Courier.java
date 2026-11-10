public class Courier {
    private final String name;
    private final Transport transport;
    private final Product[] products;
    public Courier(String name, Transport transport, Product[] products) {
        this.name = name; this.transport = transport; this.products = products;
    }
    public String getName() { return name; }
    public Transport getTransport() { return transport; }
    public Product[] getProducts() { return products.clone(); }
}
