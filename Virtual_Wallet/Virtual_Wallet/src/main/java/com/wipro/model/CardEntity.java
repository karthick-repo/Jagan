package com.wipro.model;



import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class CardEntity {	
	String username;
	String cardName;
	@Id
	String cardNumber;
	String expiryDate;
	int cardBalance;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public int getCardBalance() {
		return cardBalance;
	}
	public void setCardBalance(int cardBalance) {
		this.cardBalance = cardBalance;
	}	
}
