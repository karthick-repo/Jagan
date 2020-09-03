package com.wipro.controller;

import java.util.Calendar;
import java.util.Iterator;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wipro.dao.VMCardRepo;
import com.wipro.dao.VMLoginRepo;
import com.wipro.model.CardEntity;
import com.wipro.model.LoginEntity;

@Controller
public class VWController {
	private static final String VIRTUAL_CARDS_WALLET_TOPUP_ERROR = "Virtual Cards Wallet - Topup Error";
	private static final String TOPUP_VAL = "topup-val";
	private static final String SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER = "Sorry, there was an error encountered, try again later";
	@Autowired
	VMLoginRepo logRep;
	@Autowired
	VMCardRepo cardRep;

	private static final String ERROR_MESSAGE = "error";
	private static final String CARDENTITY = "CardEntity";
	private static final String LOGIN = "login";
	private static final String USERID = "userid";
	private static final String BALANCE = "balance";
	private static final String INPUT_AMOUNT = "input-amount";
	private static final String TITLE = "title";
	private String userNameId;

	@RequestMapping("/")
	public String home() {
		return LOGIN;
	}

	@RequestMapping("/login")
	public String login() {
		return LOGIN;
	}

	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request) {
		request.getSession(true).setAttribute(USERID, null);
		return "redirect:login";
	}

	@RequestMapping("/dashboard")
	public String dashboard(ModelMap model, HttpServletRequest request) {
		LoginEntity log = logRep.findByUsername(userNameId).orElse(new LoginEntity());
		request.getSession(false).setAttribute("noOfCards", log.getNoOfCards());
		request.getSession(false).setAttribute(BALANCE, log.getWalletBal());
		return "dashboard";
	}

	@RequestMapping("/view_cards")
	public String viewCards(ModelMap model, HttpServletRequest request) {
		Iterator<CardEntity> cards = cardRep.findAll().iterator();
		if(cards.hasNext()) {
		request.getSession(false).setAttribute(CARDENTITY, cards);
		}
		request.getSession(false).setAttribute(USERID, userNameId);
		return "view_cards";
	}

	@RequestMapping("/create_card")
	public String createCard(ModelMap model, HttpServletRequest request) {
		LoginEntity log = logRep.findByUsername(userNameId).orElse(new LoginEntity());
		request.getSession(false).setAttribute(BALANCE, log.getWalletBal());
		return "create_card";
	}

	@RequestMapping("/create_card/success")
	public String createCardSuccess(ModelMap model, HttpServletRequest request) {
		return "success";
	}

	@RequestMapping("/create_card/error")
	public String cardValidate(ModelMap model, CardEntity card, HttpServletRequest request) {
		try {
			if (request.getParameter("input-cardname").isEmpty()
					|| Integer.parseInt(request.getParameter(INPUT_AMOUNT)) <= 0) {
				model.addAttribute(ERROR_MESSAGE, SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER);
				request.getSession(false).setAttribute(TITLE, "Virtual Cards Wallet - Create Card Error");
				return ERROR_MESSAGE;
			}
		else if (Integer.parseInt(request.getParameter(INPUT_AMOUNT)) <= 10000) {
				LoginEntity log = logRep.findByUsername(userNameId).orElse(new LoginEntity());
				log.setWalletBal(log.getWalletBal() - Integer.parseInt(request.getParameter(INPUT_AMOUNT)));
				log.setNoOfCards(log.getNoOfCards()-1);
				logRep.save(log);
				card.setCardBalance(Integer.parseInt(request.getParameter(INPUT_AMOUNT)));
				card.setCardName(request.getParameter("input-cardname"));
				Random r = new Random();
				String cardNo = r.nextInt(10000) + "" + r.nextInt(10000) + "" + r.nextInt(10000) + ""
						+ r.nextInt(10000);
				while (cardNo.length() != 16) {
					cardNo = r.nextInt(10000) + "" + r.nextInt(10000) + "" + r.nextInt(10000) + "" + r.nextInt(10000);
				}
				card.setCardNumber(cardNo);
				Calendar now = Calendar.getInstance();
				int years = now.get(Calendar.YEAR) + 10;
				card.setExpiryDate(now.get(Calendar.MONTH) + "/" + years);
				card.setUsername(userNameId);
				cardRep.save(card);
				CardEntity cardr = cardRep.findById(cardNo).orElse(new CardEntity());
				request.getSession(false).setAttribute("card", cardr);
				return "redirect:/create_card/success";
			} else {
				model.addAttribute(ERROR_MESSAGE,
						"Virtual card creation Failed, Total amount exceeds the maximum limit (INR 10,000) allowed");
				request.getSession(false).setAttribute(TITLE, "Virtual Cards Wallet - Create Card Failure");
				return ERROR_MESSAGE;
			}
		} catch (Exception e) {
			model.addAttribute(ERROR_MESSAGE, SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER);
			request.getSession(false).setAttribute(TITLE, "Virtual Cards Wallet - Create Card Error");
			return ERROR_MESSAGE;
		}
	}

	@RequestMapping("/topup_card")
	public String topupCard(ModelMap model, HttpServletRequest request) {
		Iterator<CardEntity> cards = cardRep.findAll().iterator();
		LoginEntity log = logRep.findByUsername(userNameId).orElse(new LoginEntity());
		request.getSession(false).setAttribute(CARDENTITY, cards);
		request.getSession(false).setAttribute(USERID, userNameId);
		int balance = log.getWalletBal();
		request.getSession(false).setAttribute(BALANCE, balance);
		return "topup_card";
	}

	@RequestMapping("/topup_card/success")
	public String topupSuccess(ModelMap model, HttpServletRequest request) {
		return "success_page";
	}

	@RequestMapping("/topup_card/error")
	public String validate(ModelMap model, HttpServletRequest request) {
		Iterator<CardEntity> cards = cardRep.findAll().iterator();
		LoginEntity log = logRep.findByUsername(userNameId).orElse(new LoginEntity());
		request.getSession(false).setAttribute(USERID, userNameId);
		
		try {
			String cardName = request.getParameter("select-card");
		if (request.getParameter("select-card").isEmpty()|| request.getParameter(TOPUP_VAL).isEmpty()) {
			model.addAttribute(ERROR_MESSAGE, SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER);
			request.getSession(false).setAttribute(TITLE, VIRTUAL_CARDS_WALLET_TOPUP_ERROR);
			return ERROR_MESSAGE;
		}
		while (cards.hasNext()) {
			CardEntity card = cards.next();
			request.getSession(false).setAttribute(CARDENTITY, card);

			if ((card.getCardName()).equals(cardName) && card.getUsername().equals(userNameId)) {
				int bal = card.getCardBalance() + Integer.parseInt(request.getParameter(TOPUP_VAL));
				if (bal <= 10000) {
					CardEntity cardDet = cardRep.findById(card.getCardNumber()).orElse(new CardEntity());
					cardDet.setCardBalance(bal);
					cardRep.save(cardDet);
					log.setWalletBal(log.getWalletBal() - Integer.parseInt(request.getParameter(TOPUP_VAL)));
					logRep.save(log);
					return "redirect:/topup_card/success";
				} else {
					model.addAttribute(ERROR_MESSAGE,
							"TopUp Failed, Total amount exceeds the maximum limit (INR 10,000) allowed");
					request.getSession(false).setAttribute(TITLE, VIRTUAL_CARDS_WALLET_TOPUP_ERROR);
					return ERROR_MESSAGE;
				}
			}
		}
		}catch(Exception e) {
		model.addAttribute(ERROR_MESSAGE, SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER);
		request.getSession(false).setAttribute(TITLE, VIRTUAL_CARDS_WALLET_TOPUP_ERROR);
		return ERROR_MESSAGE;		
		}
		model.addAttribute(ERROR_MESSAGE, SORRY_THERE_WAS_AN_ERROR_ENCOUNTERED_TRY_AGAIN_LATER);
		request.getSession(false).setAttribute(TITLE, VIRTUAL_CARDS_WALLET_TOPUP_ERROR);
		return ERROR_MESSAGE;
	}

	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String authenticate(ModelMap model, HttpServletRequest request) {
		try {
			LoginEntity log = logRep.findByUsername(request.getParameter("username")).orElse(new LoginEntity());
			if (log.getPassword().equals(request.getParameter("password"))) {

				userNameId = log.getUsername();

				request.getSession(true).setAttribute(USERID, userNameId);
				request.getSession(false).setAttribute("noOfCards", log.getNoOfCards());
				request.getSession(false).setAttribute(BALANCE, log.getWalletBal());
				return "redirect:dashboard";
			} else {
				model.addAttribute(ERROR_MESSAGE, "Invalid Credentials");
				return LOGIN;
			}
		} catch (Exception e) {
			model.addAttribute(ERROR_MESSAGE, "Invalid Credentials");
			return LOGIN;
		}
	}

}
