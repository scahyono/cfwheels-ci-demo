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

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

/**
 * Integration Tests (IT) to run during Maven integration-test phase
 * See pom.xml for usage
 *
 * @author Singgih
 *
 */
@RunWith(Parameterized.class)
public class CFWheelsAppIT {
	static final private String[] KNOWN_ERRORS={"The data source could not be reached."};
	static private CustomHtmlUnitDriver driver;
	private static String baseUrl;
	private String packageName;

	public CFWheelsAppIT(String packageName) {
		super();
		this.packageName = packageName;
	}

	/**
	 * @return scan folder for cfwheels app unit tests and add them as parameterized jUnit tests
	 */
	@Parameters(name="package {0}")
    public static Collection<Object[]> getDirectories() {
    	Collection<Object[]> params = new ArrayList<Object[]>();
    	addSubDirectories(params, "", "tests/");
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
    
    /**
     * prepare for testing  
     * @throws Exception
     */
	@BeforeClass
	static public void setUpServices() throws Exception {
		Path path = Paths.get("target/failsafe-reports");
		if (!Files.exists(path)) Files.createDirectory(path);
		
		driver = new CustomHtmlUnitDriver();
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

	/**
	 * Generic test, to be parameterized per cfwheels app test package
	 * @throws IOException
	 */
	@Test
	public void testCFWheels() throws IOException {
		System.out.println(packageName);

		String testUrl = baseUrl + "index.cfm?controller=wheels&action=wheels&view=tests&type=app&package=" + packageName;
		driver.get(testUrl);
        String pageSource = driver.getPageSource();
        // write error detail on per test html report on failsafe-report folder
		Files.write(Paths.get("target/failsafe-reports/" + packageName + ".html"), pageSource.getBytes());

		assertTrue("The page should have results",pageSource.trim().length()>0);
        for (String error:KNOWN_ERRORS) {
        	if (pageSource.contains(error)) fail(error + " " + testUrl);
        }
        // show error detail on Maven log if needed
        if (!pageSource.contains("Passed")) System.out.println(driver.getPageSourceAsText());
        assertTrue("The page should have passed " + testUrl,pageSource.contains("Passed"));
	}

	/**
	 * closing down the web driver client and restoring key cfwheels files to original state
	 * @throws Exception
	 */
	@AfterClass
	static public void tearDownServices() throws Exception {
		driver.quit();
	}

}
