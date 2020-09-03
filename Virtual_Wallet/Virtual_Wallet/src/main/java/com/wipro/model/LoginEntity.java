package com.wipro.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class LoginEntity {
	@Id
	String username;
	String password;
	int noOfCards;
	int walletBal;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getNoOfCards() {
		return noOfCards;
	}
	public void setNoOfCards(int noOfCards) {
		this.noOfCards = noOfCards;
	}
	public int getWalletBal() {
		return walletBal;
	}
	public void setWalletBal(int walletBal) {
		this.walletBal = walletBal;
	}
	
	
}
