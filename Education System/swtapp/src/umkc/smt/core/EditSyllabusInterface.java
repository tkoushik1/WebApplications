package umkc.smt.core;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

public class EditSyllabusInterface {
	String courseInfo;
	String updatedCourseDetails = null;
	String[] courseDetails;
	Text newInstructor;
	Text newSyllabus;
	
	public EditSyllabusInterface(String s){
		courseInfo = s;
	}
	
	
	public String proceed(Display display) {
		final Image image = new Image(display, "umkc.jpg");
		Shell shell = new Shell(display);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type = SWT.VERTICAL;
		rowLayout.marginTop = 5;
		shell.setLayout(rowLayout);
		shell.setBackgroundImage(image);
		courseDetails = courseInfo.split(",");
		
		Label label = new Label(shell, SWT.NONE);
		label.setText("Current Info : \n" + "Instructor: " + courseDetails[1]+ "\nSyllabus: "+ courseDetails[2]+"\n");

		Label label1 = new Label(shell, SWT.NONE);
		label1.setText("Intructor");
		newInstructor = new Text(shell, SWT.SINGLE | SWT.BORDER);
		newInstructor.setText("");
		newInstructor.setTextLimit(30);
		
		Label label2 = new Label(shell, SWT.NONE);
		label2.setText("Syllabus");
		newSyllabus = new Text(shell, SWT.SINGLE | SWT.BORDER);
		newSyllabus.setText("");
		newSyllabus.setTextLimit(30);

		Button button1 = new Button(shell, SWT.NONE);
		button1.setText("Update Course Info");
		button1.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
					updatedCourseDetails = courseDetails[0]+","+newInstructor.getText()+","+newSyllabus.getText();
			}

		});

		shell.setSize(400, 350);
		shell.open();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch())
				display.sleep();
		}
		shell.dispose();
		return updatedCourseDetails;
	}

}
