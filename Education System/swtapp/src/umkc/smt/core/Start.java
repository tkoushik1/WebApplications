package umkc.smt.core;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;

/**
 * @since 3.3
 */
public class Start {
	
	

public static void main (String [] args) {
	final Display display = new Display ();
	final Image image = new Image(display, "umkc.jpg");
	
	Shell shell = new Shell (display);
	RowLayout rowLayout = new RowLayout();
	rowLayout.type = SWT.HORIZONTAL;
	rowLayout.justify=true;
	//rowLayout.marginLeft = 100;
	rowLayout.marginTop = 25;
	//rowLayout.spacing = 10;
	shell.setLayout (rowLayout);
	shell.setBackgroundImage(image);

	    Button button1 = new Button(shell, SWT.NONE);
	    button1.setText("Student");
	    button1.addListener(SWT.Selection, new Listener(){

			@Override
			public void handleEvent(Event arg0) {
				new StudentInterface().show(display);
			}
	    	
	    });
	    Button button2 = new Button(shell, SWT.NONE);
	    button2.setText("Instructor");
	    button2.addListener(SWT.Selection, new Listener(){

			@Override
			public void handleEvent(Event arg0) {
				new InstructorInterface().show(display);
			}
	    	
	    });
	    Button button3 = new Button(shell, SWT.NONE);
	    button3.setText("Admin");
	    button3.addListener(SWT.Selection, new Listener(){

			@Override
			public void handleEvent(Event arg0) {
				new AdminInterface().show(display);
			}
	    	
	    });
	//shell.pack ();
	    shell.setSize(400, 350);
	shell.open ();
	while (!shell.isDisposed ()) {
		if (!display.readAndDispatch ())
			display.sleep ();
	}
	image.dispose ();
	display.dispose ();
}


	} 