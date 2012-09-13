package com.si.powerlog
import org.springframework.beans.factory.InitializingBean
class CometDService implements InitializingBean {
    
    static transactional = true
    
    def bayeux
    def bayeuxSession
    
    void afterPropertiesSet() {		
	    bayeuxSession = bayeux.newLocalSession('powerlog')
        bayeuxSession.handshake()
    }
    
    /**
	* 将所有数据推送至页面
	*/
	def pushLog(String data,String channel){
		if(bayeux.getChannel(channel)?.subscribers?.size()){
			bayeuxSession.getChannel(channel).publish(data)			
		}
    }
}
