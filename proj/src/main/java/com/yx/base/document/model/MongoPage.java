package com.yx.base.document.model;

import com.framework.model.Page;

public class MongoPage extends Page {

	private int skip = 0;

	public int getSkip() {
		skip = (this.getPageNo() - 1) * this.getPageSize();
		return skip;
	}

	public void setSkip(int skip) {
		this.skip = skip;
	}
}
