package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<ProductOrders> items; //list of item in cart;
	
	public Cart() {
		items = new ArrayList<>();
	}
	
	// add a new product to cart
	public void add(ProductOrders ci) {
		for(ProductOrders x: items) {
			if(ci.getProductId() == x.getProductId()) {
				x.setAmountProduct(x.getAmountProduct() + 1);
				return;
			}
		}
		items.add(ci);
	}
	
	// remove a product from cart
	public void remove(int id) {
		for(ProductOrders x: items) {
			if(x.getProductId() == id) {
				items.remove(x);
				return;
			}
		}
	}
	
	// change amount of product in cart
	public void changeAmount(int id, int amount) {
		for(ProductOrders x: items) {
			if(x.getProductId() == id) {
				x.setAmountProduct(amount);
				return;
			}
		}
	}
	
	// get product from cart
	public ProductOrders getProduct(int id) {
		for(ProductOrders x: items) {
			if(x.getProductId() == id) {
				return x;
			}
		}
		
		return null;
	}
	
	// return total price of cart
	
	public float getPrice() {
		double s = 0;
		for(ProductOrders x: items) {
			s += x.getTotalPriceProduct();
		}
		
		return (float) (Math.round(s * 100.0) / 100.0);
	}
	
	// return list of products in cart
	public List<ProductOrders> getItems() {
		return items;
	}
}
