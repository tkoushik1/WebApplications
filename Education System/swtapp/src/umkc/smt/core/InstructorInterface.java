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

import umkc.smt.util.DisplayList;

public class InstructorInterface implements UserInterface {
	Display display;
	List courses;
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

		Label label1 = new Label(shell, SWT.NONE);
		label1.setText("Courses");
		
		courses = new List(shell, SWT.SINGLE | SWT.BORDER | SWT.V_SCROLL
				| SWT.H_SCROLL);
		readCourses();

		Button button2 = new Button(shell, SWT.NONE);
		button2.setText("Edit Syllabus");
		button2.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String[] selectionItems = courses.getSelection();
				if (selectionItems.length > 0){
					
					editSyllabus(selectionItems[0],new EditSyllabusInterface(readCourseInfo(selectionItems[0])).proceed(display));
				}
			}

		});

		Button button1 = new Button(shell, SWT.NONE);
		button1.setText("View Rooster");
		button1.addListener(SWT.Selection, new Listener() {

			@Override
			public void handleEvent(Event arg0) {
				String[] selectionItems = courses.getSelection();
				if (selectionItems.length > 0)
					new DisplayList(viewRooster(selectionItems[0])).display(display);
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

	private ArrayList<String> viewRooster(String courseName) {
		File file = new File("students.txt");
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
			return new ArrayList<String>();
		String[] studentList = content.split(";");
		ArrayList<String> roosterList = new ArrayList<String>();
		for (String student : studentList) {
			String studentId = student.split(",")[0];
			if (student.contains(courseName)) {
				roosterList.add(studentId);
				}
			}
		return roosterList;
		}
	
	private void editSyllabus(String className,String updatedInfo) {

		File file = new File("courses.txt");
		ArrayList<String> updatedCourseList = new ArrayList<String>();
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
		for (String courseInfo : courseList) {
			if (className.equalsIgnoreCase(courseInfo.split(",")[0])) {
				updatedCourseList.add(updatedInfo);
			} else {
				updatedCourseList.add(courseInfo);
			}

		}
		
			try {
				PrintWriter out = new PrintWriter(new BufferedWriter(
						new FileWriter("courses.txt", false)));
				for(String s : updatedCourseList)
				out.print( s +";");
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
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
	
	private String readCourseInfo(String className) {
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
			return null;
		String[] courseList = content.split(";");
		for (String course : courseList) {
			if(course.split(",")[0].equals(className))
				return course;
		}
		return  null;
	}

}
