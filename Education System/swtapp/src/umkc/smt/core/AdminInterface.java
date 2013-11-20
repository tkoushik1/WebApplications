package umkc.smt.core;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

public class AdminInterface implements UserInterface {

	List courses;
	Text newCourse;
	Shell shell;

	public void show(Display display) {
		final Image image = new Image(display, "umkc.jpg");
		shell = new Shell(display);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type = SWT.VERTICAL;
		// rowLayout.justify=true;
		// rowLayout.marginLeft = 100;
		rowLayout.marginTop = 5;
		// rowLayout.spacing = 10;
		shell.setLayout(rowLayout);
		shell.setBackgroundImage(image);

		Label label = new Label(shell, SWT.NONE);
		label.setText("Courses");
		courses = new List(shell, SWT.MULTI | SWT.BORDER | SWT.V_SCROLL
				| SWT.H_SCROLL);
		readCourses();

		Button button2 = new Button(shell, SWT.NONE);
		button2.setText("Delete Course");
		button2.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String[] selectionItems = courses.getSelection();
				dropCourses(selectionItems);
			}

		});
		newCourse = new Text(shell, SWT.SINGLE | SWT.BORDER);
		newCourse.setText("");
		newCourse.setTextLimit(30);

		Button button1 = new Button(shell, SWT.NONE);
		button1.setText("Add Course");
		button1.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String newCourseText = newCourse.getText();
				if (newCourseText == null || newCourseText.length() == 0) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("Invalid Course Name");
					mb.open();
					return;
				}
				for (char c : newCourseText.toCharArray()) {
					if (!Character.isLetterOrDigit(c)) {
						MessageBox mb = new MessageBox(shell);
						mb.setMessage("Course Name can contain only letters and numbers.");
						mb.open();
						return;
					}
				}
				if (Arrays.asList(courses.getItems()).contains(newCourseText)) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("Course Name already exits!");
					mb.open();
					return;
				}
				addCourse(newCourseText);
				courses.add(newCourseText);
				MessageBox mb = new MessageBox(shell);
				mb.setMessage("Course added successfully!");
				mb.open();
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

	private void addCourse(String name) {
		try {
			PrintWriter out = new PrintWriter(new BufferedWriter(
					new FileWriter("courses.txt", true)));
			out.print(name + ",,;");
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void dropCourses(String[] names) {
		File file = new File("courses.txt");
		ArrayList<String> newCourseList = new ArrayList<String>();
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
		String[] courseList = content.split(";");
		for (String course : courseList) {
			String name = course.split(",")[0];
			if (!Arrays.asList(names).contains(name)) {
				newCourseList.add(course);
			} else {
				courses.remove(name);
			}
			// write to file
			try {
				PrintWriter out = new PrintWriter(new BufferedWriter(
						new FileWriter("courses.txt", false)));
				for (String s : newCourseList) {
					out.print(s + ";");
				}
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void readCourses() {
		File file = new File("courses.txt");
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
		String[] courseList = content.split(";");
		for (String course : courseList) {
			courses.add(course.split(",")[0]);
		}
	}
}
