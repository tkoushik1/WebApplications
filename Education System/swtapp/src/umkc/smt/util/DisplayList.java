package umkc.smt.util;

import java.util.ArrayList;

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;

public class DisplayList {
	ArrayList<String> list;
	public DisplayList(ArrayList<String> a){
		list = a;
	}
	
	public void display(Display display){
		
		Shell shell = new Shell(display);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type = SWT.VERTICAL;
		rowLayout.marginTop = 5;
		shell.setLayout(rowLayout);
		StringBuffer s = new StringBuffer();
		for(String item : list){
			s.append(item+"\n");
		}
		Label label1 = new Label(shell, SWT.NONE);
		label1.setText(s.toString().trim());
		
		shell.setSize(400, 350);
		shell.open();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch())
				display.sleep();
		}
		shell.dispose();
		
	}

}
