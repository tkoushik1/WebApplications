package umkc.smt.core;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.List;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;

public class StudentClassesInterface implements UserInterface {
	String studentId;
	Shell shell;
	List courses;
	
	public StudentClassesInterface(String id){
		studentId = id;
	}
	
	@Override
	public void show(Display display) {
		//this.display = d;
		final Image image = new Image(display, "umkc.jpg");
		shell = new Shell(display);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type = SWT.VERTICAL;
		rowLayout.marginTop = 5;
		shell.setLayout(rowLayout);
		shell.setBackgroundImage(image);

		Label label1 = new Label(shell, SWT.PUSH);
		label1.setText("Enrolled Class List");


		courses = new List(shell, SWT.SINGLE | SWT.BORDER | SWT.V_SCROLL
				| SWT.H_SCROLL);
		for(String s : StudentInterface.readStudentCourses(studentId)){
			courses.add(s);
		}

		Button button2 = new Button(shell, SWT.NONE);
		button2.setText("Drop Course");
		button2.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String[] selectionItems = courses.getSelection();
				if (selectionItems.length > 0){
					dropCourse(selectionItems[0]);
				courses.remove(courses.getSelection()[0]);
				}
			}

		});
		shell.setSize(400, 350);
		shell.open();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch())
				display.sleep();
		}
		shell.dispose();

	}
	
	private void dropCourse(String className) {

		File file = new File("students.txt");
		ArrayList<String> newStudentList = new ArrayList<String>();
		String content = null;
		try {
			Scanner scanner = new Scanner(file);
			content = scanner.useDelimiter("\\Z").next();
			if (scanner != null)
				scanner.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		if (content == null)
			return;

		String[] studentList = content.split(";");
		for (String student : studentList) {
			if (studentId.equalsIgnoreCase(student.split(",")[0])) {
				newStudentList.add(student.replace(className+",", ""));
			} else {
				newStudentList.add(student);
			}

		}
			try {
				PrintWriter out = new PrintWriter(new BufferedWriter(
						new FileWriter("students.txt", false)));
				for (String s : newStudentList)
					out.print(s + ";");
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

}
