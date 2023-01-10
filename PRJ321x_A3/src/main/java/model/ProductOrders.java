package model;

public class ProductOrders {
	private int orderId;
	private int productId;
	private float priceProduct;
	private int amountProduct; // quantity of selected product
	private String nameProduct;
	private String src; // product image src;
	
	public ProductOrders() {
		
	}

	public ProductOrders(int orderId, int productId, String nameProduct, int amountProduct, float priceProduct, String src) {
		this.orderId = orderId;
		this.productId = productId;
		this.nameProduct = nameProduct;
		this.amountProduct = amountProduct;
		this.priceProduct = priceProduct;
		this.src = src;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getAmountProduct() {
		return amountProduct;
	}

	public void setAmountProduct(int amountProduct) {
		this.amountProduct = amountProduct;
	}
	

	public float getPriceProduct() {
		return priceProduct;
	}

	public void setPriceProduct(float priceProduct) {
		this.priceProduct = priceProduct;
	}

	public float getTotalPriceProduct() {
		return priceProduct * amountProduct;
	}

	public String getNameProduct() {
		return nameProduct;
	}

	public void setNameProduct(String nameProduct) {
		this.nameProduct = nameProduct;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}
	
}
