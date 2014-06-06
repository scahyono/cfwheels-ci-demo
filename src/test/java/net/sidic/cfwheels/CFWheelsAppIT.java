package net.sidic.cfwheels;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

/**
 * Integration Tests (IT) to run during Maven integration-test phase
 * @author Singgih
 *
 */
@RunWith(Parameterized.class)
public class CFWheelsAppIT {
	static final private String[] KNOWN_ERRORS={"The data source could not be reached."};
	static private WebDriver driver;
	private static String baseUrl;
	private String packageName;
	private StringBuffer verificationErrors = new StringBuffer();

	public CFWheelsAppIT(String packageName) {
		super();
		this.packageName = packageName;
	}

	@Parameters(name="package {0}")
    public static Collection<Object[]> getDirectories() {
    	Collection<Object[]> params = new ArrayList<Object[]>();
    	addSubDirectories(params, "", "src/main/webapp/tests/");
    	return params;
    }

	private static boolean addSubDirectories(Collection<Object[]> params, String prefix, String path) {
		boolean added = false;
		for (File f : new File(path).listFiles()) {
			if (f.getName().startsWith("_")) continue;
    		if (!f.isDirectory()) {
    			if (!f.getName().endsWith(".cfc")) continue;
    			if ("".equals(prefix) && f.getName().equals("Test.cfc")) continue;
    			Object[] arr = new Object[] {prefix + f.getName().replace(".cfc", "") };
        		params.add(arr);
        		added = true;
        		continue;
    		}
			if (addSubDirectories(params, prefix + f.getName() + ".", f.getPath())) {
	    		added = true;
				continue;
			}
			
			Object[] arr = new Object[] {prefix + f.getName() };
    		params.add(arr);
    		added = true;
    	}
		return added;
	}
    
	@BeforeClass
	static public void setUpServices() throws Exception {
		Path path = Paths.get("target/failsafe-reports");
		if (!Files.exists(path)) Files.createDirectory(path);
		driver = new HtmlUnitDriver();
		baseUrl = "http://localhost:8080/";
		driver.manage().timeouts().implicitlyWait(30000, TimeUnit.SECONDS);
		//reset test database
		createTestDatabase();
	}

	private static void createTestDatabase() throws Exception {
		System.out.println("test database re-create");
		driver.get(baseUrl + "_database.cfm");
		Files.write(Paths.get("target/failsafe-reports/_database.html"), driver.getPageSource().getBytes());
	}

	@Test
	public void testCFWheels() throws IOException {
		System.out.println(packageName);
		String testUrl = baseUrl + "index.cfm?controller=wheels&action=wheels&view=tests&type=app&package=" + packageName;
		driver.get(testUrl);
        String pageSource = driver.getPageSource();
		Files.write(Paths.get("target/failsafe-reports/" + packageName + ".html"), pageSource.getBytes());
        assertTrue("The page should have results",pageSource.trim().length()>0);
        for (String error:KNOWN_ERRORS) {
        	if (pageSource.contains(error)) fail(error + " " + testUrl);
        }
        assertTrue("The page should have passed " + testUrl,pageSource.contains("Passed"));
	}

	@AfterClass
	static public void tearDownServices() throws Exception {
		driver.quit();
	}

	@After
	public void tearDown() throws Exception {
		String verificationErrorString = verificationErrors.toString();
		if (!"".equals(verificationErrorString)) {
			fail(verificationErrorString);
		}
	}

}
