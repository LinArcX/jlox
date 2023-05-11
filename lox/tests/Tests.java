package lox.tests;

import org.junit.Test;
import static org.junit.Assert.assertEquals;
import lox.src.Scanner;

public class Tests
{
  @Test
  public void testAdd()
  {
    String str = "Junit is working fine";
    assertEquals("Junit is working fine",str);
  }

  @Test
  public void testSaeed()
  {
    String str = "Junit is working fine";
    assertEquals("Junit is working fine",str);

    Scanner scanner = new Scanner("1+2");
	  //List<Token> tokens = scanner.scanTokens();
  }
}
