// <file>
//     <copyright see="prj:///doc/copyright.txt"/>
//     <license see="prj:///doc/license.txt"/>
//     <owner name="Matthew Ward" email="mrward@users.sourceforge.net"/>
//     <version>$Revision: 4257 $</version>
// </file>

using System;
using ICSharpCode.NRefactory;
using ICSharpCode.PythonBinding;
using NUnit.Framework;

namespace PythonBinding.Tests.Converter
{
	/// <summary>
	/// Tests the generation of code to call the class's Main method.
	/// </summary>
	[TestFixture]
	public class GenerateMainMethodCallTestFixture
	{
		string mainMethodWithNoParametersCode = "class Foo\r\n" +
						"{\r\n" +
						"    static void Main()\r\n" +
						"    {\r\n" +
						"    }\r\n" +
						"\r\n" +
						"    static void Stop()\r\n" +
						"    {\r\n" +
						"    }\r\n" +
						"\r\n" +
						"    public void Run()\r\n" +
						"    {\r\n" +
						"    }\r\n" +
						"}";
 
		[Test]
		public void GeneratedMainMethodCallWithNoParametersCode()
		{
			NRefactoryToPythonConverter converter = new NRefactoryToPythonConverter(SupportedLanguage.CSharp);
			converter.IndentString = "  ";
			converter.Convert(mainMethodWithNoParametersCode);
			string code = converter.GenerateMainMethodCall(converter.EntryPointMethods[0]);	
			Assert.AreEqual("Foo.Main()", code);
		}
	}
}
