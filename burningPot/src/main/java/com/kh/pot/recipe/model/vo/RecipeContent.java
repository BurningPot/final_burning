package com.kh.pot.recipe.model.vo;

import java.io.Serializable;
import java.util.List;

public class RecipeContent implements Serializable{

	
	private static final long serialVersionUID = -8620043092028980274L;
	
	private int rStep;			// 레시피 순서 (1단계, 2단계)
	private int rNum;		// 레시피 번호
	private String rContent;	// 각 단계별 내용
	private String rContentimg;	// 각 단계별 사진
	
	public RecipeContent(){
		
	}

	public RecipeContent(int rStep, int rNum, String rContent, String rContentimg) {
		super();
		this.rStep = rStep;
		this.rNum = rNum;
		this.rContent = rContent;
		this.rContentimg = rContentimg;
	}

	public int getrStep() {
		return rStep;
	}

	public void setrStep(int rStep) {
		this.rStep = rStep;
	}

	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrContentimg() {
		return rContentimg;
	}

	public void setrContentimg(String rContentimg) {
		this.rContentimg = rContentimg;
	}

	@Override
	public String toString() {
		return "RecipeContent [rStep=" + rStep + ", rNum=" + rNum + ", rContent=" + rContent + ", rContentimg="
				+ rContentimg + "]";
	}
	
}
