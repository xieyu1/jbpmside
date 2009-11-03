package org.jbpmside.console.gui.job;


import javax.transaction.Synchronization;

import org.jbpm.pvm.internal.env.Transaction;

import org.springframework.transaction.support.TransactionSynchronizationAdapter;
import org.springframework.transaction.support.TransactionSynchronizationManager;


public class SpringTransaction implements Transaction {
    private boolean rollbackOnly;

    public void setRollbackOnly() {
        rollbackOnly = true;
    }

    public boolean isRollbackOnly() {
        return rollbackOnly;
    }

    public void registerSynchronization(
        final Synchronization synchronization) {
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronizationAdapter() {
                public void afterCompletion(int state) {
                    System.out.println(
                        " ---------------------------------------- ");
                    System.out.println(synchronization);
                    System.out.println(
                        " ---------------------------------------- ");
                    synchronization.afterCompletion(state);
                }

                public void beforeCompletion() {
                    synchronization.beforeCompletion();
                }
            });
    }
}
