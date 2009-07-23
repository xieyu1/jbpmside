package org.jbpmside.console.gui.job;

import org.jbpm.pvm.internal.env.Transaction;
import org.jbpm.pvm.internal.tx.StandardTransaction;
import org.jbpm.pvm.internal.wire.binding.WireDescriptorBinding;
import org.jbpm.pvm.internal.wire.descriptor.ObjectDescriptor;
import org.jbpm.pvm.internal.xml.Parse;
import org.jbpm.pvm.internal.xml.Parser;

import org.w3c.dom.Element;


public class SpringTransactionBinding extends WireDescriptorBinding {
    public SpringTransactionBinding() {
        super("spring-transaction");
    }

    public Object parse(Element element, Parse parse, Parser parser) {
        return new ObjectDescriptor(SpringTransaction.class);
    }
}
