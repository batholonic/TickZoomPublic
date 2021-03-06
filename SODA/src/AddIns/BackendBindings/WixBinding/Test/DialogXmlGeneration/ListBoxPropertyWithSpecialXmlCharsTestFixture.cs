// <file>
//     <copyright see="prj:///doc/copyright.txt"/>
//     <license see="prj:///doc/license.txt"/>
//     <owner name="Matthew Ward" email="mrward@users.sourceforge.net"/>
//     <version>$Revision: 2785 $</version>
// </file>

using ICSharpCode.WixBinding;
using NUnit.Framework;
using System;
using System.Drawing;
using System.Windows.Forms;
using System.Xml;
using WixBinding;
using WixBinding.Tests.Utils;

namespace WixBinding.Tests.DialogXmlGeneration
{
	[TestFixture]
	public class ListBoxPropertyWithSpecialXmlCharsTestFixture : DialogLoadingTestFixtureBase
	{
		[Test]
		public void UpdateDialogElement()
		{
			WixDocument doc = new WixDocument();
			doc.LoadXml(GetWixXml());
			CreatedComponents.Clear();
			WixDialog wixDialog = doc.GetDialog("WelcomeDialog");
			using (Form dialog = wixDialog.CreateDialog(this)) {
				XmlElement dialogElement = wixDialog.UpdateDialogElement(dialog);
			}
		}

		string GetWixXml()
		{
			return "<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>\r\n" +
				"\t<Fragment>\r\n" +
				"\t\t<UI>\r\n" +
				"\t\t\t<Dialog Id='WelcomeDialog' Height='270' Width='370'>\r\n" +
				"\t\t\t\t<Control Id='ListBox1' Type='ListBox' X='20' Y='187' Width='330' Height='40' Property=\"ListBox'Property\"/>\r\n" +
				"\t\t\t</Dialog>\r\n" +
				"\t\t\t<ListBox Property=\"ListBox'Property\">\r\n" +
				"\t\t\t\t<ListItem Text='first'/>\r\n" +
				"\t\t\t\t<ListItem Text='second'/>\r\n" +
				"\t\t\t</ListBox>\r\n" +
				"\t\t</UI>\r\n" +
				"\t</Fragment>\r\n" +
				"</Wix>";
		}
	}
}
