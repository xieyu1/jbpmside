package org.jbpmside.console.gui.job;


import org.jbpm.api.ProcessEngine;

import org.jbpm.pvm.internal.env.EnvironmentFactory;
import org.jbpm.pvm.internal.jobexecutor.JobExecutor;

import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;


public class JobExecutorFactoryBean implements InitializingBean,
    DisposableBean {
    private JobExecutor jobExecutor;
    private ProcessEngine processEngine;

    public void afterPropertiesSet() {
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
        jobExecutor = environmentFactory.get(JobExecutor.class);
        jobExecutor.start();
    }

    public void destroy() {
        jobExecutor.stop();
    }

    public Object getObject() {
        return jobExecutor;
    }

    public Class getObjectType() {
        return JobExecutor.class;
    }

    public boolean isSingleton() {
        return true;
    }

    public void setProcessEngine(ProcessEngine processEngine) {
        this.processEngine = processEngine;
    }
}
