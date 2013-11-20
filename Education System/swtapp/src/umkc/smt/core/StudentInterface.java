package umkc.smt.core;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
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

public class StudentInterface implements UserInterface {
	Display display;
	List courses;
	Text studentId;
	Shell shell;

	public void show(Display d) {
		this.display = d;
		final Image image = new Image(display, "umkc.jpg");
		shell = new Shell(display);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type = SWT.VERTICAL;
		rowLayout.marginTop = 5;
		shell.setLayout(rowLayout);
		shell.setBackgroundImage(image);

		Label label1 = new Label(shell, SWT.PUSH);
		label1.setText("Student Id");
		studentId = new Text(shell, SWT.SINGLE | SWT.BORDER);
		studentId.setText("");
		studentId.setTextLimit(30);

		Button button3 = new Button(shell, SWT.NONE);
		button3.setText("My class List");
		button3.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				if (!isValidStudentId(studentId.getText())) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("StudentId must be a number with 8 digits");
					mb.open();
					return;
				}
				java.util.List<String> studentCourses = readStudentCourses(studentId
						.getText());
				if (studentCourses == null || studentCourses.size() == 0) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("No classes enrolled");
					mb.open();
					return;
				}
				new StudentClassesInterface(studentId.getText()).show(display);
			}
		});

		Label labe2 = new Label(shell, SWT.NONE);
		labe2.setText("Courses");

		courses = new List(shell, SWT.SINGLE | SWT.BORDER | SWT.V_SCROLL
				| SWT.H_SCROLL);
		readCourses();

		Button button2 = new Button(shell, SWT.NONE);
		button2.setText("View Syllabus");
		button2.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String[] selectionItems = courses.getSelection();
				if (selectionItems.length > 0)
					viewSyllabus(selectionItems[0]);
			}

		});

		Button button1 = new Button(shell, SWT.NONE);
		button1.setText("Add class");
		button1.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				if (!isValidStudentId(studentId.getText())) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("StudentId must be a number with 8 digits");
					mb.open();
					return;
				}
				java.util.List<String> studentCourses = readStudentCourses(studentId
						.getText());
				if (studentCourses != null
						&& studentCourses.contains(courses.getSelection()[0])) {
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("Course already Added!");
					mb.open();
					return;
				}
				addCourse(studentId.getText(), courses.getSelection()[0]);
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

	private void viewSyllabus(String courseName) {
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
			String name = course.split(",")[0];
			if (name.equalsIgnoreCase(courseName)) {
				if (course.split(",").length == 3) {
					// syllabus exists
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("Syllabus: \n" + course.split(",")[2]);
					mb.open();
				} else {
					// no syllabus
					MessageBox mb = new MessageBox(shell);
					mb.setMessage("No Syllabus exists for the course!");
					mb.open();
				}
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

	private boolean isValidStudentId(String number) {
		if (number == null || number.length() != 8) {
			return false;
		}
		try {
			Integer.parseInt(number);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}

	}

	public static final java.util.List<String> readStudentCourses(
			String studentId) {
		File file = new File("students.txt");
		java.util.List<String> courseList = null;
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
			return null;
		String[] studentList = content.split(";");
		for (String student : studentList) {
			if (studentId.equalsIgnoreCase(student.split(",")[0])) {
				courseList = new LinkedList<String>(Arrays.asList(student
						.split(",")));
				courseList.remove(0);
			}
		}
		return courseList;
	}

	private void addCourse(String studentId, String className) {

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

		boolean isNewStudent = true;
		String[] studentList = content.split(";");
		for (String student : studentList) {
			if (studentId.equalsIgnoreCase(student.split(",")[0])) {
				isNewStudent = false;
				newStudentList.add(student + "," + className);
			} else {
				newStudentList.add(student);
			}

		}
		if (!isNewStudent) {
			try {
				PrintWriter out = new PrintWriter(new BufferedWriter(
						new FileWriter("students.txt", false)));
				for (String s : newStudentList)
					out.print(s + ";");
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				PrintWriter out = new PrintWriter(new BufferedWriter(
						new FileWriter("students.txt", true)));
				out.print(studentId + "," + className + ";");
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
