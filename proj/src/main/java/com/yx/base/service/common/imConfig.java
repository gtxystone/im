package com.yx.base.service.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class imConfig
{
  @Value("${local}")
  public String local;
  @Value("${socket}")
  private int socket;
  @Value("${enablesocket}")
  private boolean enablesocket;
  @Value("${isbackup}")
  private boolean isbackup;
  @Value("${enableredback}")
  private boolean enableredback;
  @Value("${enabletransback}")
  private boolean enabletransback;
  @Value("${nimAppkey}")
  private String nimAppkey;
  @Value("${nimAppsecret}")
  private String nimAppsecret;

  public boolean getEnableredback()
  {
    return this.enableredback;
  }
  
  public boolean getEnabletransback()
  {
    return this.enabletransback;
  }
  
  public boolean getIsbackup()
  {
    return this.isbackup;
  }
  
  public boolean getEnablesocket()
  {
    return this.enablesocket;
  }
  
  public int getSocket()
  {
    return this.socket;
  }
  
  public String getLocal()
  {
    return this.local;
  }
  
  public void setLocal(String local)
  {
    this.local = local;
  }

  public String getNimAppkey() {
		return nimAppkey;
	}

	public String getNimAppsecret() {
		return nimAppsecret;
	}
}
